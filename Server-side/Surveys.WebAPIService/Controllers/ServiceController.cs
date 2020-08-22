using Surveys.BusinessLogic.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Surveys.BusinessLogic.DataAccess;
using System.Collections.Generic;
using Microsoft.AspNetCore.Authorization;
using Surveys.WebAPIService.Services;
using Microsoft.Extensions.Options;
using System.Configuration;
using System.Text;
using System.Security.Cryptography;
using System;
using Surveys.WebAPIService.Models;
using Microsoft.AspNetCore.SignalR;
using Surveys.BusinessLogic.Manager;
using System.Threading;

namespace Surveys.WebAPIService.Controllers
{
    [ApiController, Authorize]
    [Route("[controller]/[action]")]
    public class ServiceController : ControllerBase
    {
        private readonly IServiceManager _manager;
        private readonly AppSettings _opt;
        private readonly IHubContext<HubManager> _hub;

        public ServiceController(IServiceManager manager, IHubContext<HubManager> hub, IOptions<AppSettings> opt)
        {
            _manager = manager;
            _opt = opt.Value;
            _hub = hub;
        }

        #region Login
        public class LoginRequestModel
        {
            public string username { get; set; }
            public string password { get; set; }
        }

        [HttpPost]
        [AllowAnonymous]
        public ActionResult Login([FromBody] LoginRequestModel lrm)
        {
            // FIRST CHECK
            var res = _manager.Login(lrm.username, lrm.password);

            if(res.Data == null)
            {
                return BadRequest("Username or password is incorrect");
            }

            // NEW LOGIN CRED
            var user = UserService.Instance.Authenticate(res.Data, 
                Encoding.ASCII.GetBytes(_opt.JwtTokenSecret));

            if (user.RefreshToken == null || !user.RefreshToken.IsActive)
            {
                //REFRESH
                var randomBytes = new byte[64];
                using (var rngCryptoServiceProvider = new RNGCryptoServiceProvider())
                {
                    rngCryptoServiceProvider.GetBytes(randomBytes);
                }

                user.RefreshToken = new RefreshToken
                {
                    rToken = Convert.ToBase64String(randomBytes),
                    Expires = DateTime.UtcNow.AddDays(7),
                    CreatedBy = user.PID
                };
            }
            var x = _manager.InsertOrUpdateRefreshToken(user.RefreshToken);
            if (x.Success)
            {
                // NEW USER CREDENTIALS (ACCESS & REFRESH TOKEN)
                return Ok(user);
            } 
            else
            {
                return BadRequest(x.Message);
            }
        }

        public class LoginRefreshToken
        {
            public string token { get; set; }
        }

        [HttpPost]
        [AllowAnonymous]
        public ActionResult FastLogin([FromBody] LoginRefreshToken auth)
        {
            var res = _manager.CheckRefreshToken(auth.token);
            if (res.Data == null)
            {
                return BadRequest(res.Message);
            } 
            else
            {
                var user = UserService.Instance.Authenticate(res.Data, 
                    Encoding.ASCII.GetBytes(_opt.JwtTokenSecret));
                return Ok(user);
            }

        }
        #endregion

        #region API
        [HttpGet]

        public ActionResult LoadAllSurveys()
        {
            var surveyItems = _manager.GetAllSurveyEntities();
            return Ok(surveyItems.Data);
        }

        [HttpPost]
        public ActionResult AddPrincipal([FromBody] Principal p)
        {
            var res = _manager.InsertOrUpdatePrincipal(p);
            return Ok(res.Success);
        }

        [HttpGet]
        public ActionResult GetSurveyDetails([FromQuery] int seid)
        {
            var surveyDetails = _manager.GetSurveyDetails(seid);
            if (surveyDetails.Success)
            {
                //var timerManager = new TimerManager(() =>
                //    _hub.Clients.All.SendAsync("transferchartdata" + seid.ToString(),

                //));

                _hub.Clients.All.SendAsync("transferchartdata" + seid.ToString(),
                    _manager.GetRealTimeData(seid).Data);
            }
            return Ok(surveyDetails.Data);
        }

        [HttpPost]
        public ActionResult AddSurveyEntity([FromBody] List<SurveyEntity> lse)
        {
            var res = _manager.InsertOrUpdateSurveyEntity(lse);
            return Ok(res.Success);
        }

        [HttpPost]
        public ActionResult AddSurveyEntity([FromBody] List<SurveyDetail> lsd)
        {
            var res = _manager.InsertOrUpdateSurveyDetail(lsd);
            return Ok(res.Success);
        }

        [HttpPost]
        public ActionResult InsertActualVote([FromBody] List<ActualVote> lav)
        {
            var res = _manager.InsertActualVote(lav);
            return Ok(res.Success);
        }


        #endregion

    }

    public class TimerManager
    {
        private Timer _timer;
        private AutoResetEvent _autoResetEvent;
        private Action _action;

        public DateTime _timerStarted { get; }

        public TimerManager(Action action)
        {
            _action = action;
            _autoResetEvent = new AutoResetEvent(false);
            _timer = new Timer(Execute, _autoResetEvent, 1000, 2000);
            _timerStarted = DateTime.Now;
        }

        public void Execute(object stateInfo)
        {
            _action();

            if ((DateTime.Now - _timerStarted).Seconds > 60)
            {
                _timer.Dispose();
            }
        }
    }
}

﻿using Surveys.BusinessLogic.Interfaces;
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
using System.ComponentModel;
using System.Threading.Tasks;

namespace Surveys.WebAPIService.Controllers
{
    [ApiController, Authorize]
    [Route("[controller]/[action]")]
    public class ServiceController : ControllerBase
    {
        #region Fields

        private readonly IServiceManager _manager;
        private readonly AppSettings _opt;
        private readonly IHubContext<HubManager> _hub;

        #endregion

        public ServiceController(IServiceManager manager, 
            IOptions<AppSettings> opt,
            IHubContext<HubManager> hub)
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

            if(!res.Success)
                return BadRequest(res.Message);
            
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
            if (res.Success)
                return Ok(UserService.Instance.Authenticate(res.Data, 
                    Encoding.ASCII.GetBytes(_opt.JwtTokenSecret)));
            else
                return BadRequest(res.Message);
        }

        [HttpPost]
        [AllowAnonymous]
        public ActionResult AddUser([FromBody] Principal p)
        {
            var res = _manager.InsertOrUpdatePrincipal(p);

            if (res.Success)
                return Ok(res.Data);
            else
                return BadRequest(res.Message);
        }

        #endregion

        #region API
        [HttpGet]
        public ActionResult LoadAllSurveys()
        {
            var res = _manager.LoadAllSurveys();
            if (res.Success)
                return Ok(res.Data);
            else
                return BadRequest(res.Message);
        }

        [HttpGet]
        public ActionResult LoadAllSurveysByUser([FromQuery] int pid)
        {
            var res = _manager.LoadAllSurveysByUser(pid);
            if (res.Success)
                return Ok(res.Data);
            else
                return BadRequest(res.Message);
        }

        [HttpGet]
        public ActionResult LoadAllSurveysExceptUser([FromQuery] int pid)
        {
            var res = _manager.LoadAllSurveysExceptUser(pid);
            if (res.Success)
                return Ok(res.Data);
            else
                return BadRequest(res.Message);
        }

        [HttpDelete]
        public ActionResult DeleteSurvey([FromQuery] int seid)
        {
            var res = _manager.DeleteSurvey(seid);
            if (res.Success)
                return Ok(res.Message);
            else
                return BadRequest(res.Message);
        }
 
        [HttpGet]
        public ActionResult GetSurveyDetails([FromQuery] int seid)
        {
            var res = _manager.GetSurveyDetails(seid);
            if (res.Success)
                return Ok(res.Data);
            else
                return BadRequest(res.Message);
        }

        [HttpPost]
        public ActionResult AddSurveyEntity([FromBody] List<SurveyEntity> lse)
        {
            var res = _manager.InsertOrUpdateSurveyEntity(lse);
            if (res.Success)
            {
                _hub.Clients.All.SendAsync("ServerMessage", "InsertOrUpdateSurveyEntity");
                return Ok(res.Data);
            } else
            {
                return BadRequest(res.Message);
            }                
        }

        [HttpPost]
        public ActionResult InsertActualVote ([FromBody] List<ActualVote> lav)
        {
            var res = _manager.InsertActualVote(lav);
            if (res.Success)
                return Ok(res.Message);
            else
                return BadRequest(res.Message);
        }

        public class OnlyPidParameter 
        {
            public int pid { get; set; }
        }

        [HttpPost]
        public ActionResult Logout ([FromBody] OnlyPidParameter body)
        {
            var res = _manager.Logout(body.pid);
            if (res.Success)
                return Ok(res.Message);
            else
                return BadRequest(res.Message);
        }

        [HttpGet]
        public ActionResult GetUserSubmittedSurveys ([FromQuery] int pid)
        {
            var res = _manager.GetUserSubmittedSurveys(pid);
            if (res.Success)
                return Ok(res.Data);
            else
                return BadRequest(res.Message);
        }

        [HttpGet]
        public ActionResult GetActualVotes ([FromQuery] int seid)
        {
            var res = _manager.GetActualVotes(seid);
            if (res.Success)
                return Ok(res.Data);
            else
                return BadRequest(res.Message);
        }

        [HttpGet]
        public ActionResult GetActualPrincipalForVotes([FromQuery] int seid)
        {
            var res = _manager.GetActualPrincipalForVotes(seid);
            if (res.Success)
                return Ok(res.Data);
            else
                return BadRequest(res.Message);
        }
        #endregion
    }
}

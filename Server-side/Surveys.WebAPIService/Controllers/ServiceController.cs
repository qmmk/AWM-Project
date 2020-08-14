using Surveys.BusinessLogic.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Surveys.BusinessLogic.DataAccess;
using System.Collections.Generic;
using Microsoft.AspNetCore.Authorization;
using Surveys.WebAPIService.Services;
using Microsoft.Extensions.Options;
using System.Configuration;
using System.Text;

namespace Surveys.WebAPIService.Controllers
{
    [ApiController, Authorize]
    [Route("[controller]/[action]")]
    public class ServiceController : ControllerBase
    {
        private readonly IServiceManager _manager;
        private readonly AppSettings _opt;

        public ServiceController(IServiceManager manager, IOptions<AppSettings> opt)
        {
            _manager = manager;
            _opt = opt.Value;
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
            var user = UserService.Instance.Authenticate(res.Data, Encoding.ASCII.GetBytes(_opt.JwtTokenSecret));

            // SAVE CRED RT
            var result = _manager.InsertOrUpdateRefreshToken(user.RefreshToken);

            if (result.Success)
            {
                // NEW USER CREDENTIALS (ACCESS & REFRESH TOKEN)
                return Ok(user);
            } 
            else
            {
                return BadRequest(result.Message);
            }
        }

        [HttpPost]
        [AllowAnonymous]
        public ActionResult FastLogin([FromHeader] string Authorization)
        {
            //var res = _manager.FastLogin(rt);
            return Ok();
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
        #endregion

    }
}

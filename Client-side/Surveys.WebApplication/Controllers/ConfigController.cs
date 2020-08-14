using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Surveys.WebApplication.Helpers;

namespace Surveys.WebApplication.Controllers
{
    [ApiController]
    [Route("[controller]/[action]")]
    public class ConfigController : ControllerBase
    {
        private readonly AppSettings _appSettings;
        public ConfigController(IOptions<AppSettings> settings)
        {
            _appSettings = settings.Value;
        }

        [HttpGet]
        public IActionResult GetOptions()
        {
            return new JsonResult(new
            {
                AppName = _appSettings.AppName,
                WebApiServiceUrl = _appSettings.WebAPIServiceUrl
            });
        }
    }
}

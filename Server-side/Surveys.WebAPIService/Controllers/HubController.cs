using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Hosting;
using Surveys.BusinessLogic.DataAccess;
using Surveys.BusinessLogic.Interfaces;

namespace Surveys.WebAPIService.Controllers
{
    [ApiController, Authorize]
    [Route("[controller]/[action]")]
    public class HubController : ControllerBase
    {
        private readonly IHubContext<NotificationHub> _hub;
        private readonly IServiceManager _manager;

        public HubController(IHubContext<NotificationHub> hub, IServiceManager manager)
        {
            _hub = hub;
            _manager = manager;
        }

        public ActionResult Get()
        {
            var timerManager = new TimerManager(() => _hub.Clients.All.SendAsync("transferchartdata", _manager.GetChartData().Data));








            return Ok(new { Message = "Request Completed" });
        }
    }

    public class TimerManager
    {
        private Timer _timer;
        private AutoResetEvent _autoResetEvent;
        private Action _action;

        public DateTime TimerStarted { get; }

        public TimerManager(Action action)
        {
            _action = action;
            _autoResetEvent = new AutoResetEvent(false);
            _timer = new Timer(Execute, _autoResetEvent, 1000, 2000);
            TimerStarted = DateTime.Now;
        }

        public void Execute(object stateInfo)
        {
            _action();

            if ((DateTime.Now - TimerStarted).Seconds > 60)
            {
                _timer.Dispose();
            }
        }
    }
}

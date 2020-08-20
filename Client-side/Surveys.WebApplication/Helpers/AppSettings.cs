using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Surveys.WebApplication.Helpers
{
    public class AppSettings
    {
        public string AppName { get; set; }
        public string WebAPIServiceUrl { get; set; }
        public string SignalRServiceUrl { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Surveys.BusinessLogic.DataAccess
{
    public class AppSettings
    {
        public string JwtTokenSecret { get; set; }
        public string ConnectionString { get; set; }
    }
}

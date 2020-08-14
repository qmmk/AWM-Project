using Surveys.BusinessLogic.DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Threading.Tasks;

namespace Surveys.WebAPIService.Models
{
    public class UserDTO: Principal
    {
        [DataMember]
        public string AccessToken { get; set; }
    }
}

using System;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace Surveys.BusinessLogic.DataAccess
{
    public class RefreshToken
    {
        [Key]
        [JsonIgnore]
        public int RTID { get; set; }
        public string rToken { get; set; }
        public DateTime Expires { get; set; }

        [JsonIgnore]
        public bool IsExpired => DateTime.UtcNow >= Expires;

        public int CreatedBy { get; set; }
        public DateTime? Revoked { get; set; }

        [JsonIgnore]
        public bool IsActive => Revoked == null && !IsExpired;
    }
}
using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.Text;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace Surveys.BusinessLogic.DataAccess
{
    [DataContract]
    public class Principal
    {
        [Key]
        [DataMember]
        public virtual int PID { get; set; }

        [Required]
        [MaxLength(50)]
        [DataMember]
        public virtual string UserName { get; set; }

        [DataMember]
        [JsonIgnore]
        public virtual string HashedPwd { get; set; }

        [DataMember]
        public virtual string Password { get; set; }

        [DataMember]
        [NotMapped]
        public virtual RefreshToken RefreshToken { get; set; }

        [DataMember]
        public virtual string CustomField01 { get; set; }

        [DataMember]
        public virtual string CustomField02 { get; set; }

        [DataMember]
        public virtual string CustomField03 { get; set; }

        [DataMember]
        public virtual string RoleID { get; set; }
    }
}

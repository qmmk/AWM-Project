using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Runtime.Serialization;
using System.Text;

namespace Surveys.BusinessLogic.DataAccess
{
    [DataContract]
    public class ActualVote
    {
        [Key]
        [DataMember]
        public virtual int AVID { get; set; }

        [DataMember]
        [Required]
        public virtual int PID { get; set; }

        [DataMember]
        [Required]
        public virtual int SDID { get; set; }

        [DataMember]
        public virtual DateTime? RegisteredOn { get; set; }

        [DataMember]
        public virtual string CustomField01 { get; set; }

        [DataMember]
        public virtual string CustomField02 { get; set; }

        [DataMember]
        public virtual string CustomField03 { get; set; }

    }
}

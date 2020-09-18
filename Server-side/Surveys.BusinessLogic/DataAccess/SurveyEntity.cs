using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Runtime.Serialization;
using System.Text;

namespace Surveys.BusinessLogic.DataAccess
{
    [DataContract]
    public class SurveyEntity
    {
        [Key]
        [DataMember]
        public virtual int SEID { get; set; }

        [Required]
        [MaxLength(50)]
        [DataMember]
        public virtual string Title { get; set; }

        [DataMember]
        public virtual string Descr { get; set; }

        [DataMember]
        public virtual bool IsOpen { get; set; }

        [DataMember]
        public virtual int CreatedBy { get; set; }

        [DataMember]
        public virtual List<SurveyDetail> surveyDetails { get; set; }
    }

    public class Submitted
    {
        public virtual int SEID { get; set; }
    }
}

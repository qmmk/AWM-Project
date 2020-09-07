using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Runtime.Serialization;
using System.Text;

namespace Surveys.BusinessLogic.DataAccess
{
    [DataContract]
    public class SurveyDetail
    {
        [Key]
        public int SDID { get; set; }

        [Required]
        public int SEID { get; set; }

        [Required]
        [MaxLength(50)]
        public string Descr { get; set; }
    }
}

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

        [MaxLength(250)]
        public string CustomField01 { get; set; }

        [MaxLength(250)]
        public string CustomField02 { get; set; }

        [MaxLength(250)]
        public string CustomField03 { get; set; }
    }
}

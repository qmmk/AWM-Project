﻿using System;
using System.Collections.Generic;
using System.Text;

namespace Surveys.BusinessLogic.DataAccess
{ 
    public class ChartModel
    {
        public List<int> Data { get; set; }
        public string Label { get; set; }

        public ChartModel()
        {
            Data = new List<int>();
        }
    }

    public class Chart
    {
        public int SEID { get; set; }
        public string Descr { get; set; }
        public int count { get; set; }
    }

    public class ChartMobile
    {
        public int SDID { get; set; }
        public int votes { get; set; }
    }

}

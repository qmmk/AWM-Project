using System;
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
        public int count { get; set; }
    }
}

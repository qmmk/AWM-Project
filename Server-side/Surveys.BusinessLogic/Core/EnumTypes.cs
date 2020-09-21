using System;
using System.Collections.Generic;
using System.Text;

namespace Surveys.BusinessLogic.Core
{
    public static class EnumTypes
    {
        public enum DbErrorCode
        {
            SUCCESS = 0,
            PARTIAL = 1,
            PWD_VERIFICATION_FAILED = 2,
            WRONG_CRED = 3,
            EXCEPTION = 4,
            USER_ALREADY_EXISTS = 5,
            USER_NOT_EXISTS = 6,
            TRANSACTION_ABORTED = 7,
            SURVEY_NOT_EXISTS = 8,
            RT_INVALID = 9,
            RT_NOT_EXISTS = 10,
            DETAIL_NOT_EXISTS = 11,
            USER_ALREADY_VOTED = 12
        }
    }
}

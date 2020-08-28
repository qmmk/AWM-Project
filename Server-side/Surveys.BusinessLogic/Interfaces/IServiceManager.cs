using Surveys.BusinessLogic.DataAccess;
using System;
using System.Collections.Generic;
using System.Text;

namespace Surveys.BusinessLogic.Interfaces
{
    public interface IServiceManager
    {
        ServiceResponse<List<SurveyEntity>> LoadAllSurveys();

        ServiceResponse<List<SurveyEntity>> LoadAllSurveysByUser(int pid);

        ServiceResponse<List<SurveyEntity>> LoadAllSurveysExceptUser(int pid);

        ServiceResponse<List<SurveyEntity>> InsertOrUpdateSurveyEntity(List<SurveyEntity> lse);

        ServiceResponse<List<SurveyDetail>> GetSurveyDetails(int seid);

        ServiceResponse<string> InsertOrUpdateSurveyDetail(List<SurveyDetail> lsd);

        ServiceResponse<Principal> Login(string user, string pwd);

        ServiceResponse<Principal> InsertOrUpdatePrincipal(Principal p);

        ServiceResponse<int> InsertOrUpdateRefreshToken(RefreshToken p);

        ServiceResponse<Principal> CheckRefreshToken(string rToken);

        ServiceResponse<List<ChartModel>> GetRealTimeData();

        ServiceResponse<int> InsertActualVote(List<ActualVote> lav);
    }
}

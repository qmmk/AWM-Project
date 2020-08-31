using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Surveys.BusinessLogic.DataAccess;
using Surveys.BusinessLogic.Interfaces;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Text;


namespace Surveys.BusinessLogic.Manager
{
    public sealed class ServiceManager : IServiceManager, IDisposable
    {
        #region Fields
        private readonly DataContext _context;

        public ServiceManager(DataContext context)
        {
            _context = context;
        }
        
        ~ServiceManager()
        {
            // TODO: override finalizer only if 'Dispose(bool disposing)' has code to free unmanaged resources
            // Do not change this code. Put cleanup code in 'Dispose(bool disposing)' method
            Dispose(false);
            
        }

        public void Dispose()
        {
            // Do not change this code. Put cleanup code in 'Dispose(bool disposing)' method
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        private void Dispose(bool disposing)
        {
            if (disposing)
            {
                // TODO: dispose managed state (managed objects)
                if (_context != null)
                    _context.Dispose();
            }

            // TODO: free unmanaged resources (unmanaged objects) and override finalizer
            // TODO: set large fields to null
        }
        
        #endregion

        #region Call

        public ServiceResponse<Principal> Login(string user, string pwd)
        {
            return _context.Login(user, pwd);
        }

        public ServiceResponse<Principal> InsertOrUpdatePrincipal(Principal p)
        {
            return _context.InsertOrUpdatePrincipal(p);
        }

        public ServiceResponse<int> InsertOrUpdateRefreshToken(RefreshToken p)
        {
            return _context.InsertOrUpdateRefreshToken(p);
        }

        public ServiceResponse<Principal> CheckRefreshToken(string rToken)
        {
            return _context.CheckRefreshToken(rToken);
        }

        public ServiceResponse<List<SurveyEntity>> LoadAllSurveys()
        {
            int pid = -1;
            string cmd = "GETALL";
            return _context.GetAllSurveyEntities(pid, cmd);
        }

        public ServiceResponse<List<SurveyEntity>> LoadAllSurveysByUser(int pid)
        {
            string cmd = "GET_BY_USER";
            return _context.GetAllSurveyEntities(pid, cmd);
        }

        public ServiceResponse<List<SurveyEntity>> LoadAllSurveysExceptUser(int pid)
        {
            string cmd = "EXCEPT";
            return _context.GetAllSurveyEntities(pid, cmd);
        }

        public ServiceResponse<List<SurveyEntity>> InsertOrUpdateSurveyEntity(List<SurveyEntity> lse)
        {
            return _context.InsertOrUpdateSurveyEntity(lse);
        }

        public ServiceResponse<List<SurveyDetail>> GetSurveyDetails(int seid)
        {
            return _context.GetSurveyDetails(seid);
        }

        public ServiceResponse<List<SurveyDetail>> InsertOrUpdateSurveyDetail(List<SurveyDetail> lsd)
        {
            return _context.InsertOrUpdateSurveyDetail(lsd);
        }

        public ServiceResponse<List<ChartModel>> GetRealTimeData()
        {
            return _context.GetRealTimeData();
        }

        public ServiceResponse<int> InsertActualVote(List<ActualVote> lav)
        {
            return _context.InsertActualVote(lav);
        }

        public ServiceResponse<int> Logout(int pid)
        {
            return _context.Logout(pid);
        }

        public ServiceResponse<int> DeleteSurvey(int seid)
        {
            return _context.DeleteSurvey(seid);
        }
        #endregion
    }
}

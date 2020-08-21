using Microsoft.EntityFrameworkCore;
using Surveys.BusinessLogic.DataAccess;
using Surveys.BusinessLogic.Interfaces;
using System;
using System.Collections.Generic;
using System.Text;

namespace Surveys.BusinessLogic.Manager
{
    public sealed class ServiceManager : IServiceManager, IDisposable
    {
        #region Fields
        private readonly DataContext _context;
        private bool disposedValue;

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

        public ServiceResponse<List<SurveyEntity>> GetAllSurveyEntities()
        {
            return _context.GetAllSurveyEntities();
        }

        public ServiceResponse<List<SurveyEntity>> InsertOrUpdateSurveyEntity(List<SurveyEntity> lse)
        {
            return _context.InsertOrUpdateSurveyEntity(lse);
        }

        public ServiceResponse<List<SurveyDetail>> GetSurveyDetails(int seid)
        {
            return _context.GetSurveyDetails(seid);
        }

        public ServiceResponse<string> InsertOrUpdateSurveyDetail(List<SurveyDetail> lsd)
        {
            return _context.InsertOrUpdateSurveyDetail(lsd);
        }

        public ServiceResponse<List<ChartModel>> GetChartData()
        {
            return _context.GetChartData();
        }

        #endregion
    }
}

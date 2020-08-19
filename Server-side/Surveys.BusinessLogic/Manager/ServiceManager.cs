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
        #endregion

        #region Properties
        public ServiceManager(DataContext context)
        {
            _context = context;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        private void Dispose(bool disposing)
        {
            if (disposing)
            {
                if (_context != null)
                    _context.Dispose();
            }
        }
        ~ServiceManager()
        {
            Dispose(false);
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
        #endregion
    }
}

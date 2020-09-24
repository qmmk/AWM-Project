using System;
using System.Collections.Generic;
using Microsoft.Data.SqlClient;
using System.Linq;
using System.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Options;
using static Surveys.BusinessLogic.Core.EnumTypes;
using Surveys.BusinessLogic.Core;

namespace Surveys.BusinessLogic.DataAccess
{
    public partial class DataContext : DbContext
    {
        #region Properties
        private readonly AppSettings _settings;
        public DataContext(DbContextOptions<DataContext> opt, IOptions<AppSettings> settings) : base(opt)
        {
            _settings = settings.Value;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer(_settings.ConnectionString);
            }
        }

        #endregion

        #region STORED PROCEDURE

        #region Principal

        public ServiceResponse<Principal> Login(string user, string pwd)
        {
            ServiceResponse<Principal> sr = new ServiceResponse<Principal>();
            PasswordHasher<Principal> hasher = new PasswordHasher<Principal>();
            Principal p = new Principal();

            try
            {
                using (SqlConnection dbConn = new SqlConnection(_settings.ConnectionString))
                {
                    string sql = @"dbo.usp_ManagePrincipal";

                    using (SqlCommand cmd = new SqlCommand(sql, dbConn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue(@"Command", "GET");
                        cmd.Parameters.AddWithValue(@"Username", user);
                        cmd.Parameters.Add("@ReturnCode", SqlDbType.Int).Direction = ParameterDirection.Output;

                        dbConn.Open();

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            p = dr.Bind<Principal>(); 
                        }

                        switch (Convert.ToInt32(cmd.Parameters["@ReturnCode"].Value))
                        {
                            case (int)DbErrorCode.SUCCESS:
                                PasswordVerificationResult r = hasher.VerifyHashedPassword(p, p.HashedPwd, pwd);
                                if (r.Equals(PasswordVerificationResult.Success))
                                {
                                    p.RefreshToken = GetRefreshToken(p.PID).Data;
                                    sr.Data = p;
                                    sr.Error = DbErrorCode.SUCCESS.ToString();
                                    sr.Message = "Password verification was successful.";
                                    sr.Success = true;
                                }
                                else if (r.Equals(PasswordVerificationResult.SuccessRehashNeeded))
                                {
                                    sr.Data = p;
                                    sr.Error = DbErrorCode.PARTIAL.ToString();
                                    sr.Message = "Deprecated algorithm and should be rehashed and updated.";
                                    sr.Success = true;
                                }
                                else if (r.Equals(PasswordVerificationResult.Failed))
                                {
                                    sr.Data = null;
                                    sr.Error = DbErrorCode.PWD_VERIFICATION_FAILED.ToString();
                                    sr.Message = "Password verification failed.";
                                    sr.Success = false;
                                }
                                break;
                            case (int)DbErrorCode.USER_NOT_EXISTS:
                                sr.Data = null;
                                sr.Error = DbErrorCode.USER_NOT_EXISTS.ToString();
                                sr.Message = "User already exists or wrong credential.";
                                sr.Success = false;
                                break;
                            case (int)DbErrorCode.TRANSACTION_ABORTED:
                            default:
                                sr.Data = null;
                                sr.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                                sr.Message = string.Format("Error occur during login user.");
                                sr.Success = false;
                                break;
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                sr.Data = null;
                sr.Error = DbErrorCode.EXCEPTION.ToString();
                sr.Message = ex.Message;
                sr.Success = false;
            }

            return sr;
        }

        public ServiceResponse<Principal> InsertOrUpdatePrincipal(Principal p)
        {
            ServiceResponse<Principal> sr = new ServiceResponse<Principal>();
            PasswordHasher<Principal> hasher = new PasswordHasher<Principal>();

            try
            {
                using (SqlConnection dbConn = new SqlConnection(_settings.ConnectionString))
                {
                    string sql = @"dbo.usp_ManagePrincipal";

                    using (SqlCommand cmd = new SqlCommand(sql, dbConn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue(@"Command", "ADD");
                        cmd.Parameters.AddWithValue(@"PID", p.PID);
                        cmd.Parameters.AddWithValue(@"Username", p.UserName);
                        cmd.Parameters.AddWithValue(@"HashedPwd", hasher.HashPassword(p, p.Password));
                        cmd.Parameters.AddWithValue(@"RoleID", p.RoleID);
                        cmd.Parameters.Add("@ReturnCode", SqlDbType.Int).Direction = ParameterDirection.Output;

                        dbConn.Open();

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            sr.Data = dr.Bind<Principal>();
                        }

                        switch (Convert.ToInt32(cmd.Parameters["@ReturnCode"].Value))
                        {
                            case (int)DbErrorCode.SUCCESS:
                                sr.Error = DbErrorCode.SUCCESS.ToString();
                                sr.Message = "Returned the user just created.";
                                sr.Success = true;
                                break;
                            case (int)DbErrorCode.USER_ALREADY_EXISTS:
                                sr.Data = null;
                                sr.Error = DbErrorCode.USER_ALREADY_EXISTS.ToString();
                                sr.Message = "User already exists.";
                                sr.Success = false;
                                break;
                            case (int)DbErrorCode.TRANSACTION_ABORTED:
                            default:
                                sr.Data = null;
                                sr.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                                sr.Message = string.Format("Error occur during insert or update user.");
                                sr.Success = false;
                                break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                sr.Data = null;
                sr.Error = DbErrorCode.EXCEPTION.ToString();
                sr.Message = ex.Message;
                sr.Success = false;
            }

            return sr;
        }

        public ServiceResponse<List<int>> GetUserSubmittedSurveys(int pid)
        {
            ServiceResponse<List<int>> sr = new ServiceResponse<List<int>>();
            sr.Data = new List<int>();

            try
            {
                using (SqlConnection dbConn = new SqlConnection(_settings.ConnectionString))
                {
                    string sql = @"dbo.usp_ManagePrincipal";

                    using (SqlCommand cmd = new SqlCommand(sql, dbConn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue(@"Command", "GET_SS");
                        cmd.Parameters.AddWithValue(@"PID", pid);
                        cmd.Parameters.Add("@ReturnCode", SqlDbType.Int).Direction = ParameterDirection.Output;

                        dbConn.Open();

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            sr.Data = dr.BindToList<Submitted>().AsEnumerable().Select(x => x.SEID).ToList();
                        }

                        switch (Convert.ToInt32(cmd.Parameters["@ReturnCode"].Value))
                        {
                            case (int)DbErrorCode.SUCCESS:
                                sr.Error = DbErrorCode.SUCCESS.ToString();
                                sr.Message = string.Format("All surveys already voted from user pid {0}.", pid);
                                sr.Success = true;
                                break;
                            case (int)DbErrorCode.TRANSACTION_ABORTED:
                            default:
                                sr.Data = null;
                                sr.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                                sr.Message = "Error occur during get user submitted surveys.";
                                sr.Success = false;
                                break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                sr.Data = null;
                sr.Error = DbErrorCode.EXCEPTION.ToString();
                sr.Message = ex.Message;
                sr.Success = false;
            }

            return sr;
        }

        public ServiceResponse<List<Voted>> GetActualPrincipalForVotes(int seid)
        {
            ServiceResponse<List<Voted>> sr = new ServiceResponse<List<Voted>>();
            sr.Data = new List<Voted>();

            try
            {
                using (SqlConnection dbConn = new SqlConnection(_settings.ConnectionString))
                {
                    string sql = @"dbo.usp_ManagePrincipal";

                    using (SqlCommand cmd = new SqlCommand(sql, dbConn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue(@"Command", "GET_PV");
                        cmd.Parameters.AddWithValue(@"SEID", seid);
                        cmd.Parameters.Add("@ReturnCode", SqlDbType.Int).Direction = ParameterDirection.Output;

                        dbConn.Open();

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            dr.BindToList<Voted>().AsEnumerable().GroupBy(x => x.SDID).ToList().ForEach(x => {
                                foreach (Voted v in x)
                                {
                                    sr.Data.Add(v);
                                }
                            });
                        }

                        switch (Convert.ToInt32(cmd.Parameters["@ReturnCode"].Value))
                        {
                            case (int)DbErrorCode.SUCCESS:
                                sr.Error = DbErrorCode.SUCCESS.ToString();
                                sr.Message = string.Format("All principal voted for survey {0}.", seid);
                                sr.Success = true;
                                break;
                            case (int)DbErrorCode.TRANSACTION_ABORTED:
                            default:
                                sr.Data = null;
                                sr.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                                sr.Message = "Error occur during get user submitted surveys.";
                                sr.Success = false;
                                break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                sr.Data = null;
                sr.Error = DbErrorCode.EXCEPTION.ToString();
                sr.Message = ex.Message;
                sr.Success = false;
            }

            return sr;
        }
        #endregion

        #region RefreshToken

        public ServiceResponse<int> InsertOrUpdateRefreshToken(RefreshToken rt)
        {
            ServiceResponse<int> sr = new ServiceResponse<int>();

            try
            {
                using (SqlConnection dbConn = new SqlConnection(_settings.ConnectionString))
                {
                    string sql = @"dbo.usp_ManageRefreshToken";

                    using (SqlCommand cmd = new SqlCommand(sql, dbConn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue(@"Command", "RT");
                        cmd.Parameters.AddWithValue(@"rToken", rt.rToken);
                        cmd.Parameters.AddWithValue(@"Expires", rt.Expires);
                        cmd.Parameters.AddWithValue(@"CreatedBy", rt.CreatedBy);
                        cmd.Parameters.Add("@ReturnCode", SqlDbType.Int).Direction = ParameterDirection.Output;

                        dbConn.Open();
                        cmd.ExecuteNonQuery();

                        switch (Convert.ToInt32(cmd.Parameters["@ReturnCode"].Value))
                        {
                            case (int)DbErrorCode.SUCCESS:
                                sr.Data = (int)DbErrorCode.SUCCESS;
                                sr.Error = DbErrorCode.SUCCESS.ToString();
                                sr.Message = "Returned the refresh token.";
                                sr.Success = true;
                                break;
                            case (int)DbErrorCode.USER_NOT_EXISTS:
                                sr.Data = (int)DbErrorCode.USER_NOT_EXISTS;
                                sr.Error = DbErrorCode.USER_NOT_EXISTS.ToString();
                                sr.Message = "The refresh token not exists for this user.";
                                sr.Success = false;
                                break;
                            case (int)DbErrorCode.TRANSACTION_ABORTED:
                            default:
                                sr.Data = (int)DbErrorCode.TRANSACTION_ABORTED;
                                sr.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                                sr.Message = string.Format("Error occur during insert or update refresh token.");
                                sr.Success = false;
                                break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                sr.Data = -1;
                sr.Error = DbErrorCode.EXCEPTION.ToString();
                sr.Message = ex.Message;
                sr.Success = false;
            }

            return sr;
        }

        public ServiceResponse<RefreshToken> GetRefreshToken(int createdBy)
        {
            ServiceResponse<RefreshToken> sr = new ServiceResponse<RefreshToken>();

            try
            {
                using (SqlConnection dbConn = new SqlConnection(_settings.ConnectionString))
                {
                    string sql = @"dbo.usp_ManageRefreshToken";

                    using (SqlCommand cmd = new SqlCommand(sql, dbConn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue(@"Command", "GET");
                        cmd.Parameters.AddWithValue(@"CreatedBy", createdBy);
                        cmd.Parameters.Add("@ReturnCode", SqlDbType.Int).Direction = ParameterDirection.Output;

                        dbConn.Open();

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            sr.Data = dr.Bind<RefreshToken>();
                        }

                        switch (Convert.ToInt32(cmd.Parameters["@ReturnCode"].Value))
                        {
                            case (int)DbErrorCode.SUCCESS:
                                sr.Error = DbErrorCode.SUCCESS.ToString();
                                sr.Message = "Returned the refresh token.";
                                sr.Success = true;
                                break;
                            case (int)DbErrorCode.RT_INVALID:
                                sr.Data = null;
                                sr.Error = DbErrorCode.RT_INVALID.ToString();
                                sr.Message = "The refresh token is invalid.";
                                sr.Success = false;
                                break;
                            case (int)DbErrorCode.RT_NOT_EXISTS:
                                sr.Data = null;
                                sr.Error = DbErrorCode.RT_NOT_EXISTS.ToString();
                                sr.Message = "The refresh token not exists for this user.";
                                sr.Success = false;
                                break;
                            case (int)DbErrorCode.TRANSACTION_ABORTED:
                            default:
                                sr.Data = null;
                                sr.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                                sr.Message = string.Format("Error occur during get refresh token.");
                                sr.Success = false;
                                break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                sr.Data = null;
                sr.Error = DbErrorCode.EXCEPTION.ToString();
                sr.Message = ex.Message;
                sr.Success = false;
            }

            return sr;
        }

        public ServiceResponse<Principal> CheckRefreshToken(string rToken)
        {
            ServiceResponse<Principal> sr = new ServiceResponse<Principal>();
            DataSet ds = new DataSet();

            try
            {
                using (SqlConnection dbConn = new SqlConnection(_settings.ConnectionString))
                {
                    string sql = @"dbo.usp_ManageRefreshToken";
                    using (SqlDataAdapter adapter = new SqlDataAdapter())
                    {
                        using (SqlCommand cmd = new SqlCommand(sql, dbConn))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;

                            cmd.Parameters.AddWithValue(@"Command", "CHECK");
                            cmd.Parameters.AddWithValue(@"rToken", rToken);
                            cmd.Parameters.Add("@ReturnCode", SqlDbType.Int).Direction = ParameterDirection.Output;

                            adapter.SelectCommand = cmd;
                            dbConn.Open();
                            adapter.Fill(ds);

                            switch (Convert.ToInt32(cmd.Parameters["@ReturnCode"].Value))
                            {
                                case (int)DbErrorCode.SUCCESS:
                                    sr.Data = ds.Tables[1].First<Principal>();
                                    sr.Data.RefreshToken = ds.Tables[0].First<RefreshToken>();
                                    sr.Error = DbErrorCode.SUCCESS.ToString();
                                    sr.Message = "Returned the user with refresh token.";
                                    sr.Success = true;
                                    break;
                                case (int)DbErrorCode.RT_INVALID:
                                    sr.Data = null;
                                    sr.Error = DbErrorCode.RT_INVALID.ToString();
                                    sr.Message = "The refresh token is invalid.";
                                    sr.Success = false;
                                    break;
                                case (int)DbErrorCode.TRANSACTION_ABORTED:
                                default:
                                    sr.Data = null;
                                    sr.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                                    sr.Message = string.Format("Error occur during checking refresh token.");
                                    sr.Success = false;
                                    break;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                sr.Data = null;
                sr.Error = DbErrorCode.EXCEPTION.ToString();
                sr.Message = ex.Message;
                sr.Success = false;
            }

            return sr;
        }

        public ServiceResponse<int> Logout(int pid)
        {
            ServiceResponse<int> sr = new ServiceResponse<int>();

            try
            {
                using (SqlConnection dbConn = new SqlConnection(_settings.ConnectionString))
                {
                    string sql = @"dbo.usp_ManageRefreshToken";

                    using (SqlCommand cmd = new SqlCommand(sql, dbConn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue(@"Command", "DELETE");
                        cmd.Parameters.AddWithValue(@"CreatedBy", pid);
                        cmd.Parameters.Add("@ReturnCode", SqlDbType.Int).Direction = ParameterDirection.Output;

                        dbConn.Open();
                        cmd.ExecuteNonQuery();

                        switch (Convert.ToInt32(cmd.Parameters["@ReturnCode"].Value))
                        {
                            case (int)DbErrorCode.SUCCESS:
                                sr.Data = (int)DbErrorCode.SUCCESS;
                                sr.Error = DbErrorCode.SUCCESS.ToString();
                                sr.Message = "Logout successed. Invalidate the refresh token.";
                                sr.Success = true;
                                break;
                            case (int)DbErrorCode.TRANSACTION_ABORTED:
                            default:
                                sr.Data = (int)DbErrorCode.TRANSACTION_ABORTED;
                                sr.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                                sr.Message = string.Format("Error occur during get all survey.");
                                sr.Success = false;
                                break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                sr.Data = -1;
                sr.Error = DbErrorCode.EXCEPTION.ToString();
                sr.Message = ex.Message;
                sr.Success = false;
            }

            return sr;
        }

        #endregion

        #region Survey

        public ServiceResponse<List<SurveyEntity>> GetAllSurveyEntities(int pid, string cm)
        {
            ServiceResponse<List<SurveyEntity>> sr = new ServiceResponse<List<SurveyEntity>>();

            try
            {
                using (SqlConnection dbConn = new SqlConnection(_settings.ConnectionString))
                {
                    string sql = @"dbo.usp_ManageSurvey";

                    using (SqlCommand cmd = new SqlCommand(sql, dbConn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue(@"Command", cm);
                        cmd.Parameters.AddWithValue(@"PID", pid);
                        cmd.Parameters.Add("@ReturnCode", SqlDbType.Int).Direction = ParameterDirection.Output;

                        dbConn.Open();

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            sr.Data = dr.BindToList<SurveyEntity>();
                        }

                        switch (Convert.ToInt32(cmd.Parameters["@ReturnCode"].Value))
                        {
                            case (int)DbErrorCode.SUCCESS:
                                sr.Error = DbErrorCode.SUCCESS.ToString();
                                sr.Message = "Returned all survey entities";
                                sr.Success = true;
                                break;
                            case (int)DbErrorCode.TRANSACTION_ABORTED:
                            default:
                                sr.Data = null;
                                sr.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                                sr.Message = string.Format("Error occur during get all survey.");
                                sr.Success = false;
                                break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                sr.Data = null;
                sr.Error = DbErrorCode.EXCEPTION.ToString();
                sr.Message = ex.Message;
                sr.Success = false;
            }

            return sr;
        }

        public ServiceResponse<List<SurveyEntity>> InsertOrUpdateSurveyEntity(List<SurveyEntity> lse)
        {
            ServiceResponse<List<SurveyEntity>> sr = new ServiceResponse<List<SurveyEntity>>();
            sr.Data = new List<SurveyEntity>();
            foreach (SurveyEntity se in lse)
            {
                try
                {
                    SurveyEntity crse = new SurveyEntity();
                    crse.surveyDetails = new List<SurveyDetail>();

                    using (SqlConnection dbConn = new SqlConnection(_settings.ConnectionString))
                    {
                        string sql = @"dbo.usp_ManageSurvey";

                        using (SqlCommand cmd = new SqlCommand(sql, dbConn))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;

                            cmd.Parameters.AddWithValue(@"Command", "IU_SE");
                            cmd.Parameters.AddWithValue(@"SEID", se.SEID);
                            cmd.Parameters.AddWithValue(@"SDID", se.surveyDetails.Count);
                            cmd.Parameters.AddWithValue(@"Title", se.Title);
                            cmd.Parameters.AddWithValue(@"Descr", se.Descr);
                            cmd.Parameters.AddWithValue(@"IsOpen", se.IsOpen);
                            cmd.Parameters.AddWithValue(@"CreatedBy", se.CreatedBy);
                            cmd.Parameters.Add("@ReturnCode", SqlDbType.Int).Direction = ParameterDirection.Output;

                            dbConn.Open();

                            using (SqlDataReader dr = cmd.ExecuteReader())
                            {
                                crse = dr.Bind<SurveyEntity>();
                            }

                            switch (Convert.ToInt32(cmd.Parameters["@ReturnCode"].Value))
                            {
                                case (int)DbErrorCode.SUCCESS:
                                    foreach (SurveyDetail sd in se.surveyDetails)
                                    {
                                        sd.SEID = crse.SEID;
                                    }

                                    var output = InsertOrUpdateSurveyDetail(se.surveyDetails);
                                    if (output.Success)
                                    {
                                        crse.surveyDetails = output.Data;
                                        sr.Data.Add(crse);
                                    }
                                    break;
                                case (int)DbErrorCode.TRANSACTION_ABORTED:
                                default:
                                    sr.Data = null;
                                    sr.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                                    sr.Message = string.Format("Error occur during insert or update {0} Survey Entity Id", se.SEID);
                                    sr.Success = false;
                                    break;
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    sr.Data = null;
                    sr.Error = DbErrorCode.EXCEPTION.ToString();
                    sr.Message = ex.Message;
                    sr.Success = false;
                }
            }

            sr.Error = DbErrorCode.SUCCESS.ToString();
            sr.Message = "All survey entity with detail inserted or update, operation complete.";
            sr.Success = true;

            return sr;
        }

        public ServiceResponse<List<SurveyDetail>> GetSurveyDetails(int seid)
        {
            ServiceResponse<List<SurveyDetail>> sr = new ServiceResponse<List<SurveyDetail>>();

            try
            {
                using (SqlConnection dbConn = new SqlConnection(_settings.ConnectionString))
                {
                    string sql = @"dbo.usp_ManageSurvey";

                    using (SqlCommand cmd = new SqlCommand(sql, dbConn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue(@"Command", "GET");
                        cmd.Parameters.AddWithValue(@"SEID", seid);
                        cmd.Parameters.Add("@ReturnCode", SqlDbType.Int).Direction = ParameterDirection.Output;

                        dbConn.Open();

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            sr.Data = dr.BindToList<SurveyDetail>();
                        }

                        switch (Convert.ToInt32(cmd.Parameters["@ReturnCode"].Value))
                        {
                            case (int)DbErrorCode.SUCCESS:
                                sr.Error = DbErrorCode.SUCCESS.ToString();
                                sr.Message = "Returned all survey details";
                                sr.Success = true;
                                break;
                            case (int)DbErrorCode.SURVEY_NOT_EXISTS:
                                sr.Data = null;
                                sr.Error = DbErrorCode.SURVEY_NOT_EXISTS.ToString();
                                sr.Message = "SurveyEntity not exists anymore.";
                                sr.Success = false;
                                break;
                            case (int)DbErrorCode.DETAIL_NOT_EXISTS:
                                sr.Data = null;
                                sr.Error = DbErrorCode.DETAIL_NOT_EXISTS.ToString();
                                sr.Message = "SurveyDetail not exists anymore.";
                                sr.Success = false;
                                break;
                            case (int)DbErrorCode.TRANSACTION_ABORTED:
                            default:
                                sr.Data = null;
                                sr.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                                sr.Message = string.Format("Error occur during get {0} Survey Entity Id", seid);
                                sr.Success = false;
                                break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                sr.Data = null;
                sr.Error = DbErrorCode.EXCEPTION.ToString();
                sr.Message = ex.Message;
                sr.Success = false;
            }

            return sr;
        }

        public ServiceResponse<List<SurveyDetail>> InsertOrUpdateSurveyDetail(List<SurveyDetail> lsd)
        {
            ServiceResponse<List<SurveyDetail>> sr = new ServiceResponse<List<SurveyDetail>>();
            sr.Data = new List<SurveyDetail>();

            DataTable dtDetails = new DataTable("SurveyDetailType");
            DataColumn dcSEID = new DataColumn("SEID", typeof(int));
            DataColumn dcSDID = new DataColumn("SDID", typeof(int));
            DataColumn dcDescr = new DataColumn("Descr", typeof(string));
            dtDetails.Columns.Add(dcSEID);
            dtDetails.Columns.Add(dcSDID);
            dtDetails.Columns.Add(dcDescr);

            foreach (SurveyDetail sd in lsd)
            {
                dtDetails.Rows.Add(sd.SEID, sd.SDID, sd.Descr);
            }

            SqlParameter _details = new SqlParameter("@SurveyDetails", dtDetails);
            _details.SqlDbType = SqlDbType.Structured;
            _details.TypeName = "SurveyDetailType";

            try
            {
                using (SqlConnection dbConn = new SqlConnection(_settings.ConnectionString))
                {
                    string sql = @"dbo.usp_ManageSurvey";

                    using (SqlCommand cmd = new SqlCommand(sql, dbConn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue(@"Command", "IU_SD");
                        cmd.Parameters.Add(_details);
                        cmd.Parameters.Add("@ReturnCode", SqlDbType.Int).Direction = ParameterDirection.Output;

                        dbConn.Open();

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            sr.Data = dr.BindToList<SurveyDetail>();
                        }

                        switch (Convert.ToInt32(cmd.Parameters["@ReturnCode"].Value))
                        {
                            case (int)DbErrorCode.SUCCESS:               
                                sr.Error = DbErrorCode.SUCCESS.ToString();
                                sr.Message = "All survey detail inserted or update, operation complete.";
                                sr.Success = true;
                                break;
                            case (int)DbErrorCode.SURVEY_NOT_EXISTS:
                                sr.Data = null;
                                sr.Error = DbErrorCode.SURVEY_NOT_EXISTS.ToString();
                                sr.Message = string.Format("Survey {0} not exists", sr.Data.FirstOrDefault().SEID);
                                sr.Success = false;
                                break;
                            case (int)DbErrorCode.TRANSACTION_ABORTED:
                            default:
                                sr.Data = null;
                                sr.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                                sr.Message = string.Format("Error occur during insert or update {0} Survey Entity Id", sr.Data.FirstOrDefault().SEID);
                                sr.Success = false;
                                break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                sr.Data = null;
                sr.Error = DbErrorCode.EXCEPTION.ToString();
                sr.Message = ex.Message;
                sr.Success = false;
            }

            return sr;
        }

        public ServiceResponse<int> DeleteSurvey(int seid)
        {
            ServiceResponse<int> sr = new ServiceResponse<int>();
            List<SqlParameter> parameters = new List<SqlParameter>();

            parameters.Add(new SqlParameter("Command", "DEL_SE"));
            parameters.Add(new SqlParameter("SEID", seid));
            parameters.Add(new SqlParameter("ReturnCode", SqlDbType.Int, 10,
                ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Current, -1));

            try
            {
                using (SqlConnection dbConn = new SqlConnection(_settings.ConnectionString))
                {
                    string sql = @"dbo.usp_ManageSurvey";

                    using (SqlCommand cmd = new SqlCommand(sql, dbConn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue(@"Command", "DEL_SE");
                        cmd.Parameters.AddWithValue(@"SEID", seid);
                        cmd.Parameters.Add("@ReturnCode", SqlDbType.Int).Direction = ParameterDirection.Output;

                        dbConn.Open();
                        cmd.ExecuteNonQuery();

                        switch (Convert.ToInt32(cmd.Parameters["@ReturnCode"].Value))
                        {
                            case (int)DbErrorCode.SUCCESS:
                                sr.Data = (int)DbErrorCode.SUCCESS;
                                sr.Error = DbErrorCode.SUCCESS.ToString();
                                sr.Message = "Survey entity deleted, operation complete.";
                                sr.Success = true;
                                break;
                            case (int)DbErrorCode.TRANSACTION_ABORTED:
                            default:
                                sr.Data = (int)DbErrorCode.SURVEY_NOT_EXISTS;
                                sr.Error = DbErrorCode.SURVEY_NOT_EXISTS.ToString();
                                sr.Message = "Survey entity already deleted or not exists.";
                                sr.Success = false;
                                break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                sr.Data = (int)DbErrorCode.EXCEPTION;
                sr.Error = DbErrorCode.EXCEPTION.ToString();
                sr.Message = ex.Message;
                sr.Success = false;
            }

            return sr;
        }

        #endregion

        #region ActualVote

        public ServiceResponse<int> InsertActualVote(List<ActualVote> lav)
        {
            ServiceResponse<int> final = new ServiceResponse<int>();

            foreach (ActualVote av in lav)
            {
                ServiceResponse<int> sr = new ServiceResponse<int>();

                try
                {
                    using (SqlConnection dbConn = new SqlConnection(_settings.ConnectionString))
                    {
                        string sql = @"dbo.usp_ManageActualVote";

                        using (SqlCommand cmd = new SqlCommand(sql, dbConn))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;

                            cmd.Parameters.AddWithValue(@"Command", "IU_AV");
                            cmd.Parameters.AddWithValue(@"PID", av.PID);
                            cmd.Parameters.AddWithValue(@"SDID", av.SDID);
                            cmd.Parameters.Add("@ReturnCode", SqlDbType.Int).Direction = ParameterDirection.Output;

                            dbConn.Open();
                            cmd.ExecuteNonQuery();

                            switch (Convert.ToInt32(cmd.Parameters["@ReturnCode"].Value))
                            {
                                case (int)DbErrorCode.SUCCESS:
                                    final.Data++;
                                    continue;
                                case (int)DbErrorCode.USER_NOT_EXISTS:
                                    sr.Data = (int)DbErrorCode.USER_NOT_EXISTS;
                                    sr.Error = DbErrorCode.USER_NOT_EXISTS.ToString();
                                    sr.Message = string.Format("User {0} not exists", av.PID);
                                    sr.Success = false;
                                    return sr;
                                case (int)DbErrorCode.DETAIL_NOT_EXISTS:
                                    sr.Data = (int)DbErrorCode.DETAIL_NOT_EXISTS;
                                    sr.Error = DbErrorCode.DETAIL_NOT_EXISTS.ToString();
                                    sr.Message = string.Format("Survey Detail {0} not exists", av.SDID);
                                    sr.Success = false;
                                    return sr;
                                case (int)DbErrorCode.USER_ALREADY_VOTED:
                                    sr.Data = (int)DbErrorCode.USER_ALREADY_VOTED;
                                    sr.Error = DbErrorCode.USER_ALREADY_VOTED.ToString();
                                    sr.Message = string.Format("User {0} already voted for that survey", av.PID);
                                    sr.Success = false;
                                    return sr;
                                case (int)DbErrorCode.TRANSACTION_ABORTED:
                                default:
                                    sr.Data = (int)DbErrorCode.TRANSACTION_ABORTED;
                                    sr.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                                    sr.Message = string.Format("Error occur during insert actual vote.");
                                    sr.Success = false;
                                    return sr;
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    sr.Data = (int)DbErrorCode.EXCEPTION;
                    sr.Error = DbErrorCode.EXCEPTION.ToString();
                    sr.Message = ex.Message;
                    sr.Success = false;
                }
            }

            if (final.Data == lav.Count())
            {
                final.Data = (int)DbErrorCode.SUCCESS;
                final.Error = DbErrorCode.SUCCESS.ToString();
                final.Message = "Insert all votes";
                final.Success = true;
            }
            else
            {
                final.Data = (int)DbErrorCode.PARTIAL;
                final.Error = DbErrorCode.PARTIAL.ToString();
                final.Message = string.Format("Inserted {0} votes instead of {1}", final.Data, lav.Count());
                final.Success = true;

            }

            return final;
        }

        public ServiceResponse<List<ChartModel>> GetRealTimeData()
        {
            ServiceResponse<List<ChartModel>> sr = new ServiceResponse<List<ChartModel>>();
            List<ChartModel> lct = new List<ChartModel>();

            try
            {
                using (SqlConnection dbConn = new SqlConnection(_settings.ConnectionString))
                {
                    string sql = @"dbo.usp_ManageActualVote";

                    using (SqlCommand cmd = new SqlCommand(sql, dbConn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue(@"Command", "GET_RTD");
                        cmd.Parameters.Add("@ReturnCode", SqlDbType.Int).Direction = ParameterDirection.Output;

                        dbConn.Open();

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            dr.BindToList<Chart>().AsEnumerable().GroupBy(x => x.SEID).ToList().ForEach(x => {
                                int seid = 0;
                                var ct = new ChartModel();

                                foreach (Chart v in x)
                                {
                                    ct.Data.Add(v.count);
                                    seid = v.SEID;
                                }

                                ct.Label = "RealTimeData" + seid.ToString();
                                lct.Add(ct);
                            });
                        }

                        switch (Convert.ToInt32(cmd.Parameters["@ReturnCode"].Value))
                        {
                            case (int)DbErrorCode.SUCCESS:
                                sr.Data = lct;
                                sr.Error = DbErrorCode.SUCCESS.ToString();
                                sr.Message = "Get real time data of survey.";
                                sr.Success = true;
                                break;
                            case (int)DbErrorCode.TRANSACTION_ABORTED:
                            default:
                                sr.Data = null;
                                sr.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                                sr.Message = string.Format("Error occur during get real time data of survey.");
                                sr.Success = false;
                                break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                sr.Data = null;
                sr.Error = DbErrorCode.EXCEPTION.ToString();
                sr.Message = ex.Message;
                sr.Success = false;
            }

            return sr;
        }

        public ServiceResponse<List<ChartMobile>> GetActualVotes(int seid)
        {
            ServiceResponse<List<ChartMobile>> sr = new ServiceResponse<List<ChartMobile>>();

            try
            {
                using (SqlConnection dbConn = new SqlConnection(_settings.ConnectionString))
                {
                    string sql = @"dbo.usp_ManageActualVote";

                    using (SqlCommand cmd = new SqlCommand(sql, dbConn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue(@"Command", "GET_RTD_API");
                        cmd.Parameters.AddWithValue(@"SEID", seid);
                        cmd.Parameters.Add("@ReturnCode", SqlDbType.Int).Direction = ParameterDirection.Output;

                        dbConn.Open();

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            sr.Data = dr.BindToList<ChartMobile>();
                        }

                        switch (Convert.ToInt32(cmd.Parameters["@ReturnCode"].Value))
                        {
                            case (int)DbErrorCode.SUCCESS:
                                sr.Error = DbErrorCode.SUCCESS.ToString();
                                sr.Message = "Get real time data of survey.";
                                sr.Success = true;
                                break;
                            case (int)DbErrorCode.TRANSACTION_ABORTED:
                            default:
                                sr.Data = null;
                                sr.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                                sr.Message = "Error occur during get real time data of survey.";
                                sr.Success = false;
                                break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                sr.Data = null;
                sr.Error = DbErrorCode.EXCEPTION.ToString();
                sr.Message = ex.Message;
                sr.Success = false;
            }

            return sr;
        }

        #endregion

        #endregion

    }
}

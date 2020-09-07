using System;
using System.Collections.Generic;
using Microsoft.Data.SqlClient;
using System.Linq;
using System.Data;
using Microsoft.EntityFrameworkCore;
using System.Reflection;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Options;
using static Surveys.BusinessLogic.Core.EnumTypes;

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

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            //modelBuilder.Entity<SurveyEntity>(e =>)
        }

        public List<List<dynamic>> ExecuteMultipleResults(string sp, SqlParameter[] parameters, params Type[] types)
        {
            List<List<dynamic>> results = new List<List<dynamic>>();
            var connection = this.Database.GetDbConnection();
            var command = connection.CreateCommand();

            command.CommandText = sp;
            command.CommandType = CommandType.StoredProcedure;

            if (parameters != null && parameters.Any()) { command.Parameters.AddRange(parameters); }

            if (command.Connection.State != ConnectionState.Open) { command.Connection.Open(); }

            int counter = 0;
            using (var reader = command.ExecuteReader())
            {
                do
                {
                    var innerResults = new List<dynamic>();

                    if (counter > types.Length - 1) { break; }

                    while (reader.Read())
                    {
                        var item = Activator.CreateInstance(types[counter]);

                        for (int inc = 0; inc < reader.FieldCount; inc++)
                        {
                            Type type = item.GetType();
                            string name = reader.GetName(inc);
                            PropertyInfo property = type.GetProperty(name);

                            if (property != null && name == property.Name)
                            {
                                var value = reader.GetValue(inc);
                                if (value != null && value != DBNull.Value)
                                {
                                    property.SetValue(item, Convert.ChangeType(value, Nullable.GetUnderlyingType(property.PropertyType) ?? property.PropertyType), null);
                                }
                            }
                        }
                        innerResults.Add(item);
                    }
                    results.Add(innerResults);
                    counter++;
                }
                while (reader.NextResult());
                reader.Close();
            }
            return results;
        }

        #endregion

        #region DbSet

        public DbSet<Principal> Principal { get; set; }

        #endregion

        #region Stored Procedure

        public ServiceResponse<Principal> Login(string user, string pwd)
        {
            ServiceResponse<Principal> sr = new ServiceResponse<Principal>();
            PasswordHasher<Principal> hasher = new PasswordHasher<Principal>();

            try
            {
                var u = Principal.FirstOrDefault(x => x.UserName == user);
                if (u != null)
                {
                    PasswordVerificationResult r = hasher.VerifyHashedPassword(u, u.HashedPwd, pwd);
                    if (r.Equals(PasswordVerificationResult.Success))
                    {
                        var t = GetRefreshToken(u.PID).Data;
                        if(t != null)
                        {
                            u.RefreshToken = t;
                        }

                        sr.Data = u;
                        sr.Error = DbErrorCode.SUCCESS.ToString();
                        sr.Message = "Password verification was successful.";
                        sr.Success = true;
                    }
                    else if (r.Equals(PasswordVerificationResult.SuccessRehashNeeded))
                    {
                        sr.Data = u;
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
                } else
                {
                    sr.Data = null;
                    sr.Error = DbErrorCode.WRONG_CRED.ToString();
                    sr.Message = "Username or password is incorrect";
                    sr.Success = false;
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
            List<SqlParameter> parameters = new List<SqlParameter>();

            parameters.Add(new SqlParameter("Command", "ADD"));
            parameters.Add(new SqlParameter("PID", p.PID));
            parameters.Add(new SqlParameter("Username", p.UserName));
            parameters.Add(new SqlParameter("HashedPwd", hasher.HashPassword(p, p.Password)));

            parameters.Add(new SqlParameter("RoleID", p.RoleID));
            parameters.Add(new SqlParameter("ReturnCode", SqlDbType.Int, 10,
                ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Current, -1));

            try
            {
                var result = ExecuteMultipleResults("dbo.usp_ManagePrincipal", parameters.ToArray(), typeof(Principal), typeof(Int32));

                if(result.Count == 2 && result[1][0] == 0)
                {
                    sr.Data = result[0].Select(x => new Principal
                    {
                        PID = x.PID,
                        UserName = x.UserName,
                        RoleID = x.RoleID
                    }).ToList().FirstOrDefault();

                    sr.Error = DbErrorCode.SUCCESS.ToString();
                    sr.Message = "Returned the user just created.";
                    sr.Success = true;
                }
            }
            catch(Exception ex)
            {
                sr.Data = null;
                sr.Error = DbErrorCode.EXCEPTION.ToString();
                sr.Message = ex.Message;
                sr.Success = false;
            }
            
            return sr;
        }

        public ServiceResponse<int> InsertOrUpdateRefreshToken(RefreshToken p)
        {
            ServiceResponse<int> sr = new ServiceResponse<int>();
            List<SqlParameter> parameters = new List<SqlParameter>();

            parameters.Add(new SqlParameter("Command", "RT"));
            parameters.Add(new SqlParameter("rToken", p.rToken));
            parameters.Add(new SqlParameter("Expires", p.Expires));
            parameters.Add(new SqlParameter("CreatedBy", p.CreatedBy));
            parameters.Add(new SqlParameter("Revoked", null));
            parameters.Add(new SqlParameter("ReturnCode", SqlDbType.Int, 10,
                    ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Current, -1));

            try
            {
                var result = ExecuteMultipleResults("dbo.usp_ManageRefreshToken", parameters.ToArray(), typeof(Int32));

                if (result[0][0] == 0)
                {
                    sr.Data = result[0][0];
                    sr.Error = DbErrorCode.SUCCESS.ToString();
                    sr.Message = "Returned the refresh token.";
                    sr.Success = true;
                }
                else if (result[0][0] == 6)
                {
                    sr.Data = result[0][0];
                    sr.Error = DbErrorCode.RT_NOT_EXISTS.ToString();
                    sr.Message = "The refresh token not exists.";
                    sr.Success = false;
                }
                else { }

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
            List<SqlParameter> parameters = new List<SqlParameter>();

            parameters.Add(new SqlParameter("Command", "GET"));
            parameters.Add(new SqlParameter("rToken", null));
            parameters.Add(new SqlParameter("Expires", null));
            parameters.Add(new SqlParameter("CreatedBy", createdBy));
            parameters.Add(new SqlParameter("Revoked", null));
            parameters.Add(new SqlParameter("ReturnCode", SqlDbType.Int, 10,
                    ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Current, -1));

            try
            {
                var result = ExecuteMultipleResults("dbo.usp_ManageRefreshToken", parameters.ToArray(), typeof(RefreshToken), typeof(Int32));

                if(result.Count == 2)
                {
                    switch (result[1][0])
                    {
                        case 0:
                            sr.Data = (RefreshToken)result[0][0];
                            sr.Error = DbErrorCode.SUCCESS.ToString();
                            sr.Message = "Returned the refresh token.";
                            sr.Success = true;
                            return sr;
                        case 10:
                            sr.Data = null;
                            sr.Error = DbErrorCode.RT_NOT_EXISTS.ToString();
                            sr.Message = string.Format("Refresh token not found.");
                            sr.Success = false;
                            return sr;
                        default:
                            sr.Data = null;
                            sr.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                            sr.Message = string.Format("Error occur during getting refresh token");
                            sr.Success = false;
                            return sr;
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
            List<SqlParameter> parameters = new List<SqlParameter>();

            parameters.Add(new SqlParameter("Command", "CHECK"));
            parameters.Add(new SqlParameter("rToken", rToken));
            parameters.Add(new SqlParameter("Expires", null));
            parameters.Add(new SqlParameter("CreatedBy", null));
            parameters.Add(new SqlParameter("Revoked", null));
            parameters.Add(new SqlParameter("ReturnCode", SqlDbType.Int, 10,
                    ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Current, -1));

            try
            {
                var result = ExecuteMultipleResults("dbo.usp_ManageRefreshToken", parameters.ToArray(), typeof(RefreshToken), typeof(Principal), typeof(Int32));

                if(result.Count == 3)
                {
                    switch (result[2][0])
                    {
                        case 0:
                            sr.Data = (Principal)result[1][0];
                            sr.Data.RefreshToken = (RefreshToken)result[0][0];
                            sr.Error = DbErrorCode.SUCCESS.ToString();
                            sr.Message = "Returned the refresh token.";
                            sr.Success = true;
                            return sr;
                        case 9:
                            sr.Data = null;
                            sr.Error = DbErrorCode.RT_INVALID.ToString();
                            sr.Message = string.Format("Refresh token not found.");
                            sr.Success = false;
                            return sr;
                        default:
                            sr.Data = null;
                            sr.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                            sr.Message = string.Format("Error occur during checking refresh token.");
                            sr.Success = false;
                            return sr;
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

        public ServiceResponse<List<SurveyEntity>> GetAllSurveyEntities(int pid, string cmd)
        {
            ServiceResponse<List<SurveyEntity>> sr = new ServiceResponse<List<SurveyEntity>>();
            List<SqlParameter> parameters = new List<SqlParameter>();

            parameters.Add(new SqlParameter("Command", cmd));
            parameters.Add(new SqlParameter("PID", pid));
            parameters.Add(new SqlParameter("ReturnCode", SqlDbType.Int, 10,
                ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Current, -1));

            try
            {
                var result = ExecuteMultipleResults("dbo.usp_ManageSurvey", parameters.ToArray(), typeof(SurveyEntity), typeof(Int32));

                if(result.Count == 2)
                {
                    if (result[1][0] == 0)
                    {
                        sr.Data = result[0].Select(x => new SurveyEntity
                        {
                            SEID = x.SEID,
                            Title = x.Title,
                            Descr = x.Descr,
                            IsOpen = x.IsOpen,
                            CreatedBy = x.CreatedBy
                        }).ToList();

                        sr.Error = DbErrorCode.SUCCESS.ToString();
                        sr.Message = "Returned all survey entities";
                        sr.Success = true;
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
                ServiceResponse<SurveyEntity> sre = new ServiceResponse<SurveyEntity>();
                sre.Data = new SurveyEntity();
                sre.Data.surveyDetails = new List<SurveyDetail>();
                List<SqlParameter> parameters = new List<SqlParameter>();
                parameters.Add(new SqlParameter("Command", "IU_SE"));
                parameters.Add(new SqlParameter("SEID", se.SEID));
                parameters.Add(new SqlParameter("SDID", se.surveyDetails.Count));
                parameters.Add(new SqlParameter("Title", se.Title));
                parameters.Add(new SqlParameter("Descr", se.Descr));
                parameters.Add(new SqlParameter("IsOpen", se.IsOpen));
                parameters.Add(new SqlParameter("CreatedBy", se.CreatedBy));
                parameters.Add(new SqlParameter("ReturnCode", SqlDbType.Int, 10,
                    ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Current, -1));

                try
                {
                    var result = ExecuteMultipleResults("dbo.usp_ManageSurvey", parameters.ToArray(), typeof(SurveyEntity), typeof(Int32));

                    if(result.Count == 2)
                    {
                        if (result[1][0] != 0)
                        {
                            sr.Data = null;
                            sr.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                            sr.Message = string.Format("Error occur during insert or update {0} Survey Entity Id", se.SEID);
                            sr.Success = false;
                            return sr;
                        }
                        else
                        {
                            sre.Data = result[0].Select(x => new SurveyEntity
                            {
                                SEID = x.SEID,
                                Title = x.Title,
                                Descr = x.Descr,
                                IsOpen = x.IsOpen,
                                CreatedBy = x.CreatedBy
                            }).ToList().FirstOrDefault();

                            foreach (SurveyDetail sd in se.surveyDetails)
                            {
                                sd.SEID = sre.Data.SEID;
                            }
                        }
                    }

                    var output = InsertOrUpdateSurveyDetail(se.surveyDetails);
                    if (output.Success)
                    {
                        sre.Data.surveyDetails = output.Data;
                        sr.Data.Add(sre.Data);
                    }
                }
                catch (Exception ex)
                {
                    sre.Data = null;
                    sre.Error = DbErrorCode.EXCEPTION.ToString();
                    sre.Message = ex.Message;
                    sre.Success = false;
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
            List<SqlParameter> parameters = new List<SqlParameter>();

            parameters.Add(new SqlParameter("Command", "GET"));
            parameters.Add(new SqlParameter("SEID", seid));
            parameters.Add(new SqlParameter("ReturnCode", SqlDbType.Int, 10,
                ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Current, -1));

            try
            {
                var result = ExecuteMultipleResults("dbo.usp_ManageSurvey", parameters.ToArray(), typeof(SurveyDetail), typeof(Int32));

                if(result.Count == 2)
                {
                    if (result[1][0] == 0)
                    {
                        sr.Data = result[0].Select(x => new SurveyDetail
                        {
                            SEID = x.SEID,
                            SDID = x.SDID,
                            Descr = x.Descr
                        }).ToList();

                        sr.Error = DbErrorCode.SUCCESS.ToString();
                        sr.Message = "Returned all survey details";
                        sr.Success = true;
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
            ServiceResponse<List<SurveyDetail>> final = new ServiceResponse<List<SurveyDetail>>();
            final.Data = new List<SurveyDetail>();

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

            ServiceResponse<SurveyDetail> sr = new ServiceResponse<SurveyDetail>();
            List<SqlParameter> parameters = new List<SqlParameter>();

            SqlParameter _details = new SqlParameter("@SurveyDetails", dtDetails);
            _details.SqlDbType = SqlDbType.Structured;
            _details.TypeName = "SurveyDetailType";

            parameters.Add(new SqlParameter("Command", "IU_SD"));
            parameters.Add(_details);

            parameters.Add(new SqlParameter("ReturnCode", SqlDbType.Int, 10,
                ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Current, -1));

            try
            {
                var result = ExecuteMultipleResults("dbo.usp_ManageSurvey", parameters.ToArray(), typeof(SurveyDetail), typeof(Int32));

                if (result.Count == 2)
                {
                    switch (result[1][0])
                    {
                        case 0:
                            final.Data = result[0].Select(x => new SurveyDetail
                            {
                                SEID = x.SEID,
                                SDID = x.SDID,
                                Descr = x.Descr
                            }).ToList();
                            break;
                        case 8:
                            final.Data = null;
                            final.Error = DbErrorCode.SURVEY_NOT_EXISTS.ToString();
                            final.Message = string.Format("Survey {0} not exists", final.Data.FirstOrDefault().SEID);
                            final.Success = false;
                            return final;
                        default:
                            final.Data = null;
                            final.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                            final.Message = string.Format("Error occur during insert or update {0} Survey Entity Id", final.Data.FirstOrDefault().SEID);
                            final.Success = false;
                            return final;
                    }
                }
            }
            catch (Exception ex)
            {
                final.Data = null;
                final.Error = DbErrorCode.EXCEPTION.ToString();
                final.Message = ex.Message;
                final.Success = false;
            }

            final.Error = DbErrorCode.SUCCESS.ToString();
            final.Message = "All survey detail inserted or update, operation complete.";
            final.Success = true;

            return final;
        }

        public ServiceResponse<int> InsertActualVote(List<ActualVote> lav)
        {
            ServiceResponse<int> final = new ServiceResponse<int>();

            foreach(ActualVote av in lav)
            {
                ServiceResponse<int> sr = new ServiceResponse<int>();
                List<SqlParameter> parameters = new List<SqlParameter>();
                parameters.Add(new SqlParameter("Command", "IU_AV"));
                parameters.Add(new SqlParameter("PID", av.PID));
                parameters.Add(new SqlParameter("SDID", av.SDID));
                parameters.Add(new SqlParameter("ReturnCode", SqlDbType.Int, 10,
                    ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Current, -1));

                try
                {
                    var result = ExecuteMultipleResults("dbo.usp_ManageActualVote", parameters.ToArray(), typeof(Int32));

                    switch (result[0][0])
                    {
                        case 0:
                            final.Data++; 
                            continue;
                        case 6:
                            sr.Data = result[0][0].ToString();
                            sr.Error = DbErrorCode.SURVEY_NOT_EXISTS.ToString();
                            sr.Message = string.Format("User {0} not exists", av.PID);
                            sr.Success = false;
                            return sr;
                        case 11:
                            sr.Data = result[0][0].ToString();
                            sr.Error = DbErrorCode.DETAIL_NOT_EXISTS.ToString();
                            sr.Message = string.Format("Survey Detail {0} not exists", av.SDID);
                            sr.Success = false;
                            return sr;
                        default:
                            sr.Data = result[0][0].ToString();
                            sr.Error = DbErrorCode.TRANSACTION_ABORTED.ToString();
                            sr.Message = string.Format("Error occur during insert or update {0} Actual Vote Id", av.AVID);
                            sr.Success = false;
                            return sr;
                    }
                }
                catch (Exception ex)
                {
                    sr.Data = (Int32)DbErrorCode.EXCEPTION;
                    sr.Error = DbErrorCode.EXCEPTION.ToString();
                    sr.Message = ex.Message;
                    sr.Success = false;
                }
            }

            if(final.Data == lav.Count())
            {
                final.Error = DbErrorCode.SUCCESS.ToString();
                final.Message = "Insert all votes";
                final.Success = true;
            }
            else
            {
                final.Error = DbErrorCode.PARTIAL.ToString();
                final.Message = string.Format("Inserted {0} votes instead of {1}", final.Data, lav.Count());
                final.Success = true;
                final.Data = (Int32)DbErrorCode.PARTIAL;
            }

            return final;
        }

        public ServiceResponse<List<ChartModel>> GetRealTimeData()
        {
            
            ServiceResponse<List<ChartModel>> sr = new ServiceResponse<List<ChartModel>>();
            var lct = new List<ChartModel>();

            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("Command", "GET_RTD"));
            parameters.Add(new SqlParameter("PID", null));
            parameters.Add(new SqlParameter("SDID", null));
            parameters.Add(new SqlParameter("CustomField01", null));
            parameters.Add(new SqlParameter("CustomField02", null));
            parameters.Add(new SqlParameter("CustomField03", null));
            parameters.Add(new SqlParameter("ReturnCode", SqlDbType.Int, 10,
                ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Current, -1));

            try
            {
                var result = ExecuteMultipleResults("dbo.usp_ManageActualVote", parameters.ToArray(), typeof(Chart), typeof(Int32));

                if (result.Count == 2)
                {
                    if (result[1][0] == 0)
                    {
                        result[0].AsEnumerable().GroupBy(x => x.SEID).ToList().ForEach(x => {
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

                        sr.Data = lct;
                        sr.Error = DbErrorCode.SUCCESS.ToString();
                        sr.Message = "Get real time data of survey";
                        sr.Success = true;
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
            List<SqlParameter> parameters = new List<SqlParameter>();

            parameters.Add(new SqlParameter("Command", "DELETE"));
            parameters.Add(new SqlParameter("rToken", null));
            parameters.Add(new SqlParameter("Expires", null));
            parameters.Add(new SqlParameter("CreatedBy", pid));
            parameters.Add(new SqlParameter("Revoked", null));
            parameters.Add(new SqlParameter("ReturnCode", SqlDbType.Int, 10,
                    ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Current, -1));

            try
            {
                var result = ExecuteMultipleResults("dbo.usp_ManageRefreshToken", parameters.ToArray(), typeof(Int32));

                if (result.Count == 1 && result[0][0] == 0)
                {
                    sr.Data = result[0][0];
                    sr.Error = DbErrorCode.SUCCESS.ToString();
                    sr.Message = "Logout successed. Invalidate the refresh token.";
                    sr.Success = true;
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
                var result = ExecuteMultipleResults("dbo.usp_ManageSurvey", parameters.ToArray(), typeof(Int32));

                if (result.Count == 1)
                {
                    switch (result[0][0]) {
                        case 0:
                            sr.Data = (int)DbErrorCode.SUCCESS;
                            sr.Error = DbErrorCode.SUCCESS.ToString();
                            sr.Message = "Survey entity deleted, operation complete.";
                            sr.Success = true;
                            break;
                        default :
                            sr.Data = (int)DbErrorCode.SURVEY_NOT_EXISTS;
                            sr.Error = DbErrorCode.SURVEY_NOT_EXISTS.ToString();
                            sr.Message = "Survey entity already deleted or not exists.";
                            sr.Success = true;
                            break;
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

        public ServiceResponse<List<int>> GetUserSubmittedSurveys(int pid)
        {
            ServiceResponse<List<int>> sr = new ServiceResponse<List<int>>();
            sr.Data = new List<int>();
            List<SqlParameter> parameters = new List<SqlParameter>();

            parameters.Add(new SqlParameter("Command", "GET_SS"));
            parameters.Add(new SqlParameter("PID", pid));
            parameters.Add(new SqlParameter("ReturnCode", SqlDbType.Int, 10,
                ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Current, -1));

            try
            {
                var result = ExecuteMultipleResults("dbo.usp_ManagePrincipal", parameters.ToArray(), typeof(Chart), typeof(Int32));

                if (result.Count == 2 && result[1][0] == 0)
                {
                    result[0].AsEnumerable().ToList().ForEach(x => {
                        sr.Data.Add(x.SEID);
                    });
                    sr.Error = DbErrorCode.SUCCESS.ToString();
                    sr.Message = string.Format("All surveys already voted from user pid {0}.", pid);
                    sr.Success = true;
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

            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("Command", "GET_RTD_API"));
            parameters.Add(new SqlParameter("PID", null));
            parameters.Add(new SqlParameter("SDID", null));
            parameters.Add(new SqlParameter("SEID", seid));
            parameters.Add(new SqlParameter("CustomField01", null));
            parameters.Add(new SqlParameter("CustomField02", null));
            parameters.Add(new SqlParameter("CustomField03", null));
            parameters.Add(new SqlParameter("ReturnCode", SqlDbType.Int, 10,
                ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Current, -1));

            try
            {
                var result = ExecuteMultipleResults("dbo.usp_ManageActualVote", parameters.ToArray(), typeof(ChartMobile), typeof(Int32));

                if (result.Count == 2 && result[1][0] == 0)
                {
                    sr.Data = result[0].Select(x => new ChartMobile
                    {
                          SDID = x.SDID,
                          votes = x.votes
                    }).ToList();
                    sr.Error = DbErrorCode.SUCCESS.ToString();
                    sr.Message = "Get real time data of survey";
                    sr.Success = true;                 
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

    }
}

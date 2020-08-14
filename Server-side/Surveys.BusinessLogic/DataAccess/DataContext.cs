using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Configuration;
using Microsoft.Data.SqlClient;
using System.Dynamic;
using System.IO;
using System.Linq;
using System.Data;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using System.Reflection;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Options;
using System.ComponentModel;

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

        public DbSet<SurveyEntity> SurveyEntity { get; set; }
        public DbSet<SurveyDetail> SurveyDetail { get; set; }
        public DbSet<Principal> Principal { get; set; }

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
                        sr.Data = u;
                        sr.Error = "200";
                        sr.Message = "Password verification was successful.";
                        sr.Success = true;
                    }
                    else if (r.Equals(PasswordVerificationResult.SuccessRehashNeeded))
                    {
                        sr.Data = u;
                        sr.Error = "200";
                        sr.Message = "Deprecated algorithm and should be rehashed and updated.";
                        sr.Success = true;
                    }
                    else if (r.Equals(PasswordVerificationResult.Failed))
                    {
                        sr.Data = null;
                        sr.Error = "400";
                        sr.Message = "Password verification failed.";
                        sr.Success = false;
                    }
                }
            }
            catch (Exception ex)
            {
                sr.Data = null;
                sr.Error = ex.StackTrace;
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
            parameters.Add(new SqlParameter("Username", p.UserName));
            parameters.Add(new SqlParameter("HashedPwd", hasher.HashPassword(p, p.HashedPwd)));
            parameters.Add(new SqlParameter("CustomField01", p.CustomField01));
            parameters.Add(new SqlParameter("CustomField02", p.CustomField02));
            parameters.Add(new SqlParameter("CustomField03", p.CustomField03));
            parameters.Add(new SqlParameter("RoleID", p.RoleID));
            parameters.Add(new SqlParameter("ReturnCode", SqlDbType.Int, 10,
                ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Current, -1));

            try
            {
                var result = ExecuteMultipleResults("dbo.usp_ManagePrincipal", parameters.ToArray(), typeof(Principal), typeof(Int32));

                if (result[1][0] == 0)
                {
                    sr.Data = result[0].Select(x => new Principal
                    {
                        PID = x.PID,
                        UserName = x.UserName,
                        CustomField01 = x.CustomField01,
                        CustomField02 = x.CustomField02,
                        CustomField03 = x.CustomField03,
                        RoleID = x.RoleID
                    }).ToList().FirstOrDefault();

                    sr.Error = "200";
                    sr.Message = "Returned the user just created.";
                    sr.Success = true;
                }
                else if(result[1][0] == 1) 
                {
                    sr.Data = null;
                    sr.Error = "400";
                    sr.Message = "The user already exists.";
                    sr.Success = true;
                }
                else { }

            }
            catch(Exception ex)
            {
                sr.Data = null;
                sr.Error = ex.StackTrace;
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
                    sr.Error = "200";
                    sr.Message = "Returned the user just created.";
                    sr.Success = true;
                }
                else if (result[0][0] == 6)
                {
                    sr.Data = result[0][0];
                    sr.Error = "400";
                    sr.Message = "The user not exists.";
                    sr.Success = false;
                }
                else { }

            }
            catch (Exception ex)
            {
                sr.Data = -1;
                sr.Error = ex.StackTrace;
                sr.Message = ex.Message;
                sr.Success = false;
            }

            return sr;
        }

        public ServiceResponse<List<SurveyEntity>> GetAllSurveyEntities()
        {
            ServiceResponse<List<SurveyEntity>> sr = new ServiceResponse<List<SurveyEntity>>();
            List<SqlParameter> parameters = new List<SqlParameter>();

            parameters.Add(new SqlParameter("Command", "GETALL"));
            parameters.Add(new SqlParameter("ReturnCode", SqlDbType.Int, 10,
                ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Current, -1));

            try
            {
                var result = ExecuteMultipleResults("dbo.usp_ManageSurvey", parameters.ToArray(), typeof(SurveyEntity), typeof(Int32));

                if (result[1][0] == 0) 
                {
                    sr.Data = result[0].Select(x => new SurveyEntity
                    {
                        SEID = x.SEID,
                        Title = x.Title,
                        Descr = x.Descr,
                        CustomField01 = x.CustomField01,
                        CustomField02 = x.CustomField02,
                        CustomField03 = x.CustomField03
                    }).ToList();

                    sr.Error = "200";
                    sr.Message = "Returned all survey entities";
                    sr.Success = true;
                }
                else { }

            }
            catch (Exception ex)
            {
                sr.Data = null;
                sr.Error = ex.StackTrace;
                sr.Message = ex.Message;
                sr.Success = false;
            }

            return sr;
        }

        public ServiceResponse<List<SurveyEntity>> InsertOrUpdateSurveyEntity(List<SurveyEntity> lse)
        {
            foreach(SurveyEntity se in lse)
            {
                ServiceResponse<List<SurveyEntity>> sr = new ServiceResponse<List<SurveyEntity>>();
                List<SqlParameter> parameters = new List<SqlParameter>();
                parameters.Add(new SqlParameter("Command", "IU_SE"));
                parameters.Add(new SqlParameter("SEID", se.SEID));
                parameters.Add(new SqlParameter("SDID", 0));
                parameters.Add(new SqlParameter("Title", se.Title));
                parameters.Add(new SqlParameter("Descr", se.Descr));
                parameters.Add(new SqlParameter("CustomField01", se.CustomField01));
                parameters.Add(new SqlParameter("CustomField02", se.CustomField02));
                parameters.Add(new SqlParameter("CustomField03", se.CustomField03));
                parameters.Add(new SqlParameter("ReturnCode", SqlDbType.Int, 10,
                    ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Current, -1));

                try
                {
                    var result = ExecuteMultipleResults("dbo.usp_ManageSurvey", parameters.ToArray(), typeof(SurveyEntity), typeof(Int32));

                    if (result[1][0] != 0)
                    {
                        sr.Data = null;
                        sr.Error = "Error occur during insert or update " + se.SEID + "Survey Entity Id";
                        sr.Message = "Transaction abort.";
                        sr.Success = false;
                    }
                }
                catch (Exception ex)
                {
                    sr.Data = null;
                    sr.Error = ex.StackTrace;
                    sr.Message = ex.Message;
                    sr.Success = false;
                }
            }


            return GetAllSurveyEntities();
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

                if (result[1][0] == 0)
                {
                    sr.Data = result[0].Select(x => new SurveyDetail
                    {
                        SEID = x.SEID,
                        SDID = x.SDID,
                        Descr = x.Descr,
                        CustomField01 = x.CustomField01,
                        CustomField02 = x.CustomField02,
                        CustomField03 = x.CustomField03
                    }).ToList();

                    sr.Error = "200";
                    sr.Message = "Returned all survey details";
                    sr.Success = true;
                }
                else { }

            }
            catch (Exception ex)
            {
                sr.Data = null;
                sr.Error = ex.StackTrace;
                sr.Message = ex.Message;
                sr.Success = false;
            }

            return sr;
        }

        public ServiceResponse<string> InsertOrUpdateSurveyDetail(List<SurveyDetail> lsd)
        {
            ServiceResponse<string> final = new ServiceResponse<string>();
            foreach (SurveyDetail sd in lsd)
            {
                ServiceResponse<string> sr = new ServiceResponse<string>();
                List<SqlParameter> parameters = new List<SqlParameter>();
                parameters.Add(new SqlParameter("Command", "IU_SE"));
                parameters.Add(new SqlParameter("SEID", sd.SEID));
                parameters.Add(new SqlParameter("SDID", sd.SDID));
                parameters.Add(new SqlParameter("Title", null));
                parameters.Add(new SqlParameter("Descr", sd.Descr));
                parameters.Add(new SqlParameter("CustomField01", sd.CustomField01));
                parameters.Add(new SqlParameter("CustomField02", sd.CustomField02));
                parameters.Add(new SqlParameter("CustomField03", sd.CustomField03));
                parameters.Add(new SqlParameter("ReturnCode", SqlDbType.Int, 10,
                    ParameterDirection.InputOutput, true, 0, 0, "", DataRowVersion.Current, -1));

                try
                {
                    var result = ExecuteMultipleResults("dbo.usp_ManageSurvey", parameters.ToArray(), typeof(SurveyEntity), typeof(Int32));

                    switch (result[1][0])
                    {
                        case 0: continue;
                        case 5:
                            sr.Data = result[1][0].ToString();
                            sr.Error = "Survey " + sd.SEID + " not exists";
                            sr.Message = "Transaction abort.";
                            sr.Success = false;
                            return sr;
                        default:
                            sr.Data = result[1][0].ToString();
                            sr.Error = "Error occur during insert or update " + sd.SEID + "Survey Entity Id";
                            sr.Message = "Transaction abort.";
                            sr.Success = false;
                            return sr;
                    }
                }
                catch (Exception ex)
                {
                    sr.Data = null;
                    sr.Error = ex.StackTrace;
                    sr.Message = ex.Message;
                    sr.Success = false;
                }
            }

            final.Data = "0";
            final.Error = "200";
            final.Message = "Operation complete.";
            final.Success = true;

            return final;
        }
        #endregion

    }
}

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authentication.OAuth;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using Surveys.BusinessLogic.DataAccess;
using Surveys.BusinessLogic.Interfaces;
using Surveys.BusinessLogic.Manager;
using Surveys.WebAPIService.Services;

namespace Surveys.WebAPIService
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            var appSettingsSection = Configuration.GetSection("AppSettings");
            var appSettings = appSettingsSection.Get<AppSettings>();
            services.Configure<AppSettings>(Configuration.GetSection("AppSettings"));

            services.AddControllers();

            services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

            // AddSingleton = same for every request
            // AddScoped = created once per client request
            // Transient = new instance created every time

            
            services.AddDbContext<DataContext>(options =>
                  options.UseSqlServer(appSettings.ConnectionString, o =>
                  {
                      o.EnableRetryOnFailure();
                  })
             );


            //services.AddIdentityServer()
            //    .AddAspNetIdentity<IdentityUser>()
            //    .AddInMemoryApiResources(Configuration.GetApis())
            //    .AddInMemoryIdentityResources(Configuration.GetIdentityResources())
            //    .AddInMemoryClients(Configuration.GetClients())
            //    .AddDeveloperSigningCredential();


            services.AddScoped<IServiceManager, ServiceManager>();

            var key = Encoding.ASCII.GetBytes(appSettings.JwtTokenSecret);
            services.AddAuthentication(x =>
            {
                x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            })
            .AddJwtBearer(x =>
            {
                x.RequireHttpsMetadata = false;
                x.SaveToken = true;
                x.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(key),
                    ValidateIssuer = false,
                    ValidateAudience = false,
                    ClockSkew = TimeSpan.Zero
                };

                // Evento handler del token signalr

                x.Events = new JwtBearerEvents()
                {
                    OnMessageReceived = context =>
                    {
                        var accessToken = context.Request.Query["access_token"];

                        // If the request is for our hub...
                        var path = context.HttpContext.Request.Path;
                        if (!string.IsNullOrEmpty(accessToken) && (path.StartsWithSegments("/hub")))
                        {
                            // Read the token out of the query string
                            context.Token = accessToken;
                        }
                        return Task.CompletedTask;
                    }
                };

                //x.Events.OnAuthenticationFailed = async context => await AuthenticationFailed(context);
                //x.Events.OnForbidden = async context => await AuthorizationFailed(context);
                //x.Events.OnTokenValidated = async context => await ValidationSucceced(context);
            });

            //WithOrigins("https://localhost:44301")
            //Access to XMLHttpRequest at 'https://localhost:44350/hub/negotiate' from origin 'https://localhost:44301' has been blocked by CORS policy

            services.AddCors(options =>
            {
                options.AddDefaultPolicy(builder => { builder.AllowAnyOrigin().AllowAnyHeader().AllowAnyMethod(); });

                options.AddPolicy("hubPolicy", builder => {
                        builder.WithOrigins("https://localhost:44301", "https://localhost:5001").AllowAnyMethod().AllowAnyHeader().AllowCredentials();
                });
            });

            services.AddSignalR(hubOptions =>
            {
                hubOptions.EnableDetailedErrors = true;
            });

            //services.AddHostedService<WorkerService>();

            services.AddSingleton<IUserIdProvider, UserIdProvider>();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseRouting();

            app.UseCors();

            app.UseHttpsRedirection();

            app.UseAuthentication();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                // API REST --> [controller]/[action]
                endpoints.MapControllers();
                endpoints.MapHub<HubManager>("/hub").RequireCors("hubPolicy");
            });
        }
    }
}

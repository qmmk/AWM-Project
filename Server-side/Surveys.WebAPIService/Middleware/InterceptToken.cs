using Microsoft.Owin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Surveys.WebAPIService.Middleware
{
    public class InterceptToken
    {
        //public InterceptToken(OwinMiddleware next) : base(next)
        //{
        //}

        //public override async Task Invoke(IOwinContext context)
        //{
        //    if (context.Request.Path.Value.StartsWith("/signalr"))
        //    {
        //        string bearerToken = context.Request.Query.Get("access_token");
        //        if (bearerToken != null)
        //        {
        //            string[] authorization = { "Bearer " + bearerToken };
        //            context.Request.Headers.Add("Authorization", authorization);
        //        }
        //    }

        //    await Next.Invoke(context);
        //}
    }
}

using System;
using Microsoft.AspNetCore.SignalR;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.Hosting;
using System.Threading;
using Surveys.BusinessLogic.Interfaces;
using Surveys.BusinessLogic.DataAccess;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Threading.Channels;

namespace Surveys.BusinessLogic.Manager
{
    [Authorize]
    public class HubManager : Hub
    {
        private readonly DataContext _context;

        public HubManager(DataContext context)
        {
            _context = context;
        }

        #region Defaults
        
        public override async Task OnConnectedAsync()
        {
            Console.WriteLine($"{ Context.UserIdentifier} joined.");
            await base.OnConnectedAsync();
        }

        public override async Task OnDisconnectedAsync(Exception exception)
        {
            Console.WriteLine($"{Context.UserIdentifier} left.");
            await base.OnDisconnectedAsync(exception);
        }

        #endregion

        public ChannelReader<int> RealTimeDataChart()
        {
            var channel = Channel.CreateUnbounded<int>();
            var cancellationToken = new CancellationToken();

            _ = RealTimeDataChartAsync(channel.Writer, cancellationToken);

            return channel.Reader;
        }

        private async Task RealTimeDataChartAsync(ChannelWriter<int> writer, CancellationToken cancellationToken)
        {
            Exception localException = null;
            try
            {
                while (!cancellationToken.IsCancellationRequested)
                {
                    Console.WriteLine("TRASFERISCO -->");

                    // ALL, GROUP, USER
                    await Clients.All.SendAsync("RealTimeDataChart",
                        _context.GetRealTimeData().Data);

                    // ASPETTO 5 SECONDI
                    await Task.Delay(5000);
                }

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

            writer.Complete(localException);
        }
    }
}

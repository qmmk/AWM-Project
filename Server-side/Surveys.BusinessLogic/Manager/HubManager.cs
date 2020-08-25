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


        //public async IAsyncEnumerable<int> Counter(int count, int delay, [EnumeratorCancellation] CancellationToken cancellationToken)
        //{
        //    for (var i = 0; i < count; i++)
        //    {
        //        // Check the cancellation token regularly so that the server will stop
        //        // producing items if the client disconnects.
        //        cancellationToken.ThrowIfCancellationRequested();

        //        yield return i;

        //        // Use the cancellationToken in other APIs that accept cancellation
        //        // tokens so the cancellation can flow down to them.
        //        await Task.Delay(delay, cancellationToken);
        //    }
        //}

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

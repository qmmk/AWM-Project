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
        /*
        public override async Task OnConnectedAsync()
        {
            await Clients.All.SendAsync("ReceiveSystemMessage", $"{Context.UserIdentifier} joined.");
            await base.OnConnectedAsync();
        }

        public override async Task OnDisconnectedAsync(Exception exception)
        {
            await Clients.All.SendAsync("ReceiveSystemMessage", $"{Context.UserIdentifier} left.");
            await base.OnDisconnectedAsync(exception);
        }

        public async Task SendToUser(string user, string message)
        {
            await Clients.User(user).SendAsync("ReceiveDirectMessage", $"{Context.UserIdentifier}: {message}");
        }

        public async Task Send(int seid)
        {
            Console.WriteLine("TRASFERISCO -->" + seid.ToString());
            await Clients.All.SendAsync($"transferchartdata" + seid.ToString(),
                _context.GetRealTimeData(seid).Data);
        }

        private async Task SendToGroup(string group, string message)
        {
            await Clients.Group(group).SendAsync("ReceiveDirectMessage", $"{Context.UserIdentifier}: {message}");
        }

        public async Task ExecuteAllAsync(CancellationToken stoppingToken, string message, int seid)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                //await Send(message, _context.GetRealTimeData(seid).Data);
                await Task.Delay(1000);
            }
        }

        public async Task ExecuteToUserAsync(CancellationToken stoppingToken, string user, string message)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                await SendToUser(user, message);
                await Task.Delay(1000);
            }
        }

        public async Task ExecuteToGroupAsync(CancellationToken stoppingToken, string group, string message)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                await SendToGroup(group, message);
                await Task.Delay(1000);
            }
        }
        */
        #endregion

        //public async Task RealTimeDataChart()
        //{

        //while (true)
        //{
        //    await Send(seid);
        //    await Task.Delay(15000);
        //}
        //if(Clients != null)
        //{
        //    await Clients.All.SendAsync("transferchartdata2",
        //        _context.GetRealTimeData(2).Data);
        //}

        //while (!stoppingToken.IsCancellationRequested)
        //{
        //    await SendToGroup(group, message);
        //    await Task.Delay(1000);
        //}



        //if (!_rtd.ContainsKey(seid))
        //{
        //    Console.WriteLine("Inizio trasferimento per " + seid.ToString());
        //    CancellationTokenSource cts = new CancellationTokenSource();

        //    _rtd.Add(seid, cts);

        //    await ExecuteAllAsync(seid);
        //}

        ////!_rtd[seid].IsCancellationRequested
        //while (!token.IsCancellationRequested)
        //{
        //    Console.WriteLine("TRASFERISCO -->" + seid.ToString());
        //    await Clients.All.SendAsync("transferchartdata" + seid.ToString(),
        //        _context.GetRealTimeData(seid).Data);

        //    // ASPETTO 5 SECONDI
        //    await Task.Delay(10000);
        //}
        //}

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

        public ChannelReader<int> RealTimeDataChart(int seid)
        {
            var channel = Channel.CreateUnbounded<int>();
            var cancellationToken = new CancellationToken();

            // We don't want to await WriteItemsAsync, otherwise we'd end up waiting 
            // for all the items to be written before returning the channel back to
            // the client.
            _ = WriteItemsAsync(channel.Writer, seid, cancellationToken);

            return channel.Reader;
        }

        private async Task WriteItemsAsync(ChannelWriter<int> writer, int seid, CancellationToken cancellationToken)
        {
            Exception localException = null;
            try
            {
                //for (var i = 0; i < count; i++)
                //{
                //    await writer.WriteAsync(i, cancellationToken);

                //    // Use the cancellationToken in other APIs that accept cancellation
                //    // tokens so the cancellation can flow down to them.
                //    await Task.Delay(delay, cancellationToken);
                //}
                while (!cancellationToken.IsCancellationRequested)
                {
                    Console.WriteLine("TRASFERISCO -->" + seid.ToString());
                    await Clients.All.SendAsync("transferchartdata" + seid.ToString(),
                        _context.GetRealTimeData(seid).Data);

                    // ASPETTO 5 SECONDI
                    await Task.Delay(5000);
                }

            }
            catch (Exception ex)
            {
                localException = ex;
            }

            writer.Complete(localException);
        }

        //public async Task CloseSurvey(int seid)
        //{
        //    if (_rtd.ContainsKey(seid))
        //    {
        //        //CONTROLLI
        //        // 1- votazioni chiuse 
        //        // 2- nessun listener

        //        _rtd[seid].Cancel();
        //        _rtd[seid].Dispose();
        //        _rtd.Remove(seid);

        //    }

        //    await Task.Delay(1000);
        //}

    }
}

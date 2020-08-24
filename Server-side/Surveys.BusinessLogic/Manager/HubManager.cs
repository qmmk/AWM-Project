using System;
using Microsoft.AspNetCore.SignalR;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.Hosting;
using System.Threading;
using Surveys.BusinessLogic.Interfaces;
using Surveys.BusinessLogic.DataAccess;
using System.Collections.Generic;

namespace Surveys.BusinessLogic.Manager
{
    [Authorize]
    public class HubManager : Hub
    {
        private readonly DataContext _context;
        protected Dictionary<int, CancellationTokenSource> _rtd;

        public HubManager(DataContext context)
        {
            _context = context;
            _rtd = new Dictionary<int, CancellationTokenSource>();
        }

        #region Defaults

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

        public async Task Send(string message, object obj)
        {
            await Clients.All.SendAsync($"{message}", obj);
        }

        private async Task SendToGroup(string group, string message)
        {
            await Clients.Group(group).SendAsync("ReceiveDirectMessage", $"{Context.UserIdentifier}: {message}");
        }

        public async Task ExecuteAllAsync(CancellationToken stoppingToken, string message, object obj)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                await Send(message, obj);
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

        #endregion

        public async Task RealTimeDataChart(int seid)
        {
            int i = 0;
            if (!_rtd.ContainsKey(seid))
            {
                Console.WriteLine("Inizio trasferimento per " + seid.ToString());
                CancellationTokenSource cts = new CancellationTokenSource();

                _rtd.Add(seid, cts);

                while (!_rtd[seid].IsCancellationRequested && i != 5)
                {
                    Console.WriteLine("TRASFERISCO -->" + seid.ToString());
                    await Clients.All.SendAsync("transferchartdata" + seid.ToString(),
                        _context.GetRealTimeData(seid).Data);


                    i++;

                    // ASPETTO 5 SECONDI
                    await Task.Delay(5000);
                }

                Console.WriteLine("Cancellazione richiesta per " + seid.ToString());
            }

        }

        public async Task CloseSurvey(int seid)
        {
            if (_rtd.ContainsKey(seid))
            {
                //CONTROLLI
                // 1- votazioni chiuse 
                // 2- nessun listener

                _rtd[seid].Cancel();
                _rtd[seid].Dispose();
                _rtd.Remove(seid);

            }

            await Task.Delay(1000);
        }

    }
}

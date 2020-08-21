using System;
using Microsoft.AspNetCore.SignalR;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.Hosting;
using System.Threading;
using Surveys.BusinessLogic.Interfaces;

namespace Surveys.BusinessLogic.Manager
{
    [Authorize]
    public class HubManager : Hub
    {
        
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
    }


}

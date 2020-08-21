using System;
using Microsoft.AspNetCore.SignalR;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.Hosting;
using System.Threading;

namespace Surveys.BusinessLogic.DataAccess
{
    [Authorize]
    public class NotificationHub: Hub
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

        public async Task Send(string message)
        {
            await Clients.All.SendAsync("ReceiveChatMessage", $"{Context.UserIdentifier}: {message}");
        }

        public async Task ExecuteAllAsync(CancellationToken stoppingToken, string message)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                await Clients.All.SendAsync("ReceiveChatMessage", $"{Context.UserIdentifier}: {message}");
                await Task.Delay(1000);
            }
        }

        public async Task ExecuteToUserAsync(CancellationToken stoppingToken, string message, string user)
        {
            while (!stoppingToken.IsCancellationRequested)
            {
                await Clients.User(user).SendAsync("ReceiveDirectMessage", $"{Context.UserIdentifier}: {message}"); ;
                await Task.Delay(1000);
            }
        }
    }


}

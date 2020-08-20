import { Injectable } from '@angular/core';
import * as signalR from "@aspnet/signalr";
import { ChartModel } from '../models/ChartModel';
import { ConfigurationService } from './configuration.service';

@Injectable({
  providedIn: 'root'
})
export class SignalRService {
  public data: ChartModel[];
  public bradcastedData: ChartModel[];
  private hubConnection: signalR.HubConnection

  constructor( private configService: ConfigurationService) {}

  public startConnection = () => {
    this.hubConnection = new signalR.HubConnectionBuilder()
      .withUrl(this.configService.serverSettings.signalRServiceUrl).build();

    this.hubConnection.start().then(() => console.log('Connection started')).catch(
      err => console.log('Error while starting connection: ' + err));
  }

  public stopConnection = () => {
    if (this.hubConnection.state === signalR.HubConnectionState.Connected) {
      this.hubConnection.stop().then(() => console.log('Connection stopped')).catch(
        err => console.log('Error while stopping connection: ' + err));
    }
  }

  public addTransferChartDataListener = () => {
    this.hubConnection.on('transferchartdata', (data) => {
      this.data = data;
      //console.log(data);
    });
  }

  public broadcastChartData = () => {
    this.hubConnection.invoke('broadcastchartdata', this.data)
      .catch(err => console.error(err));
  }

  public addBroadcastChartDataListener = () => {
    this.hubConnection.on('broadcastchartdata', (data) => {
      this.bradcastedData = data;
    })
  }
}

import { Injectable } from '@angular/core';
import * as signalR from "@aspnet/signalr";
import { ChartModel } from '../models/ChartModel';
import { ConfigurationService } from './configuration.service';

@Injectable({
  providedIn: 'root'
})
export class SignalRService {
  public data: any[] = [];
  public bradcastedData: ChartModel[];
  private hubConnection: signalR.HubConnection

  constructor( private configService: ConfigurationService) {}

  public startConnection = () => {
    if (!this.isConnected()) {
      let currentUser = JSON.parse(localStorage.getItem('currentUser'));
      this.hubConnection = new signalR.HubConnectionBuilder()
        .withUrl(this.configService.serverSettings.signalRServiceUrl,
          { accessTokenFactory: () => currentUser.accessToken }).build();

      this.hubConnection.start().then(() => console.log('Connection started')).catch(
        err => console.log('Error while starting connection: ' + err));
    }
  }

  public stopConnection = () => {
    if (this.isConnected()) {
      this.hubConnection.stop().then(() => console.log('Connection stopped')).catch(
        err => console.log('Error while stopping connection: ' + err));
    }
  }

  public isConnected = () => {
    if (typeof this.hubConnection !== "undefined") {
      return this.hubConnection.state === (signalR.HubConnectionState.Connected) ? true : false;
    }
    return false;
  }

  public addTransferChartDataListener = (seid: number) => {
    this.hubConnection.stream("RealTimeDataChart", seid).subscribe({
      next: (item) => {
        console.log("ITEM - ", item);
      },
      complete: () => {
        console.log("COMPLETE");
      },
      error: (err) => {
        console.log("ERRORE - ", err);    
      },
      });


    this.hubConnection.on('transferchartdata' + seid.toString(), (data) => {
      this.data[seid] = data;
    });
  }

  public delTransferChartDataListener = (seid: number) => {
    this.hubConnection.off('transferchartdata' + seid.toString());
  }
}

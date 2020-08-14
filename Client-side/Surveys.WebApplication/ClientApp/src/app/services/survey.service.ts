import { Injectable } from "@angular/core";
import { ConfigurationService } from './configuration.service';
import { HttpClient, HttpParams } from '@angular/common/http';

@Injectable()
export class SurveyService {
  serviceUrl: string;

  constructor(private configService: ConfigurationService, private http: HttpClient) {
    this.configService.OnSettingsLoaded.subscribe(() => {
      this.serviceUrl = this.configService.serverSettings.webApiServiceUrl;
    });
  }

  public async LoadAllSurveys() {
    return await this.http.get<any>(`${this.serviceUrl}/LoadAllSurveys`).toPromise();
  }

  public async GetSurveyDetails(seid: number) {
    return await this.http.get<any>(`${this.serviceUrl}/GetSurveyDetails?seid=${seid}`).toPromise();
  }
}

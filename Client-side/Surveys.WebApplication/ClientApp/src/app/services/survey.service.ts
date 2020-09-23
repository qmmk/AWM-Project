import { Injectable } from "@angular/core";
import { ConfigurationService } from './configuration.service';
import { HttpClient, HttpParams } from '@angular/common/http';
import { SurveyEntity } from '../models/SurveyEntity';
import { SurveyDetail } from '../models/SurveyDetail';

@Injectable()
export class SurveyService {
  serviceUrl: string;

  constructor(private configService: ConfigurationService, private http: HttpClient) {
    this.configService.OnSettingsLoaded.subscribe(() => {
      this.serviceUrl = this.configService.serverSettings.webApiServiceUrl;
    });
  }

  public async LoadAllSurveys() {
    return await this.http.get<SurveyEntity[]>(`${this.serviceUrl}/LoadAllSurveys`).toPromise<SurveyEntity[]>();
  }

  public async GetSurveyDetails(seid: number) {
    return await this.http.get<SurveyDetail[]>(`${this.serviceUrl}/GetSurveyDetails?seid=${seid}`).toPromise<SurveyDetail[]>();
  }
}

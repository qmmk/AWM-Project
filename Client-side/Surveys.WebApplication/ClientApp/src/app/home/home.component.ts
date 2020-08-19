import { Component } from '@angular/core';
import { SurveyEntity } from '../models/SurveyEntity';
import { SurveyDetail } from '../models/SurveyDetail';
import { SurveyService } from '../services/survey.service';
import { ReplaySubject } from 'rxjs';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
})
export class HomeComponent {
  public surveys: SurveyEntity[];
  public details: SurveyDetail[];




  public chartOptions: any = {
    scaleShowVerticalLines: true,
    responsive: true,
    scales: {
      yAxes: [{
        ticks: {
          beginAtZero: true
        }
      }]
    }
  };
  public chartLabels: string[] = ['Real time data for the chart'];
  public chartType: string = 'bar';
  public chartLegend: boolean = true;
  public colors: any[] = [{ backgroundColor: '#5491DA' }, { backgroundColor: '#E74C3C' }, { backgroundColor: '#82E0AA' }, { backgroundColor: '#E5E7E9' }]
  public chartData: any[] = [
    { Data: 5, Label: "Data1" },
    { Data: 40, Label: "Data2" },
    { Data: 17, Label: "Data3" },
    { Data: 30, Label: "Data4" }
  ]






  ready$: ReplaySubject<boolean> = new ReplaySubject<boolean>(1);
  ready: boolean = false;

  constructor(private service: SurveyService) { this.load(); }

  load() {
    return this.service.LoadAllSurveys().then((response) => {
      this.surveys = response;
      this.ready = true;
      this.ready$.next(true);
    });
  }

  async onDetail(seid: number) {
    try {
      this.details = await this.service.GetSurveyDetails(seid);
    }
    catch (e) { }
  }
}

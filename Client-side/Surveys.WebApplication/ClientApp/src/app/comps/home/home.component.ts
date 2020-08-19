import { Component, OnInit } from '@angular/core';
import { SurveyEntity } from '../../models/SurveyEntity';
import { SurveyDetail } from '../../models/SurveyDetail';
import { SurveyService } from '../../services/survey.service';
import { ReplaySubject } from 'rxjs';
import { SignalRService } from '../../services/signalr.service';
import { HttpClient } from '@angular/common/http';


@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
  public surveys: SurveyEntity[];
  public details: SurveyDetail[];
  public charts: string[] = ["A", "B"];
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
  public chartLabels: string[];
  public chartType: string = 'horizontalBar';
  public chartLegend: boolean = true;
  public colors: any[] = [{ backgroundColor: '#5491DA' },
    { backgroundColor: '#E74C3C' },
    { backgroundColor: '#82E0AA' },
    { backgroundColor: '#E5E7E9' }]

  ready$: ReplaySubject<boolean> = new ReplaySubject<boolean>(1);
  ready: boolean = false;
  showDetail: boolean[] = [false];

  constructor(private service: SurveyService,
    public signalRService: SignalRService,
    private http: HttpClient) { this.load(); }

    ngOnInit(): void {
      this.signalRService.startConnection();
      this.signalRService.addTransferChartDataListener();
      this.signalRService.addBroadcastChartDataListener();
      this.startHttpRequest();
    }

  load() {
    return this.service.LoadAllSurveys().then((response) => {
      this.surveys = response;
      this.ready = true;
      this.ready$.next(true);
    });
  }

  onDetail(seid: number) {
    return this.service.GetSurveyDetails(seid).then((res: SurveyDetail[]) => {
      this.showDetail[seid] = !this.showDetail[seid];
      res.forEach(x => {
        this.chartLabels.push(x.descr);
      });
      this.ready = true;
      this.ready$.next(true);
    });
  }

  private startHttpRequest = () => {
    this.http.get('https://localhost:44350/api/chart')
      .subscribe(res => {
        console.log(res);
      })
  }

  public chartClicked = (event) => {
    console.log(event);
    this.signalRService.broadcastChartData();
  }
}

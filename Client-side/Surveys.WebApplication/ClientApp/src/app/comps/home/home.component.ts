import { Component, OnInit, ViewChild  } from '@angular/core';
import { SurveyEntity } from '../../models/SurveyEntity';
import { SurveyDetail } from '../../models/SurveyDetail';
import { SurveyService } from '../../services/survey.service';
import { ReplaySubject } from 'rxjs';
import { SignalRService } from '../../services/signalr.service';
import { HttpClient } from '@angular/common/http';
import { ChartOptions, ChartType, ChartDataSets } from 'chart.js';
import { Label, Color, BaseChartDirective  } from 'ng2-charts';


@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
  public surveys: SurveyEntity[];
  public details: SurveyDetail[];
  public charts: string[] = ["A", "B"];

  // CHART CONFIG
  public chartOptions: ChartOptions = {
    responsive: true,
    scales: {
      yAxes: [{
        ticks: {
          beginAtZero: true
        }
      }]
    }
  };
  public chartLabels: Label[] = [];
  public chartType: ChartType = 'horizontalBar';
  public chartLegend: boolean = false;
  public colors: any[] = [
    {
      backgroundColor: [
        'rgba(255,0,0,0.5)',
        'rgba(0,255,0,0.5)',
        'rgba(0,0,255,0.5)'
      ]
    }
  ];

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
    /*
    // parte la connessione
    this.signalRService.startConnection();

    // azione INVOKE
    this.signalRService.addTransferChartDataListener();

    // azione ON
    this.signalRService.addBroadcastChartDataListener();

    // bo
    this.startHttpRequest();
    */

    return this.service.GetSurveyDetails(seid).then((res: SurveyDetail[]) => {
      this.showDetail[seid] = !this.showDetail[seid];
      if (this.showDetail[seid]) {
        res.forEach(x => {
          this.chartLabels.push(x.descr as Label);
        });
      }

      this.ready = true;
      this.ready$.next(true);
    });
    
  }

  private startHttpRequest = () => {
    this.http.get('https://localhost:44350/hub/Get')
      .subscribe(res => {
        console.log(res);
      })
  }

  public chartClicked = (event) => {
    console.log(event);
    this.signalRService.broadcastChartData();
  }
}

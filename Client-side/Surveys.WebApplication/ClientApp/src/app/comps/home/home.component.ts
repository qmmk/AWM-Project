import { Component, OnInit, ViewChild, OnDestroy  } from '@angular/core';
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
export class HomeComponent implements OnInit, OnDestroy {
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
        'rgba(255, 0, 0, 0.5)',
        'rgba(0, 255, 0, 0.5)',
        'rgba(0, 0, 255, 0.5)',
        'rgba(255, 255, 0, 0.5)',
        'rgba(148, 0, 211, 0.5)',
        'rgba(255, 127, 80, 0.5)',
        'rgba(192, 192, 192, 0.5)',
        'rgba(0, 255, 255, 0.5)'
      ]
    }
  ];

  ready$: ReplaySubject<boolean> = new ReplaySubject<boolean>(1);
  ready: boolean = false;
  showDetail: boolean[] = [false];

  constructor(private service: SurveyService,
    public signalRService: SignalRService) { this.load(); }

  ngOnInit(): void {   
      this.signalRService.startConnection();
      
      //this.signalRService.addBroadcastChartDataListener();
  }

  ngOnDestroy(): void {
      this.signalRService.stopConnection();
  }

  load() {
    return this.service.LoadAllSurveys().then((response) => {
      this.surveys = response;
      this.ready = true;
      this.ready$.next(true);
    });
  }

  onDetail(seid: number) {
    
    // azione ON
    //this.signalRService.addBroadcastChartDataListener();
    
    this.showDetail[seid] = !this.showDetail[seid];

    if (this.showDetail[seid]) {
      this.signalRService.addTransferChartDataListener(seid);

      return this.service.GetSurveyDetails(seid).then((res: SurveyDetail[]) => {
        res.forEach(x => {
          if (!this.chartLabels.includes(x.descr as Label)) {
            this.chartLabels.push(x.descr as Label);
          }
        });
        this.ready = true;
        this.ready$.next(true);
      });
    } else {
      // stoppo la connesione real time
      this.signalRService.delTransferChartDataListener(seid);
    }
  }

  public chartClicked = (event) => {
    console.log(event);
    this.signalRService.broadcastChartData();
  }
}

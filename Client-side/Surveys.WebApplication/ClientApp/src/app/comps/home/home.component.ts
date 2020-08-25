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
      xAxes: [{
        ticks: {
          beginAtZero: true
        }
      }]
    }
  };
  public chartLabels: any[][] = [];
  public labels: Label[] = [];
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
  }

  ngOnDestroy(): void {
    this.signalRService.delTransferChartDataListener();
  }

  load() {
    return this.service.LoadAllSurveys().then((response) => {
      this.surveys = response;
      this.ready = true;
      this.ready$.next(true);
    });
  }

  onDetail(seid: number, i: number) {
    this.showDetail[seid] = !this.showDetail[seid];

    if (this.showDetail[seid]) {
      this.signalRService.addTransferChartDataListener(seid, i);

      return this.service.GetSurveyDetails(seid).then((res: SurveyDetail[]) => {
        res.forEach(x => {
          if (typeof this.chartLabels[seid] !== 'undefined') {
            if (!this.chartLabels[seid].includes(x.descr as Label)) {
              this.chartLabels[seid].push(x.descr as Label);
            }
          } else {
            this.labels.push(x.descr as Label);
          }
        });

        if (typeof this.chartLabels[seid] == 'undefined') {
          this.chartLabels[seid] = this.labels;
          this.labels = [];
        }

        this.ready = true;
        this.ready$.next(true);
      });
    }
  }
}

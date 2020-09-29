import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { SignalRService } from '../../services/signalr.service';
import { NotificationService } from '../../services/notification.service';

@Component({
  selector: 'app-settings',
  templateUrl: './settings.component.html'
})

export class SettingsComponent implements OnInit {
  formGroup: FormGroup;

  constructor(formBuilder: FormBuilder,
    private notifyService: NotificationService,
    private signalr: SignalRService) {
    this.formGroup = formBuilder.group({
      acceptTerms: '',
      enableNotify:'',
      enableRTD: ''
    });
  }

  ngOnInit(): void {
    var sysConfig = JSON.parse(localStorage.getItem('sysConfig'));

    this.formGroup.patchValue({
      acceptTerms: false,
      enableNotify: false,
      enableRTD: false
    });

    if (sysConfig !== null) {
      this.formGroup.patchValue({
        acceptTerms: sysConfig.acceptTerms,
        enableNotify: sysConfig.enableNotify,
        enableRTD: sysConfig.enableRTD
      });
    }
  }

  get f() { return this.formGroup.controls; }

  onFormSubmit() {
    console.log("Form submit", this.formGroup.value);

    localStorage.setItem('sysConfig', JSON.stringify(this.formGroup.value));
    this.notifyService.showSuccess("Impostazioni salvate.", "Successo!");

    if (this.f.enableRTD.value) {
      console.log("START RTD");
      this.signalr.realTimeDataChart();
    } else {
      this.signalr.delTransferChartDataListener();
    }
  }
}

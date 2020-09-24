import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { SurveyService } from '../../services/survey.service';
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
      enableRTD: ''
    });
  }

  ngOnInit(): void {
    var sysConfig = JSON.parse(localStorage.getItem('sysConfig'));

    if (typeof sysConfig !== 'undefined') {
      this.formGroup.patchValue({
        acceptTerms: sysConfig.acceptTerms,
        enableRTD: sysConfig.enableRTD
      });
    }
  }

  get f() { return this.formGroup.controls; }

  onFormSubmit() {
    console.log("Form submit", this.formGroup.value);

    localStorage.setItem('sysConfig', JSON.stringify(this.formGroup.value));
    this.notifyService.showSuccess("Impostazioni salvate.", "Successo!")

    if (this.f.enableRTD.value) {
      console.log("START RTD");
      this.signalr.realTimeDataChart();
    }
  }
}

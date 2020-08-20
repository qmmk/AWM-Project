import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-settings',
  templateUrl: './settings.component.html'
})

export class SettingsComponent implements OnInit {
  formGroup: FormGroup;

  constructor(formBuilder: FormBuilder) {
    this.formGroup = formBuilder.group({
      acceptTerms: '',
      enableRTD: ''
    });
  }

  ngOnInit(): void {

    // LOAD SYSCONFIG

    /*
    this.formGroup.patchValue({
      acceptTerms: false,
      enableRTD: true
    });
    */
  }

  get f() { return this.formGroup.controls; }

  onFormSubmit() {
    //alert(JSON.stringify(this.formGroup.value, null, 2));
    console.log("form submit", this.f.acceptTerms.value, this.f.enableRTD.value);


    // SAVE SYSCONFIG
  }
}

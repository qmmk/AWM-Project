import { Component, NgModule, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterModule, ActivatedRoute } from '@angular/router';
import { FormsModule, ReactiveFormsModule, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { first } from 'rxjs/operators';
import { AuthService } from '../../services/auth.service';
import { ConfigurationService } from '../../services/configuration.service';

@Component({
    selector: 'app-login-form',
    templateUrl: './login-form.component.html',
    styleUrls: ['./login-form.component.scss']
})
export class LoginFormComponent implements OnInit {
  returnUrl: string;
  error: string;
  appName: string;
  loginForm: FormGroup;
  submitted: boolean;
  loading: boolean;

  constructor(private authService: AuthService,
    private configService: ConfigurationService,
    private router: Router,
    private formBuilder: FormBuilder) {
        this.configService.OnSettingsLoaded.subscribe(x => {
            this.appName = this.configService.serverSettings.appName;
        });

  }

  ngOnInit() {
    this.loginForm = this.formBuilder.group({
      inputName: ['', Validators.required],
      inputPassword: ['', Validators.required]
    });
  }

  get f() { return this.loginForm.controls; }

  onSubmit() {
    this.submitted = true;

    if (this.loginForm.invalid) {
      return;
    }

    this.loading = true;
    this.authService.logIn(this.f.inputName.value, this.f.inputPassword.value)
      .pipe(first())
      .subscribe(
        data => {
          this.router.navigate(['/']);
        },
        error => {
          this.error = error.error;
          this.loading = false;
        });
  }
}/*
@NgModule({
    imports: [
        CommonModule,
        RouterModule,
        ReactiveFormsModule,
        FormsModule
    ],
    declarations: [LoginFormComponent],
    exports: [LoginFormComponent]
})
export class LoginFormModule { }
*/

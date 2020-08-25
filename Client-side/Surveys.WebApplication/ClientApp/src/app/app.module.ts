import { BrowserModule, HAMMER_GESTURE_CONFIG, HammerGestureConfig } from '@angular/platform-browser';
import { NgModule, APP_INITIALIZER } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { RouterModule } from '@angular/router';
import { ReactiveFormsModule } from '@angular/forms';
import { ChartsModule } from 'ng2-charts';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';

import { AppComponent } from './app.component';
import { NavMenuComponent } from './comps/nav-menu/nav-menu.component';
import { HomeComponent } from './comps/home/home.component';
import { LoginFormComponent } from './comps/login-form/login-form.component';
import { SettingsComponent } from './comps/settings/settings.component';

import { ConfigurationService } from './services/configuration.service';
import { StorageService } from './services/storage.service';
import { IdentityService } from './services/identity.service';
import { AuthService, AuthGuardService } from './services/auth.service';
import { SurveyService } from './services/survey.service';
import { ErrorInterceptor, JwtInterceptor } from './helpers/interceptor';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { SignalRService } from './services/signalr.service';

@NgModule({
  declarations: [
    AppComponent,
    NavMenuComponent,
    HomeComponent,
    LoginFormComponent,
    SettingsComponent
  ],
  imports: [
    BrowserModule.withServerTransition({ appId: 'ng-cli-universal' }),
    ReactiveFormsModule,
    HttpClientModule,
    FormsModule,
    ChartsModule,
    RouterModule.forRoot([
      {
        path: '',
        component: HomeComponent,
        canActivate: [AuthGuardService],
        pathMatch: 'full'
      },
      {
        path: 'login',
        component: LoginFormComponent
      },
      {
        path: 'settings',
        component: SettingsComponent,
        canActivate: [AuthGuardService]
      }
    ]),
    BrowserAnimationsModule,
    MatSlideToggleModule
  ],
  providers: [AuthService, ConfigurationService, StorageService, IdentityService, AuthGuardService, SurveyService, SignalRService,
    { provide: HTTP_INTERCEPTORS, useClass: JwtInterceptor, multi: true },
    { provide: HTTP_INTERCEPTORS, useClass: ErrorInterceptor, multi: true },
    { provide: APP_INITIALIZER, useFactory: appInit, deps: [ConfigurationService, IdentityService], multi: true },
    { provide: HAMMER_GESTURE_CONFIG, useClass: HammerGestureConfig}],
  bootstrap: [AppComponent]
})
export class AppModule { }

// assicura che prima di inizializzare l'app vengano caricate le configurazioni server minime
export function appInit(config: ConfigurationService) { 
  return async () => {
    await config.load();
    await config.fast();
  }
}

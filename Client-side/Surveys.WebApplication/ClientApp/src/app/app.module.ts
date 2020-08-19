import { BrowserModule } from '@angular/platform-browser';
import { NgModule, APP_INITIALIZER } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { RouterModule } from '@angular/router';
import { ReactiveFormsModule } from '@angular/forms';

import { AppComponent } from './app.component';
import { NavMenuComponent } from './nav-menu/nav-menu.component';
import { HomeComponent } from './home/home.component';
import { CounterComponent } from './counter/counter.component';
import { FetchDataComponent } from './fetch-data/fetch-data.component';
import { LoginFormComponent} from './login-form/login-form.component';

import { ConfigurationService } from './services/configuration.service';
import { StorageService } from './services/storage.service';
import { IdentityService } from './services/identity.service';
import { AuthService, AuthGuardService } from './services/auth.service';
import { SurveyService } from './services/survey.service';
import { ErrorInterceptor, JwtInterceptor } from './helpers/interceptor';


@NgModule({
  declarations: [
    AppComponent,
    NavMenuComponent,
    HomeComponent,
    CounterComponent,
    FetchDataComponent,
    LoginFormComponent
  ],
  imports: [
    BrowserModule.withServerTransition({ appId: 'ng-cli-universal' }),
    ReactiveFormsModule,
    HttpClientModule,
    FormsModule,
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
      
      { path: 'counter', component: CounterComponent },
      { path: 'fetch-data', component: FetchDataComponent }
    ])
  ],
  providers: [AuthService, ConfigurationService, StorageService, IdentityService, AuthGuardService, SurveyService,
    { provide: HTTP_INTERCEPTORS, useClass: JwtInterceptor, multi: true },
    { provide: HTTP_INTERCEPTORS, useClass: ErrorInterceptor, multi: true },
    { provide: APP_INITIALIZER, useFactory: appInit, deps: [ConfigurationService, IdentityService], multi: true }],
  bootstrap: [AppComponent]
})
export class AppModule { }

// assicura che prima di inizializzare l'app vengano caricate le configurazioni server minime
export function appInit(config: ConfigurationService, identity: IdentityService) { 
  return async () => {
    await config.load();
  }
}

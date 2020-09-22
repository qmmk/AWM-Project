import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpErrorResponse } from "@angular/common/http";
import { IConfiguration } from '../models/Config';
import { StorageService } from './storage.service';

import { Observable, Subject, ReplaySubject } from 'rxjs';
import { IdentityService } from './identity.service';

@Injectable()
export class ConfigurationService {
  serverSettings: IConfiguration;
  // observable that is fired when settings are loaded from server
  OnSettingsLoaded: ReplaySubject<void> = new ReplaySubject(1);
  isReady: boolean = false;

  constructor(private http: HttpClient,
    private storageService: StorageService,
    private identityService: IdentityService) { }

  load() {
    const baseURI = document.baseURI.endsWith('/') ? document.baseURI : `${document.baseURI}/`;
    let url = `${baseURI}Config/GetOptions`;
    return new Promise((resolve, reject) => {
      return this.http.get(url).subscribe((response) => {

        this.serverSettings = response as IConfiguration;

        this.storageService.store('appName', this.serverSettings.appName);
        this.storageService.store('webApiServiceUrl', this.serverSettings.webApiServiceUrl);
        this.storageService.store('signalRServiceUrl', this.serverSettings.signalRServiceUrl);

        this.isReady = true;
        this.OnSettingsLoaded.next();
        resolve(true);
      });
    });
  }

  fast() {
    //return new Promise((resolve, reject) => {
    //  if (this.identityService.isLoggedIn) {
    //    let currentUser = JSON.parse(localStorage.getItem('currentUser'));

    //    if (Date.parse(currentUser.refreshToken.expires) >= new Date().getTime()) {
    //      let token = currentUser.refreshToken.rToken;
    //      return this.http.post<any>(`${this.serverSettings.webApiServiceUrl}/FastLogin`, { token })
    //        .subscribe(response => {
    //          // login successful if there's a jwt token in the response
    //          this.identityService.removeUser();

    //          if (response && response.accessToken) {
    //            this.identityService.setUser(response);
    //          }

    //          resolve(true);
    //        });
    //    }
    //  } else {
    //    resolve(true);
    //  }
    //});
  }
}

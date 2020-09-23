import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpErrorResponse } from "@angular/common/http";
import { IConfiguration } from '../models/Config';
import { StorageService } from './storage.service';

import { Observable, Subject, ReplaySubject } from 'rxjs';
import { IdentityService } from './identity.service';
import { AuthService } from './auth.service';
import { Router } from '@angular/router';

@Injectable()
export class ConfigurationService {
  serverSettings: IConfiguration;
  // observable that is fired when settings are loaded from server
  OnSettingsLoaded: ReplaySubject<void> = new ReplaySubject(1);
  isReady: boolean = false;

  constructor(private http: HttpClient,
    private storageService: StorageService) { }

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
}

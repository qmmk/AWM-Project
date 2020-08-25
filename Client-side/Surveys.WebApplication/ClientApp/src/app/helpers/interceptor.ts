import { Injectable } from '@angular/core';
import { HttpRequest, HttpHandler, HttpEvent, HttpInterceptor, HttpHeaders } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError, finalize } from 'rxjs/operators';

import { AuthService } from '../services/auth.service';
import { ConfigurationService } from '../services/configuration.service';

@Injectable()
export class ErrorInterceptor implements HttpInterceptor {
  constructor(private authService: AuthService,
    private config: ConfigurationService) { }

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    return next.handle(req).pipe(catchError(err => {
      if (err && err.status === 401) {
        let currentUser = JSON.parse(localStorage.getItem('currentUser'));
        if (Date.parse(currentUser.refreshToken.expires) >= new Date().getTime()) {
          this.config.fast();          
        }
        else {
          this.authService.logOut();
          location.reload(true);
        }
      }
      throw (err);
    }));
  }
}


@Injectable()
export class JwtInterceptor implements HttpInterceptor {
  intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    // add authorization header with jwt token if available
    let currentUser = JSON.parse(localStorage.getItem('currentUser'));
    if (currentUser && currentUser.accessToken) {
      request = request.clone({
        setHeaders: {
          Authorization: `Bearer ${currentUser.accessToken}`
        }
      });
    }

    return next.handle(request);
  }
}

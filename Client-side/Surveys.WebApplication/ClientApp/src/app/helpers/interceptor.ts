import { Injectable } from '@angular/core';
import { HttpRequest, HttpHandler, HttpEvent, HttpInterceptor } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError, finalize } from 'rxjs/operators';

import { AuthService } from '../services/auth.service';
import { ConfigurationService } from '../services/configuration.service';


@Injectable()
export class ErrorInterceptor implements HttpInterceptor {
  constructor(private authService: AuthService, private configService: ConfigurationService) { }

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    return next.handle(req).pipe(catchError(err => {
      if (err && err.status === 401) {
        let currentUser = JSON.parse(localStorage.getItem('currentUser'));
        if (currentUser.refreshToken.isActive) {

          // Gestire l'invocazione per il fresh token !!
          this.configService.fast();
          location.reload(true);
          return next.handle(req);
        }
        else
        {
          this.authService.logOut();
          location.reload(true);
        }
      }
      else
      {
        //return throwError(err);
        throw (err);
      }
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

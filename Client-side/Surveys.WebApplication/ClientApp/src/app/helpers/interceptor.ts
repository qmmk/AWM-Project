import { Injectable } from '@angular/core';
import { HttpRequest, HttpHandler, HttpEvent, HttpInterceptor } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError, finalize } from 'rxjs/operators';

import { AuthService } from '../services/auth.service';


@Injectable()
export class ErrorInterceptor implements HttpInterceptor {
  request: any;
  constructor(private authService: AuthService) { }

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    return next.handle(req).pipe(catchError(async err => {
      if (err && err.status === 401) {
        let currentUser = JSON.parse(localStorage.getItem('currentUser'));
        if (currentUser.refreshToken.isActive) {
          return await this.authService.fast(currentUser.refreshToken.rToken).toPromise().then(res => {
            this.request = req.clone({
              setHeaders: {
                Authorization: `Bearer ${res.accessToken}`
              }
            });
            //return next.handle(request);
          });
        }
        else {
          this.authService.logOut();
          location.reload(true);
        }
      } else {
        return throwError(err);
      }
    }), finalize(() => {
      console.log("'*final request*'", this.request);
      return next.handle(this.request);
    })) as Observable<any>;
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

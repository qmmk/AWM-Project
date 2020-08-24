import { Injectable } from '@angular/core';
import { CanActivate, Router, ActivatedRouteSnapshot, RouterStateSnapshot } from '@angular/router';
import { HttpClient, HttpEvent, HttpRequest } from '@angular/common/http';
import { map } from 'rxjs/operators';
import { ConfigurationService } from './configuration.service'
import { IdentityService } from './identity.service';

@Injectable()
export class AuthService {
  serviceUrl: string;
  constructor(
    private http: HttpClient,
    private router: Router,
    private configService: ConfigurationService,
    private identityService: IdentityService) {
    this.configService.OnSettingsLoaded.subscribe(() => {
      this.serviceUrl = this.configService.serverSettings.webApiServiceUrl;
    });
  }

  logIn(username: string, password: string) {
    return this.http.post<any>(`${this.serviceUrl}/Login`, { username, password })
      .pipe(map(user => {
        // login successful if there's a jwt token in the response
        if (user && user.accessToken) {
          this.identityService.setUser(user);
        } else {
          this.identityService.removeUser();
        }
        return user;
      }));
  }

  logOut() {
    this.identityService.removeUser();
    this.router.navigate(['/login'], { queryParams: { returnUrl: '/' } });
  }
}

@Injectable()
export class AuthGuardService implements CanActivate {
  constructor(private router: Router, private identityService: IdentityService) { }

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot) {
    if (this.identityService.isLoggedIn) {
      let currentUser = JSON.parse(localStorage.getItem('currentUser'));
      if (currentUser.refreshToken.isActive) {

        // logged in so return true
        return true;
      }
    }

    // not logged in so redirect to login page with the return url
    this.router.navigate(['/login'], { queryParams: { returnUrl: state.url } });
    return false;
  }
}

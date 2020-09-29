import { Component } from '@angular/core';
import { IdentityService } from '../../services/identity.service';
import { AuthService } from '../../services/auth.service';
import { SurveyService } from '../../services/survey.service';
import { throwError } from 'rxjs';

@Component({
  selector: 'app-nav-menu',
  templateUrl: './nav-menu.component.html',
  styleUrls: ['./nav-menu.component.css']
})
export class NavMenuComponent {
  isExpanded = false;

  constructor(private identityService: IdentityService,
    private surveyService: SurveyService,
    private authService: AuthService) {
  }

  collapse() {
    this.isExpanded = false;
  }

  toggle() {
    this.isExpanded = !this.isExpanded;
  }

  isAutorized() {
    return this.identityService.isLoggedIn;
  }

  onClick() {
    let currentUser = JSON.parse(localStorage.getItem('currentUser'));

    this.surveyService.Logout(currentUser.pid)
      .catch(err => {
        console.log("Logout");
        return throwError (err);
      });

    return this.authService.logOut();    
  }
}

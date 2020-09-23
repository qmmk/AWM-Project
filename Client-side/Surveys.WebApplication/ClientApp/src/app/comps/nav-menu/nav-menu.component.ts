import { Component } from '@angular/core';
import { IdentityService } from '../../services/identity.service';
import { AuthService } from '../../services/auth.service';
import { SurveyService } from '../../services/survey.service';

@Component({
  selector: 'app-nav-menu',
  templateUrl: './nav-menu.component.html',
  styleUrls: ['./nav-menu.component.css']
})
export class NavMenuComponent {
  isExpanded = false;

  constructor(private identityService: IdentityService,
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
    this.authService.logOut();    
  }
}

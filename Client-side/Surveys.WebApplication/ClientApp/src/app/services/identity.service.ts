import { Injectable } from "@angular/core";
import { Subject, ReplaySubject } from 'rxjs';
import { Principal } from '../models/Principal';

@Injectable(
  {
    providedIn: 'root'
  }
)
export class IdentityService {
  user: Principal;
  OnLoggedIn: ReplaySubject<Principal> = new ReplaySubject<Principal>(1);
  OnLoggedOut: ReplaySubject<void> = new ReplaySubject(1);
  get isLoggedIn(): boolean {
    return this.user != null;
  }

  constructor() {
    this.user = JSON.parse(localStorage.getItem('currentUser'))
    if (this.user)
      this.OnLoggedIn.next(this.user);
  }

  setUser(user: Principal) {
    localStorage.setItem('currentUser', JSON.stringify(user));
    this.user = user;
    this.OnLoggedIn.next(user);
  }

  removeUser() {
    localStorage.removeItem('currentUser');
    localStorage.removeItem('sysConfig');
    this.user = null;
    this.OnLoggedOut.next();
  }
}

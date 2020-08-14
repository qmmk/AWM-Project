import { Injectable } from '@angular/core';

@Injectable()
export class StorageService {
  private sessionStorage: Storage;
  private localStorage: Storage;
  constructor() {
    this.sessionStorage = sessionStorage; // localStorage;
    this.localStorage = localStorage;
  }

  public retrieve(key: string, session: boolean = true): any {
    let storage = session ? this.sessionStorage : this.localStorage;
    let item = storage.getItem(key);

    if (item && item !== 'undefined') {
      return JSON.parse(storage.getItem(key));
    }

    return;
  }

  public store(key: string, value: any, session: boolean = true) {
    let storage = session ? this.sessionStorage : this.localStorage;
    storage.setItem(key, JSON.stringify(value));
  }

  public delete(key: string, session: boolean = true) {
    let storage = session ? this.sessionStorage : this.localStorage;
    storage.removeItem(key);
  }
}

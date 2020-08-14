import { RefreshToken } from './RefreshToken';

export class Principal {
  PID: number;
  UserName: string;
  HashedPwd: string;
  CustomField01: string;
  CustomField02: string;
  CustomField03: string;
  RoleID: string;
  AccessToken: string;
  RefreshToken: RefreshToken;

  constructor(init?: Partial<Principal>) {
    Object.assign(this, init);
  }
  static ToListOfInstance(list: Principal[]): Principal[] {
    return list.map(item => { return new Principal(item); });
  }
  static ToInstance(item: Principal): Principal {
    return new Principal(item);
  }

}

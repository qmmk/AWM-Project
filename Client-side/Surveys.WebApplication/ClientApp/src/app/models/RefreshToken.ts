export class RefreshToken {
  RID: number;
  rToken: string;
  Expires: Date;
  IsExpired: boolean = new Date() >= this.Expires;
  CreatedBy: number;
  Revoked?: Date;
  IsActive: boolean = this.Revoked == null && !this.IsExpired;
}

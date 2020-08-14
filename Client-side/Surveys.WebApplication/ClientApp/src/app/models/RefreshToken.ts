export class RefreshToken {
  RID: number;
  rToken: string;
  Expires: Date;
  IsExpired: boolean;
  CreatedBy: number;
  Revoked?: Date;
  IsActive: boolean;
}

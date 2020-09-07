export class SurveyDetail {
  seid: number;
  sdid: number;
  descr: string;

  constructor(init?: Partial<SurveyDetail>) {
    Object.assign(this, init);
  }
  static ToListOfInstance(list: SurveyDetail[]): SurveyDetail[] {
    return list.map(item => { return new SurveyDetail(item); });
  }
  static ToInstance(item: SurveyDetail): SurveyDetail {
    return new SurveyDetail(item);
  }
}

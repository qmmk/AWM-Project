import { SurveyDetail } from './SurveyDetail';

export class SurveyEntity {
  seid: number;
  title: string;
  descr: string;
  customField01: string;
  isOpen: string;
  customField03: string;
  surveyDetails?: SurveyDetail;

  constructor(init?: Partial<SurveyEntity>) {
    Object.assign(this, init);
  }
  static ToListOfInstance(list: SurveyEntity[]): SurveyEntity[] {
    return list.map(item => { return new SurveyEntity(item); });
  }
  static ToInstance(item: SurveyEntity): SurveyEntity {
    return new SurveyEntity(item);
  }

}

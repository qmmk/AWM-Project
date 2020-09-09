            import 'package:built_collection/built_collection.dart';
            import 'package:survey_client/model/openapi_survey_detail.dart';
        import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'openapi_survey.g.dart';

abstract class OpenapiSurvey implements Built<OpenapiSurvey, OpenapiSurveyBuilder> {

    
        @nullable
    @BuiltValueField(wireName: r'seid')
    int get seid;
    
        @nullable
    @BuiltValueField(wireName: r'title')
    String get title;
    
        @nullable
    @BuiltValueField(wireName: r'descr')
    String get descr;
    
        @nullable
    @BuiltValueField(wireName: r'isOpen')
    bool get isOpen;
    
        @nullable
    @BuiltValueField(wireName: r'createdBy')
    int get createdBy;
    
        @nullable
    @BuiltValueField(wireName: r'surveyDetails')
    BuiltList<OpenapiSurveyDetail> get surveyDetails;

    // Boilerplate code needed to wire-up generated code
    OpenapiSurvey._();

    factory OpenapiSurvey([updates(OpenapiSurveyBuilder b)]) = _$OpenapiSurvey;
    static Serializer<OpenapiSurvey> get serializer => _$openapiSurveySerializer;

}


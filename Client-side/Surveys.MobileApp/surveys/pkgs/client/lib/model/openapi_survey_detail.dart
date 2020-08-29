        import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'openapi_survey_detail.g.dart';

abstract class OpenapiSurveyDetail implements Built<OpenapiSurveyDetail, OpenapiSurveyDetailBuilder> {

    
        @nullable
    @BuiltValueField(wireName: r'sdid')
    int get sdid;
    
        @nullable
    @BuiltValueField(wireName: r'seid')
    int get seid;
    
        @nullable
    @BuiltValueField(wireName: r'descr')
    String get descr;
    
        @nullable
    @BuiltValueField(wireName: r'CustomField01')
    String get customField01;
    
        @nullable
    @BuiltValueField(wireName: r'CustomField02')
    String get customField02;
    
        @nullable
    @BuiltValueField(wireName: r'CustomField03')
    String get customField03;

    // Boilerplate code needed to wire-up generated code
    OpenapiSurveyDetail._();

    factory OpenapiSurveyDetail([updates(OpenapiSurveyDetailBuilder b)]) = _$OpenapiSurveyDetail;
    static Serializer<OpenapiSurveyDetail> get serializer => _$openapiSurveyDetailSerializer;

}


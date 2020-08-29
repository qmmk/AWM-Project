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
    @BuiltValueField(wireName: r'customField01')
    String get customField01;
    
        @nullable
    @BuiltValueField(wireName: r'isOpen')
    String get isOpen;
    
        @nullable
    @BuiltValueField(wireName: r'customField03')
    String get customField03;

    // Boilerplate code needed to wire-up generated code
    OpenapiSurvey._();

    factory OpenapiSurvey([updates(OpenapiSurveyBuilder b)]) = _$OpenapiSurvey;
    static Serializer<OpenapiSurvey> get serializer => _$openapiSurveySerializer;

}


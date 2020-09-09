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

    // Boilerplate code needed to wire-up generated code
    OpenapiSurveyDetail._();

    factory OpenapiSurveyDetail([updates(OpenapiSurveyDetailBuilder b)]) = _$OpenapiSurveyDetail;
    static Serializer<OpenapiSurveyDetail> get serializer => _$openapiSurveyDetailSerializer;

}


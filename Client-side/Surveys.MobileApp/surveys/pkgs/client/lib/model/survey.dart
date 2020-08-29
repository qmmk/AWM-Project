        import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'survey.g.dart';

abstract class Survey implements Built<Survey, SurveyBuilder> {

    
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
    Survey._();

    factory Survey([updates(SurveyBuilder b)]) = _$Survey;
    static Serializer<Survey> get serializer => _$surveySerializer;

}


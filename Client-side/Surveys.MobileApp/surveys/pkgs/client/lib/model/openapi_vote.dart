        import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'openapi_vote.g.dart';

abstract class OpenapiVote implements Built<OpenapiVote, OpenapiVoteBuilder> {

    
        @nullable
    @BuiltValueField(wireName: r'avid')
    int get avid;
    
        @nullable
    @BuiltValueField(wireName: r'pid')
    int get pid;
    
        @nullable
    @BuiltValueField(wireName: r'sdid')
    int get sdid;
    
        @nullable
    @BuiltValueField(wireName: r'registeredOn')
    String get registeredOn;

    // Boilerplate code needed to wire-up generated code
    OpenapiVote._();

    factory OpenapiVote([updates(OpenapiVoteBuilder b)]) = _$OpenapiVote;
    static Serializer<OpenapiVote> get serializer => _$openapiVoteSerializer;

}


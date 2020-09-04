        import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'openapi_vote_result.g.dart';

abstract class OpenapiVoteResult implements Built<OpenapiVoteResult, OpenapiVoteResultBuilder> {

    
        @nullable
    @BuiltValueField(wireName: r'sdid')
    int get sdid;
    
        @nullable
    @BuiltValueField(wireName: r'votes')
    int get votes;

    // Boilerplate code needed to wire-up generated code
    OpenapiVoteResult._();

    factory OpenapiVoteResult([updates(OpenapiVoteResultBuilder b)]) = _$OpenapiVoteResult;
    static Serializer<OpenapiVoteResult> get serializer => _$openapiVoteResultSerializer;

}


        import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'openapi_vote_amount.g.dart';

abstract class OpenapiVoteAmount implements Built<OpenapiVoteAmount, OpenapiVoteAmountBuilder> {

    
        @nullable
    @BuiltValueField(wireName: r'sdid')
    int get sdid;
    
        @nullable
    @BuiltValueField(wireName: r'votes')
    int get votes;

    // Boilerplate code needed to wire-up generated code
    OpenapiVoteAmount._();

    factory OpenapiVoteAmount([updates(OpenapiVoteAmountBuilder b)]) = _$OpenapiVoteAmount;
    static Serializer<OpenapiVoteAmount> get serializer => _$openapiVoteAmountSerializer;

}


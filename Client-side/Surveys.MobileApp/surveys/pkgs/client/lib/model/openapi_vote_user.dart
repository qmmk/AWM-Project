        import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'openapi_vote_user.g.dart';

abstract class OpenapiVoteUser implements Built<OpenapiVoteUser, OpenapiVoteUserBuilder> {

    
        @nullable
    @BuiltValueField(wireName: r'sdid')
    int get sdid;
    
        @nullable
    @BuiltValueField(wireName: r'user')
    String get user;

    // Boilerplate code needed to wire-up generated code
    OpenapiVoteUser._();

    factory OpenapiVoteUser([updates(OpenapiVoteUserBuilder b)]) = _$OpenapiVoteUser;
    static Serializer<OpenapiVoteUser> get serializer => _$openapiVoteUserSerializer;

}


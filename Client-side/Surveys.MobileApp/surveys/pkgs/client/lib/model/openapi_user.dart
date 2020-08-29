        import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'openapi_user.g.dart';

abstract class OpenapiUser implements Built<OpenapiUser, OpenapiUserBuilder> {

    
        @nullable
    @BuiltValueField(wireName: r'pid')
    int get pid;
    
        @nullable
    @BuiltValueField(wireName: r'UserName')
    String get userName;
    
        @nullable
    @BuiltValueField(wireName: r'Password')
    String get password;
    
        @nullable
    @BuiltValueField(wireName: r'RoleID')
    String get roleID;

    // Boilerplate code needed to wire-up generated code
    OpenapiUser._();

    factory OpenapiUser([updates(OpenapiUserBuilder b)]) = _$OpenapiUser;
    static Serializer<OpenapiUser> get serializer => _$openapiUserSerializer;

}


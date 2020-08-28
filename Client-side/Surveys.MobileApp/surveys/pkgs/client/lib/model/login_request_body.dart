        import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_request_body.g.dart';

abstract class LoginRequestBody implements Built<LoginRequestBody, LoginRequestBodyBuilder> {

    
        @nullable
    @BuiltValueField(wireName: r'username')
    String get username;
    
        @nullable
    @BuiltValueField(wireName: r'password')
    String get password;

    // Boilerplate code needed to wire-up generated code
    LoginRequestBody._();

    factory LoginRequestBody([updates(LoginRequestBodyBuilder b)]) = _$LoginRequestBody;
    static Serializer<LoginRequestBody> get serializer => _$loginRequestBodySerializer;

}


            import 'package:survey_client/model/refresh_token.dart';
        import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_response.g.dart';

abstract class LoginResponse implements Built<LoginResponse, LoginResponseBuilder> {

    
        @nullable
    @BuiltValueField(wireName: r'accessToken')
    String get accessToken;
    
        @nullable
    @BuiltValueField(wireName: r'pid')
    int get pid;
    
        @nullable
    @BuiltValueField(wireName: r'userName')
    String get userName;
    
        @nullable
    @BuiltValueField(wireName: r'hashedPwd')
    String get hashedPwd;
    
        @nullable
    @BuiltValueField(wireName: r'refreshToken')
    RefreshToken get refreshToken;
    
        @nullable
    @BuiltValueField(wireName: r'roleID')
    String get roleID;

    // Boilerplate code needed to wire-up generated code
    LoginResponse._();

    factory LoginResponse([updates(LoginResponseBuilder b)]) = _$LoginResponse;
    static Serializer<LoginResponse> get serializer => _$loginResponseSerializer;

}


        import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'refresh_token.g.dart';

abstract class RefreshToken implements Built<RefreshToken, RefreshTokenBuilder> {

    
        @nullable
    @BuiltValueField(wireName: r'rToken')
    String get rToken;
    
        @nullable
    @BuiltValueField(wireName: r'expires')
    String get expires;
    
        @nullable
    @BuiltValueField(wireName: r'createdBy')
    int get createdBy;
    
        @nullable
    @BuiltValueField(wireName: r'revoked')
    bool get revoked;

    // Boilerplate code needed to wire-up generated code
    RefreshToken._();

    factory RefreshToken([updates(RefreshTokenBuilder b)]) = _$RefreshToken;
    static Serializer<RefreshToken> get serializer => _$refreshTokenSerializer;

}


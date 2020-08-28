        import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'fast_login_request_body.g.dart';

abstract class FastLoginRequestBody implements Built<FastLoginRequestBody, FastLoginRequestBodyBuilder> {

    
        @nullable
    @BuiltValueField(wireName: r'token')
    String get token;

    // Boilerplate code needed to wire-up generated code
    FastLoginRequestBody._();

    factory FastLoginRequestBody([updates(FastLoginRequestBodyBuilder b)]) = _$FastLoginRequestBody;
    static Serializer<FastLoginRequestBody> get serializer => _$fastLoginRequestBodySerializer;

}


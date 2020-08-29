        import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'logout_response.g.dart';

abstract class LogoutResponse implements Built<LogoutResponse, LogoutResponseBuilder> {

    
        @nullable
    @BuiltValueField(wireName: r'success')
    bool get success;
    
        @nullable
    @BuiltValueField(wireName: r'data')
    int get data;
    
        @nullable
    @BuiltValueField(wireName: r'message')
    String get message;
    
        @nullable
    @BuiltValueField(wireName: r'error')
    String get error;

    // Boilerplate code needed to wire-up generated code
    LogoutResponse._();

    factory LogoutResponse([updates(LogoutResponseBuilder b)]) = _$LogoutResponse;
    static Serializer<LogoutResponse> get serializer => _$logoutResponseSerializer;

}


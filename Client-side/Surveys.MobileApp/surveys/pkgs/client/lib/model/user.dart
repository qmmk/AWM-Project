        import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {

    
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
    User._();

    factory User([updates(UserBuilder b)]) = _$User;
    static Serializer<User> get serializer => _$userSerializer;

}


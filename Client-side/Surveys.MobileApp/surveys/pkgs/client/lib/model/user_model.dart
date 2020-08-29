        import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_model.g.dart';

abstract class UserModel implements Built<UserModel, UserModelBuilder> {

    
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
    UserModel._();

    factory UserModel([updates(UserModelBuilder b)]) = _$UserModel;
    static Serializer<UserModel> get serializer => _$userModelSerializer;

}


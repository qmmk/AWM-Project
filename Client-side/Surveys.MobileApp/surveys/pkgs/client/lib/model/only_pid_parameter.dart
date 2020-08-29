        import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'only_pid_parameter.g.dart';

abstract class OnlyPidParameter implements Built<OnlyPidParameter, OnlyPidParameterBuilder> {

    
        @nullable
    @BuiltValueField(wireName: r'pid')
    int get pid;

    // Boilerplate code needed to wire-up generated code
    OnlyPidParameter._();

    factory OnlyPidParameter([updates(OnlyPidParameterBuilder b)]) = _$OnlyPidParameter;
    static Serializer<OnlyPidParameter> get serializer => _$onlyPidParameterSerializer;

}


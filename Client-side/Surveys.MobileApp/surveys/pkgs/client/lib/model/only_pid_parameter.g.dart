// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'only_pid_parameter.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OnlyPidParameter> _$onlyPidParameterSerializer =
    new _$OnlyPidParameterSerializer();

class _$OnlyPidParameterSerializer
    implements StructuredSerializer<OnlyPidParameter> {
  @override
  final Iterable<Type> types = const [OnlyPidParameter, _$OnlyPidParameter];
  @override
  final String wireName = 'OnlyPidParameter';

  @override
  Iterable<Object> serialize(Serializers serializers, OnlyPidParameter object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.pid != null) {
      result
        ..add('pid')
        ..add(serializers.serialize(object.pid,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  OnlyPidParameter deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OnlyPidParameterBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'pid':
          result.pid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$OnlyPidParameter extends OnlyPidParameter {
  @override
  final int pid;

  factory _$OnlyPidParameter(
          [void Function(OnlyPidParameterBuilder) updates]) =>
      (new OnlyPidParameterBuilder()..update(updates)).build();

  _$OnlyPidParameter._({this.pid}) : super._();

  @override
  OnlyPidParameter rebuild(void Function(OnlyPidParameterBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OnlyPidParameterBuilder toBuilder() =>
      new OnlyPidParameterBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OnlyPidParameter && pid == other.pid;
  }

  @override
  int get hashCode {
    return $jf($jc(0, pid.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OnlyPidParameter')..add('pid', pid))
        .toString();
  }
}

class OnlyPidParameterBuilder
    implements Builder<OnlyPidParameter, OnlyPidParameterBuilder> {
  _$OnlyPidParameter _$v;

  int _pid;
  int get pid => _$this._pid;
  set pid(int pid) => _$this._pid = pid;

  OnlyPidParameterBuilder();

  OnlyPidParameterBuilder get _$this {
    if (_$v != null) {
      _pid = _$v.pid;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OnlyPidParameter other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OnlyPidParameter;
  }

  @override
  void update(void Function(OnlyPidParameterBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OnlyPidParameter build() {
    final _$result = _$v ?? new _$OnlyPidParameter._(pid: pid);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

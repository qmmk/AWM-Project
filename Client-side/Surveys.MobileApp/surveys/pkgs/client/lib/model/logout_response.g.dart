// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<LogoutResponse> _$logoutResponseSerializer =
    new _$LogoutResponseSerializer();

class _$LogoutResponseSerializer
    implements StructuredSerializer<LogoutResponse> {
  @override
  final Iterable<Type> types = const [LogoutResponse, _$LogoutResponse];
  @override
  final String wireName = 'LogoutResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, LogoutResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.success != null) {
      result
        ..add('success')
        ..add(serializers.serialize(object.success,
            specifiedType: const FullType(bool)));
    }
    if (object.data != null) {
      result
        ..add('data')
        ..add(serializers.serialize(object.data,
            specifiedType: const FullType(int)));
    }
    if (object.message != null) {
      result
        ..add('message')
        ..add(serializers.serialize(object.message,
            specifiedType: const FullType(String)));
    }
    if (object.error != null) {
      result
        ..add('error')
        ..add(serializers.serialize(object.error,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  LogoutResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LogoutResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'success':
          result.success = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'data':
          result.data = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'error':
          result.error = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$LogoutResponse extends LogoutResponse {
  @override
  final bool success;
  @override
  final int data;
  @override
  final String message;
  @override
  final String error;

  factory _$LogoutResponse([void Function(LogoutResponseBuilder) updates]) =>
      (new LogoutResponseBuilder()..update(updates)).build();

  _$LogoutResponse._({this.success, this.data, this.message, this.error})
      : super._();

  @override
  LogoutResponse rebuild(void Function(LogoutResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LogoutResponseBuilder toBuilder() =>
      new LogoutResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LogoutResponse &&
        success == other.success &&
        data == other.data &&
        message == other.message &&
        error == other.error;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, success.hashCode), data.hashCode), message.hashCode),
        error.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LogoutResponse')
          ..add('success', success)
          ..add('data', data)
          ..add('message', message)
          ..add('error', error))
        .toString();
  }
}

class LogoutResponseBuilder
    implements Builder<LogoutResponse, LogoutResponseBuilder> {
  _$LogoutResponse _$v;

  bool _success;
  bool get success => _$this._success;
  set success(bool success) => _$this._success = success;

  int _data;
  int get data => _$this._data;
  set data(int data) => _$this._data = data;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  String _error;
  String get error => _$this._error;
  set error(String error) => _$this._error = error;

  LogoutResponseBuilder();

  LogoutResponseBuilder get _$this {
    if (_$v != null) {
      _success = _$v.success;
      _data = _$v.data;
      _message = _$v.message;
      _error = _$v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LogoutResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LogoutResponse;
  }

  @override
  void update(void Function(LogoutResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LogoutResponse build() {
    final _$result = _$v ??
        new _$LogoutResponse._(
            success: success, data: data, message: message, error: error);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_body.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<LoginRequestBody> _$loginRequestBodySerializer =
    new _$LoginRequestBodySerializer();

class _$LoginRequestBodySerializer
    implements StructuredSerializer<LoginRequestBody> {
  @override
  final Iterable<Type> types = const [LoginRequestBody, _$LoginRequestBody];
  @override
  final String wireName = 'LoginRequestBody';

  @override
  Iterable<Object> serialize(Serializers serializers, LoginRequestBody object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.username != null) {
      result
        ..add('username')
        ..add(serializers.serialize(object.username,
            specifiedType: const FullType(String)));
    }
    if (object.password != null) {
      result
        ..add('password')
        ..add(serializers.serialize(object.password,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  LoginRequestBody deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LoginRequestBodyBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$LoginRequestBody extends LoginRequestBody {
  @override
  final String username;
  @override
  final String password;

  factory _$LoginRequestBody(
          [void Function(LoginRequestBodyBuilder) updates]) =>
      (new LoginRequestBodyBuilder()..update(updates)).build();

  _$LoginRequestBody._({this.username, this.password}) : super._();

  @override
  LoginRequestBody rebuild(void Function(LoginRequestBodyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginRequestBodyBuilder toBuilder() =>
      new LoginRequestBodyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginRequestBody &&
        username == other.username &&
        password == other.password;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, username.hashCode), password.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoginRequestBody')
          ..add('username', username)
          ..add('password', password))
        .toString();
  }
}

class LoginRequestBodyBuilder
    implements Builder<LoginRequestBody, LoginRequestBodyBuilder> {
  _$LoginRequestBody _$v;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _password;
  String get password => _$this._password;
  set password(String password) => _$this._password = password;

  LoginRequestBodyBuilder();

  LoginRequestBodyBuilder get _$this {
    if (_$v != null) {
      _username = _$v.username;
      _password = _$v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginRequestBody other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LoginRequestBody;
  }

  @override
  void update(void Function(LoginRequestBodyBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LoginRequestBody build() {
    final _$result =
        _$v ?? new _$LoginRequestBody._(username: username, password: password);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

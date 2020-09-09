// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<LoginResponse> _$loginResponseSerializer =
    new _$LoginResponseSerializer();

class _$LoginResponseSerializer implements StructuredSerializer<LoginResponse> {
  @override
  final Iterable<Type> types = const [LoginResponse, _$LoginResponse];
  @override
  final String wireName = 'LoginResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, LoginResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.accessToken != null) {
      result
        ..add('accessToken')
        ..add(serializers.serialize(object.accessToken,
            specifiedType: const FullType(String)));
    }
    if (object.pid != null) {
      result
        ..add('pid')
        ..add(serializers.serialize(object.pid,
            specifiedType: const FullType(int)));
    }
    if (object.userName != null) {
      result
        ..add('userName')
        ..add(serializers.serialize(object.userName,
            specifiedType: const FullType(String)));
    }
    if (object.hashedPwd != null) {
      result
        ..add('hashedPwd')
        ..add(serializers.serialize(object.hashedPwd,
            specifiedType: const FullType(String)));
    }
    if (object.refreshToken != null) {
      result
        ..add('refreshToken')
        ..add(serializers.serialize(object.refreshToken,
            specifiedType: const FullType(RefreshToken)));
    }
    if (object.roleID != null) {
      result
        ..add('roleID')
        ..add(serializers.serialize(object.roleID,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  LoginResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LoginResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'accessToken':
          result.accessToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'pid':
          result.pid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'userName':
          result.userName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'hashedPwd':
          result.hashedPwd = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'refreshToken':
          result.refreshToken.replace(serializers.deserialize(value,
              specifiedType: const FullType(RefreshToken)) as RefreshToken);
          break;
        case 'roleID':
          result.roleID = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$LoginResponse extends LoginResponse {
  @override
  final String accessToken;
  @override
  final int pid;
  @override
  final String userName;
  @override
  final String hashedPwd;
  @override
  final RefreshToken refreshToken;
  @override
  final String roleID;

  factory _$LoginResponse([void Function(LoginResponseBuilder) updates]) =>
      (new LoginResponseBuilder()..update(updates)).build();

  _$LoginResponse._(
      {this.accessToken,
      this.pid,
      this.userName,
      this.hashedPwd,
      this.refreshToken,
      this.roleID})
      : super._();

  @override
  LoginResponse rebuild(void Function(LoginResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginResponseBuilder toBuilder() => new LoginResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginResponse &&
        accessToken == other.accessToken &&
        pid == other.pid &&
        userName == other.userName &&
        hashedPwd == other.hashedPwd &&
        refreshToken == other.refreshToken &&
        roleID == other.roleID;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, accessToken.hashCode), pid.hashCode),
                    userName.hashCode),
                hashedPwd.hashCode),
            refreshToken.hashCode),
        roleID.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LoginResponse')
          ..add('accessToken', accessToken)
          ..add('pid', pid)
          ..add('userName', userName)
          ..add('hashedPwd', hashedPwd)
          ..add('refreshToken', refreshToken)
          ..add('roleID', roleID))
        .toString();
  }
}

class LoginResponseBuilder
    implements Builder<LoginResponse, LoginResponseBuilder> {
  _$LoginResponse _$v;

  String _accessToken;
  String get accessToken => _$this._accessToken;
  set accessToken(String accessToken) => _$this._accessToken = accessToken;

  int _pid;
  int get pid => _$this._pid;
  set pid(int pid) => _$this._pid = pid;

  String _userName;
  String get userName => _$this._userName;
  set userName(String userName) => _$this._userName = userName;

  String _hashedPwd;
  String get hashedPwd => _$this._hashedPwd;
  set hashedPwd(String hashedPwd) => _$this._hashedPwd = hashedPwd;

  RefreshTokenBuilder _refreshToken;
  RefreshTokenBuilder get refreshToken =>
      _$this._refreshToken ??= new RefreshTokenBuilder();
  set refreshToken(RefreshTokenBuilder refreshToken) =>
      _$this._refreshToken = refreshToken;

  String _roleID;
  String get roleID => _$this._roleID;
  set roleID(String roleID) => _$this._roleID = roleID;

  LoginResponseBuilder();

  LoginResponseBuilder get _$this {
    if (_$v != null) {
      _accessToken = _$v.accessToken;
      _pid = _$v.pid;
      _userName = _$v.userName;
      _hashedPwd = _$v.hashedPwd;
      _refreshToken = _$v.refreshToken?.toBuilder();
      _roleID = _$v.roleID;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LoginResponse;
  }

  @override
  void update(void Function(LoginResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LoginResponse build() {
    _$LoginResponse _$result;
    try {
      _$result = _$v ??
          new _$LoginResponse._(
              accessToken: accessToken,
              pid: pid,
              userName: userName,
              hashedPwd: hashedPwd,
              refreshToken: _refreshToken?.build(),
              roleID: roleID);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'refreshToken';
        _refreshToken?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LoginResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

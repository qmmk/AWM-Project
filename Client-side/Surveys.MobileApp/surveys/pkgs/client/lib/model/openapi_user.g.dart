// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openapi_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OpenapiUser> _$openapiUserSerializer = new _$OpenapiUserSerializer();

class _$OpenapiUserSerializer implements StructuredSerializer<OpenapiUser> {
  @override
  final Iterable<Type> types = const [OpenapiUser, _$OpenapiUser];
  @override
  final String wireName = 'OpenapiUser';

  @override
  Iterable<Object> serialize(Serializers serializers, OpenapiUser object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.pid != null) {
      result
        ..add('pid')
        ..add(serializers.serialize(object.pid,
            specifiedType: const FullType(int)));
    }
    if (object.userName != null) {
      result
        ..add('UserName')
        ..add(serializers.serialize(object.userName,
            specifiedType: const FullType(String)));
    }
    if (object.password != null) {
      result
        ..add('Password')
        ..add(serializers.serialize(object.password,
            specifiedType: const FullType(String)));
    }
    if (object.roleID != null) {
      result
        ..add('RoleID')
        ..add(serializers.serialize(object.roleID,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  OpenapiUser deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OpenapiUserBuilder();

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
        case 'UserName':
          result.userName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'RoleID':
          result.roleID = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$OpenapiUser extends OpenapiUser {
  @override
  final int pid;
  @override
  final String userName;
  @override
  final String password;
  @override
  final String roleID;

  factory _$OpenapiUser([void Function(OpenapiUserBuilder) updates]) =>
      (new OpenapiUserBuilder()..update(updates)).build();

  _$OpenapiUser._({this.pid, this.userName, this.password, this.roleID})
      : super._();

  @override
  OpenapiUser rebuild(void Function(OpenapiUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OpenapiUserBuilder toBuilder() => new OpenapiUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OpenapiUser &&
        pid == other.pid &&
        userName == other.userName &&
        password == other.password &&
        roleID == other.roleID;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, pid.hashCode), userName.hashCode), password.hashCode),
        roleID.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OpenapiUser')
          ..add('pid', pid)
          ..add('userName', userName)
          ..add('password', password)
          ..add('roleID', roleID))
        .toString();
  }
}

class OpenapiUserBuilder implements Builder<OpenapiUser, OpenapiUserBuilder> {
  _$OpenapiUser _$v;

  int _pid;
  int get pid => _$this._pid;
  set pid(int pid) => _$this._pid = pid;

  String _userName;
  String get userName => _$this._userName;
  set userName(String userName) => _$this._userName = userName;

  String _password;
  String get password => _$this._password;
  set password(String password) => _$this._password = password;

  String _roleID;
  String get roleID => _$this._roleID;
  set roleID(String roleID) => _$this._roleID = roleID;

  OpenapiUserBuilder();

  OpenapiUserBuilder get _$this {
    if (_$v != null) {
      _pid = _$v.pid;
      _userName = _$v.userName;
      _password = _$v.password;
      _roleID = _$v.roleID;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OpenapiUser other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OpenapiUser;
  }

  @override
  void update(void Function(OpenapiUserBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OpenapiUser build() {
    final _$result = _$v ??
        new _$OpenapiUser._(
            pid: pid, userName: userName, password: password, roleID: roleID);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

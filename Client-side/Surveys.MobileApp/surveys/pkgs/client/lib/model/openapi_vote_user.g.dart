// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openapi_vote_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OpenapiVoteUser> _$openapiVoteUserSerializer =
    new _$OpenapiVoteUserSerializer();

class _$OpenapiVoteUserSerializer
    implements StructuredSerializer<OpenapiVoteUser> {
  @override
  final Iterable<Type> types = const [OpenapiVoteUser, _$OpenapiVoteUser];
  @override
  final String wireName = 'OpenapiVoteUser';

  @override
  Iterable<Object> serialize(Serializers serializers, OpenapiVoteUser object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.sdid != null) {
      result
        ..add('sdid')
        ..add(serializers.serialize(object.sdid,
            specifiedType: const FullType(int)));
    }
    if (object.user != null) {
      result
        ..add('user')
        ..add(serializers.serialize(object.user,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  OpenapiVoteUser deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OpenapiVoteUserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'sdid':
          result.sdid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'user':
          result.user = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$OpenapiVoteUser extends OpenapiVoteUser {
  @override
  final int sdid;
  @override
  final String user;

  factory _$OpenapiVoteUser([void Function(OpenapiVoteUserBuilder) updates]) =>
      (new OpenapiVoteUserBuilder()..update(updates)).build();

  _$OpenapiVoteUser._({this.sdid, this.user}) : super._();

  @override
  OpenapiVoteUser rebuild(void Function(OpenapiVoteUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OpenapiVoteUserBuilder toBuilder() =>
      new OpenapiVoteUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OpenapiVoteUser && sdid == other.sdid && user == other.user;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, sdid.hashCode), user.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OpenapiVoteUser')
          ..add('sdid', sdid)
          ..add('user', user))
        .toString();
  }
}

class OpenapiVoteUserBuilder
    implements Builder<OpenapiVoteUser, OpenapiVoteUserBuilder> {
  _$OpenapiVoteUser _$v;

  int _sdid;
  int get sdid => _$this._sdid;
  set sdid(int sdid) => _$this._sdid = sdid;

  String _user;
  String get user => _$this._user;
  set user(String user) => _$this._user = user;

  OpenapiVoteUserBuilder();

  OpenapiVoteUserBuilder get _$this {
    if (_$v != null) {
      _sdid = _$v.sdid;
      _user = _$v.user;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OpenapiVoteUser other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OpenapiVoteUser;
  }

  @override
  void update(void Function(OpenapiVoteUserBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OpenapiVoteUser build() {
    final _$result = _$v ?? new _$OpenapiVoteUser._(sdid: sdid, user: user);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

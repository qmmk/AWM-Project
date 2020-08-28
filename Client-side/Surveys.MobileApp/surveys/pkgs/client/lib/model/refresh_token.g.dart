// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<RefreshToken> _$refreshTokenSerializer =
    new _$RefreshTokenSerializer();

class _$RefreshTokenSerializer implements StructuredSerializer<RefreshToken> {
  @override
  final Iterable<Type> types = const [RefreshToken, _$RefreshToken];
  @override
  final String wireName = 'RefreshToken';

  @override
  Iterable<Object> serialize(Serializers serializers, RefreshToken object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.rToken != null) {
      result
        ..add('rToken')
        ..add(serializers.serialize(object.rToken,
            specifiedType: const FullType(String)));
    }
    if (object.expires != null) {
      result
        ..add('expires')
        ..add(serializers.serialize(object.expires,
            specifiedType: const FullType(String)));
    }
    if (object.createdBy != null) {
      result
        ..add('createdBy')
        ..add(serializers.serialize(object.createdBy,
            specifiedType: const FullType(int)));
    }
    if (object.revoked != null) {
      result
        ..add('revoked')
        ..add(serializers.serialize(object.revoked,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  RefreshToken deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RefreshTokenBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'rToken':
          result.rToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'expires':
          result.expires = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdBy':
          result.createdBy = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'revoked':
          result.revoked = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$RefreshToken extends RefreshToken {
  @override
  final String rToken;
  @override
  final String expires;
  @override
  final int createdBy;
  @override
  final bool revoked;

  factory _$RefreshToken([void Function(RefreshTokenBuilder) updates]) =>
      (new RefreshTokenBuilder()..update(updates)).build();

  _$RefreshToken._({this.rToken, this.expires, this.createdBy, this.revoked})
      : super._();

  @override
  RefreshToken rebuild(void Function(RefreshTokenBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RefreshTokenBuilder toBuilder() => new RefreshTokenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RefreshToken &&
        rToken == other.rToken &&
        expires == other.expires &&
        createdBy == other.createdBy &&
        revoked == other.revoked;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, rToken.hashCode), expires.hashCode), createdBy.hashCode),
        revoked.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RefreshToken')
          ..add('rToken', rToken)
          ..add('expires', expires)
          ..add('createdBy', createdBy)
          ..add('revoked', revoked))
        .toString();
  }
}

class RefreshTokenBuilder
    implements Builder<RefreshToken, RefreshTokenBuilder> {
  _$RefreshToken _$v;

  String _rToken;
  String get rToken => _$this._rToken;
  set rToken(String rToken) => _$this._rToken = rToken;

  String _expires;
  String get expires => _$this._expires;
  set expires(String expires) => _$this._expires = expires;

  int _createdBy;
  int get createdBy => _$this._createdBy;
  set createdBy(int createdBy) => _$this._createdBy = createdBy;

  bool _revoked;
  bool get revoked => _$this._revoked;
  set revoked(bool revoked) => _$this._revoked = revoked;

  RefreshTokenBuilder();

  RefreshTokenBuilder get _$this {
    if (_$v != null) {
      _rToken = _$v.rToken;
      _expires = _$v.expires;
      _createdBy = _$v.createdBy;
      _revoked = _$v.revoked;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RefreshToken other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$RefreshToken;
  }

  @override
  void update(void Function(RefreshTokenBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RefreshToken build() {
    final _$result = _$v ??
        new _$RefreshToken._(
            rToken: rToken,
            expires: expires,
            createdBy: createdBy,
            revoked: revoked);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

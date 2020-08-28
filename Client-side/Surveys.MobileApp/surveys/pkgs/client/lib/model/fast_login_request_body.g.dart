// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fast_login_request_body.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FastLoginRequestBody> _$fastLoginRequestBodySerializer =
    new _$FastLoginRequestBodySerializer();

class _$FastLoginRequestBodySerializer
    implements StructuredSerializer<FastLoginRequestBody> {
  @override
  final Iterable<Type> types = const [
    FastLoginRequestBody,
    _$FastLoginRequestBody
  ];
  @override
  final String wireName = 'FastLoginRequestBody';

  @override
  Iterable<Object> serialize(
      Serializers serializers, FastLoginRequestBody object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.token != null) {
      result
        ..add('token')
        ..add(serializers.serialize(object.token,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  FastLoginRequestBody deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FastLoginRequestBodyBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$FastLoginRequestBody extends FastLoginRequestBody {
  @override
  final String token;

  factory _$FastLoginRequestBody(
          [void Function(FastLoginRequestBodyBuilder) updates]) =>
      (new FastLoginRequestBodyBuilder()..update(updates)).build();

  _$FastLoginRequestBody._({this.token}) : super._();

  @override
  FastLoginRequestBody rebuild(
          void Function(FastLoginRequestBodyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FastLoginRequestBodyBuilder toBuilder() =>
      new FastLoginRequestBodyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FastLoginRequestBody && token == other.token;
  }

  @override
  int get hashCode {
    return $jf($jc(0, token.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FastLoginRequestBody')
          ..add('token', token))
        .toString();
  }
}

class FastLoginRequestBodyBuilder
    implements Builder<FastLoginRequestBody, FastLoginRequestBodyBuilder> {
  _$FastLoginRequestBody _$v;

  String _token;
  String get token => _$this._token;
  set token(String token) => _$this._token = token;

  FastLoginRequestBodyBuilder();

  FastLoginRequestBodyBuilder get _$this {
    if (_$v != null) {
      _token = _$v.token;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FastLoginRequestBody other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FastLoginRequestBody;
  }

  @override
  void update(void Function(FastLoginRequestBodyBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FastLoginRequestBody build() {
    final _$result = _$v ?? new _$FastLoginRequestBody._(token: token);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

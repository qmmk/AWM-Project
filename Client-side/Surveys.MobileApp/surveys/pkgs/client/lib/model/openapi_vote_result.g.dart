// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openapi_vote_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OpenapiVoteResult> _$openapiVoteResultSerializer =
    new _$OpenapiVoteResultSerializer();

class _$OpenapiVoteResultSerializer
    implements StructuredSerializer<OpenapiVoteResult> {
  @override
  final Iterable<Type> types = const [OpenapiVoteResult, _$OpenapiVoteResult];
  @override
  final String wireName = 'OpenapiVoteResult';

  @override
  Iterable<Object> serialize(Serializers serializers, OpenapiVoteResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.sdid != null) {
      result
        ..add('sdid')
        ..add(serializers.serialize(object.sdid,
            specifiedType: const FullType(int)));
    }
    if (object.votes != null) {
      result
        ..add('votes')
        ..add(serializers.serialize(object.votes,
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  OpenapiVoteResult deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OpenapiVoteResultBuilder();

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
        case 'votes':
          result.votes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$OpenapiVoteResult extends OpenapiVoteResult {
  @override
  final int sdid;
  @override
  final int votes;

  factory _$OpenapiVoteResult(
          [void Function(OpenapiVoteResultBuilder) updates]) =>
      (new OpenapiVoteResultBuilder()..update(updates)).build();

  _$OpenapiVoteResult._({this.sdid, this.votes}) : super._();

  @override
  OpenapiVoteResult rebuild(void Function(OpenapiVoteResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OpenapiVoteResultBuilder toBuilder() =>
      new OpenapiVoteResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OpenapiVoteResult &&
        sdid == other.sdid &&
        votes == other.votes;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, sdid.hashCode), votes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OpenapiVoteResult')
          ..add('sdid', sdid)
          ..add('votes', votes))
        .toString();
  }
}

class OpenapiVoteResultBuilder
    implements Builder<OpenapiVoteResult, OpenapiVoteResultBuilder> {
  _$OpenapiVoteResult _$v;

  int _sdid;
  int get sdid => _$this._sdid;
  set sdid(int sdid) => _$this._sdid = sdid;

  int _votes;
  int get votes => _$this._votes;
  set votes(int votes) => _$this._votes = votes;

  OpenapiVoteResultBuilder();

  OpenapiVoteResultBuilder get _$this {
    if (_$v != null) {
      _sdid = _$v.sdid;
      _votes = _$v.votes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OpenapiVoteResult other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OpenapiVoteResult;
  }

  @override
  void update(void Function(OpenapiVoteResultBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OpenapiVoteResult build() {
    final _$result = _$v ?? new _$OpenapiVoteResult._(sdid: sdid, votes: votes);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openapi_vote_amount.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OpenapiVoteAmount> _$openapiVoteAmountSerializer =
    new _$OpenapiVoteAmountSerializer();

class _$OpenapiVoteAmountSerializer
    implements StructuredSerializer<OpenapiVoteAmount> {
  @override
  final Iterable<Type> types = const [OpenapiVoteAmount, _$OpenapiVoteAmount];
  @override
  final String wireName = 'OpenapiVoteAmount';

  @override
  Iterable<Object> serialize(Serializers serializers, OpenapiVoteAmount object,
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
  OpenapiVoteAmount deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OpenapiVoteAmountBuilder();

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

class _$OpenapiVoteAmount extends OpenapiVoteAmount {
  @override
  final int sdid;
  @override
  final int votes;

  factory _$OpenapiVoteAmount(
          [void Function(OpenapiVoteAmountBuilder) updates]) =>
      (new OpenapiVoteAmountBuilder()..update(updates)).build();

  _$OpenapiVoteAmount._({this.sdid, this.votes}) : super._();

  @override
  OpenapiVoteAmount rebuild(void Function(OpenapiVoteAmountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OpenapiVoteAmountBuilder toBuilder() =>
      new OpenapiVoteAmountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OpenapiVoteAmount &&
        sdid == other.sdid &&
        votes == other.votes;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, sdid.hashCode), votes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OpenapiVoteAmount')
          ..add('sdid', sdid)
          ..add('votes', votes))
        .toString();
  }
}

class OpenapiVoteAmountBuilder
    implements Builder<OpenapiVoteAmount, OpenapiVoteAmountBuilder> {
  _$OpenapiVoteAmount _$v;

  int _sdid;
  int get sdid => _$this._sdid;
  set sdid(int sdid) => _$this._sdid = sdid;

  int _votes;
  int get votes => _$this._votes;
  set votes(int votes) => _$this._votes = votes;

  OpenapiVoteAmountBuilder();

  OpenapiVoteAmountBuilder get _$this {
    if (_$v != null) {
      _sdid = _$v.sdid;
      _votes = _$v.votes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OpenapiVoteAmount other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OpenapiVoteAmount;
  }

  @override
  void update(void Function(OpenapiVoteAmountBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OpenapiVoteAmount build() {
    final _$result = _$v ?? new _$OpenapiVoteAmount._(sdid: sdid, votes: votes);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

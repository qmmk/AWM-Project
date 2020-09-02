// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openapi_vote.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OpenapiVote> _$openapiVoteSerializer = new _$OpenapiVoteSerializer();

class _$OpenapiVoteSerializer implements StructuredSerializer<OpenapiVote> {
  @override
  final Iterable<Type> types = const [OpenapiVote, _$OpenapiVote];
  @override
  final String wireName = 'OpenapiVote';

  @override
  Iterable<Object> serialize(Serializers serializers, OpenapiVote object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.avid != null) {
      result
        ..add('avid')
        ..add(serializers.serialize(object.avid,
            specifiedType: const FullType(int)));
    }
    if (object.pid != null) {
      result
        ..add('pid')
        ..add(serializers.serialize(object.pid,
            specifiedType: const FullType(int)));
    }
    if (object.sdid != null) {
      result
        ..add('sdid')
        ..add(serializers.serialize(object.sdid,
            specifiedType: const FullType(int)));
    }
    if (object.registeredOn != null) {
      result
        ..add('registeredOn')
        ..add(serializers.serialize(object.registeredOn,
            specifiedType: const FullType(String)));
    }
    if (object.customField01 != null) {
      result
        ..add('customField01')
        ..add(serializers.serialize(object.customField01,
            specifiedType: const FullType(String)));
    }
    if (object.customField02 != null) {
      result
        ..add('customField02')
        ..add(serializers.serialize(object.customField02,
            specifiedType: const FullType(String)));
    }
    if (object.customField03 != null) {
      result
        ..add('customField03')
        ..add(serializers.serialize(object.customField03,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  OpenapiVote deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OpenapiVoteBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'avid':
          result.avid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'pid':
          result.pid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'sdid':
          result.sdid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'registeredOn':
          result.registeredOn = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'customField01':
          result.customField01 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'customField02':
          result.customField02 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'customField03':
          result.customField03 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$OpenapiVote extends OpenapiVote {
  @override
  final int avid;
  @override
  final int pid;
  @override
  final int sdid;
  @override
  final String registeredOn;
  @override
  final String customField01;
  @override
  final String customField02;
  @override
  final String customField03;

  factory _$OpenapiVote([void Function(OpenapiVoteBuilder) updates]) =>
      (new OpenapiVoteBuilder()..update(updates)).build();

  _$OpenapiVote._(
      {this.avid,
      this.pid,
      this.sdid,
      this.registeredOn,
      this.customField01,
      this.customField02,
      this.customField03})
      : super._();

  @override
  OpenapiVote rebuild(void Function(OpenapiVoteBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OpenapiVoteBuilder toBuilder() => new OpenapiVoteBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OpenapiVote &&
        avid == other.avid &&
        pid == other.pid &&
        sdid == other.sdid &&
        registeredOn == other.registeredOn &&
        customField01 == other.customField01 &&
        customField02 == other.customField02 &&
        customField03 == other.customField03;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, avid.hashCode), pid.hashCode),
                        sdid.hashCode),
                    registeredOn.hashCode),
                customField01.hashCode),
            customField02.hashCode),
        customField03.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OpenapiVote')
          ..add('avid', avid)
          ..add('pid', pid)
          ..add('sdid', sdid)
          ..add('registeredOn', registeredOn)
          ..add('customField01', customField01)
          ..add('customField02', customField02)
          ..add('customField03', customField03))
        .toString();
  }
}

class OpenapiVoteBuilder implements Builder<OpenapiVote, OpenapiVoteBuilder> {
  _$OpenapiVote _$v;

  int _avid;
  int get avid => _$this._avid;
  set avid(int avid) => _$this._avid = avid;

  int _pid;
  int get pid => _$this._pid;
  set pid(int pid) => _$this._pid = pid;

  int _sdid;
  int get sdid => _$this._sdid;
  set sdid(int sdid) => _$this._sdid = sdid;

  String _registeredOn;
  String get registeredOn => _$this._registeredOn;
  set registeredOn(String registeredOn) => _$this._registeredOn = registeredOn;

  String _customField01;
  String get customField01 => _$this._customField01;
  set customField01(String customField01) =>
      _$this._customField01 = customField01;

  String _customField02;
  String get customField02 => _$this._customField02;
  set customField02(String customField02) =>
      _$this._customField02 = customField02;

  String _customField03;
  String get customField03 => _$this._customField03;
  set customField03(String customField03) =>
      _$this._customField03 = customField03;

  OpenapiVoteBuilder();

  OpenapiVoteBuilder get _$this {
    if (_$v != null) {
      _avid = _$v.avid;
      _pid = _$v.pid;
      _sdid = _$v.sdid;
      _registeredOn = _$v.registeredOn;
      _customField01 = _$v.customField01;
      _customField02 = _$v.customField02;
      _customField03 = _$v.customField03;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OpenapiVote other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OpenapiVote;
  }

  @override
  void update(void Function(OpenapiVoteBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OpenapiVote build() {
    final _$result = _$v ??
        new _$OpenapiVote._(
            avid: avid,
            pid: pid,
            sdid: sdid,
            registeredOn: registeredOn,
            customField01: customField01,
            customField02: customField02,
            customField03: customField03);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

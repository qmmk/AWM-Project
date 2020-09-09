// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openapi_survey_detail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OpenapiSurveyDetail> _$openapiSurveyDetailSerializer =
    new _$OpenapiSurveyDetailSerializer();

class _$OpenapiSurveyDetailSerializer
    implements StructuredSerializer<OpenapiSurveyDetail> {
  @override
  final Iterable<Type> types = const [
    OpenapiSurveyDetail,
    _$OpenapiSurveyDetail
  ];
  @override
  final String wireName = 'OpenapiSurveyDetail';

  @override
  Iterable<Object> serialize(
      Serializers serializers, OpenapiSurveyDetail object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.sdid != null) {
      result
        ..add('sdid')
        ..add(serializers.serialize(object.sdid,
            specifiedType: const FullType(int)));
    }
    if (object.seid != null) {
      result
        ..add('seid')
        ..add(serializers.serialize(object.seid,
            specifiedType: const FullType(int)));
    }
    if (object.descr != null) {
      result
        ..add('descr')
        ..add(serializers.serialize(object.descr,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  OpenapiSurveyDetail deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OpenapiSurveyDetailBuilder();

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
        case 'seid':
          result.seid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'descr':
          result.descr = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$OpenapiSurveyDetail extends OpenapiSurveyDetail {
  @override
  final int sdid;
  @override
  final int seid;
  @override
  final String descr;

  factory _$OpenapiSurveyDetail(
          [void Function(OpenapiSurveyDetailBuilder) updates]) =>
      (new OpenapiSurveyDetailBuilder()..update(updates)).build();

  _$OpenapiSurveyDetail._({this.sdid, this.seid, this.descr}) : super._();

  @override
  OpenapiSurveyDetail rebuild(
          void Function(OpenapiSurveyDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OpenapiSurveyDetailBuilder toBuilder() =>
      new OpenapiSurveyDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OpenapiSurveyDetail &&
        sdid == other.sdid &&
        seid == other.seid &&
        descr == other.descr;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, sdid.hashCode), seid.hashCode), descr.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OpenapiSurveyDetail')
          ..add('sdid', sdid)
          ..add('seid', seid)
          ..add('descr', descr))
        .toString();
  }
}

class OpenapiSurveyDetailBuilder
    implements Builder<OpenapiSurveyDetail, OpenapiSurveyDetailBuilder> {
  _$OpenapiSurveyDetail _$v;

  int _sdid;
  int get sdid => _$this._sdid;
  set sdid(int sdid) => _$this._sdid = sdid;

  int _seid;
  int get seid => _$this._seid;
  set seid(int seid) => _$this._seid = seid;

  String _descr;
  String get descr => _$this._descr;
  set descr(String descr) => _$this._descr = descr;

  OpenapiSurveyDetailBuilder();

  OpenapiSurveyDetailBuilder get _$this {
    if (_$v != null) {
      _sdid = _$v.sdid;
      _seid = _$v.seid;
      _descr = _$v.descr;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OpenapiSurveyDetail other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OpenapiSurveyDetail;
  }

  @override
  void update(void Function(OpenapiSurveyDetailBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OpenapiSurveyDetail build() {
    final _$result = _$v ??
        new _$OpenapiSurveyDetail._(sdid: sdid, seid: seid, descr: descr);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

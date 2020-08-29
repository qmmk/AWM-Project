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
    if (object.customField01 != null) {
      result
        ..add('CustomField01')
        ..add(serializers.serialize(object.customField01,
            specifiedType: const FullType(String)));
    }
    if (object.customField02 != null) {
      result
        ..add('CustomField02')
        ..add(serializers.serialize(object.customField02,
            specifiedType: const FullType(String)));
    }
    if (object.customField03 != null) {
      result
        ..add('CustomField03')
        ..add(serializers.serialize(object.customField03,
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
        case 'CustomField01':
          result.customField01 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'CustomField02':
          result.customField02 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'CustomField03':
          result.customField03 = serializers.deserialize(value,
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
  @override
  final String customField01;
  @override
  final String customField02;
  @override
  final String customField03;

  factory _$OpenapiSurveyDetail(
          [void Function(OpenapiSurveyDetailBuilder) updates]) =>
      (new OpenapiSurveyDetailBuilder()..update(updates)).build();

  _$OpenapiSurveyDetail._(
      {this.sdid,
      this.seid,
      this.descr,
      this.customField01,
      this.customField02,
      this.customField03})
      : super._();

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
        descr == other.descr &&
        customField01 == other.customField01 &&
        customField02 == other.customField02 &&
        customField03 == other.customField03;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, sdid.hashCode), seid.hashCode), descr.hashCode),
                customField01.hashCode),
            customField02.hashCode),
        customField03.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OpenapiSurveyDetail')
          ..add('sdid', sdid)
          ..add('seid', seid)
          ..add('descr', descr)
          ..add('customField01', customField01)
          ..add('customField02', customField02)
          ..add('customField03', customField03))
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

  OpenapiSurveyDetailBuilder();

  OpenapiSurveyDetailBuilder get _$this {
    if (_$v != null) {
      _sdid = _$v.sdid;
      _seid = _$v.seid;
      _descr = _$v.descr;
      _customField01 = _$v.customField01;
      _customField02 = _$v.customField02;
      _customField03 = _$v.customField03;
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
        new _$OpenapiSurveyDetail._(
            sdid: sdid,
            seid: seid,
            descr: descr,
            customField01: customField01,
            customField02: customField02,
            customField03: customField03);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

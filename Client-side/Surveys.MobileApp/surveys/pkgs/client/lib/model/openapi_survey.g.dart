// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'openapi_survey.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OpenapiSurvey> _$openapiSurveySerializer =
    new _$OpenapiSurveySerializer();

class _$OpenapiSurveySerializer implements StructuredSerializer<OpenapiSurvey> {
  @override
  final Iterable<Type> types = const [OpenapiSurvey, _$OpenapiSurvey];
  @override
  final String wireName = 'OpenapiSurvey';

  @override
  Iterable<Object> serialize(Serializers serializers, OpenapiSurvey object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.seid != null) {
      result
        ..add('seid')
        ..add(serializers.serialize(object.seid,
            specifiedType: const FullType(int)));
    }
    if (object.title != null) {
      result
        ..add('title')
        ..add(serializers.serialize(object.title,
            specifiedType: const FullType(String)));
    }
    if (object.descr != null) {
      result
        ..add('descr')
        ..add(serializers.serialize(object.descr,
            specifiedType: const FullType(String)));
    }
    if (object.customField01 != null) {
      result
        ..add('customField01')
        ..add(serializers.serialize(object.customField01,
            specifiedType: const FullType(String)));
    }
    if (object.isOpen != null) {
      result
        ..add('isOpen')
        ..add(serializers.serialize(object.isOpen,
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
  OpenapiSurvey deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OpenapiSurveyBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'seid':
          result.seid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'descr':
          result.descr = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'customField01':
          result.customField01 = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isOpen':
          result.isOpen = serializers.deserialize(value,
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

class _$OpenapiSurvey extends OpenapiSurvey {
  @override
  final int seid;
  @override
  final String title;
  @override
  final String descr;
  @override
  final String customField01;
  @override
  final String isOpen;
  @override
  final String customField03;

  factory _$OpenapiSurvey([void Function(OpenapiSurveyBuilder) updates]) =>
      (new OpenapiSurveyBuilder()..update(updates)).build();

  _$OpenapiSurvey._(
      {this.seid,
      this.title,
      this.descr,
      this.customField01,
      this.isOpen,
      this.customField03})
      : super._();

  @override
  OpenapiSurvey rebuild(void Function(OpenapiSurveyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OpenapiSurveyBuilder toBuilder() => new OpenapiSurveyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OpenapiSurvey &&
        seid == other.seid &&
        title == other.title &&
        descr == other.descr &&
        customField01 == other.customField01 &&
        isOpen == other.isOpen &&
        customField03 == other.customField03;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, seid.hashCode), title.hashCode), descr.hashCode),
                customField01.hashCode),
            isOpen.hashCode),
        customField03.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OpenapiSurvey')
          ..add('seid', seid)
          ..add('title', title)
          ..add('descr', descr)
          ..add('customField01', customField01)
          ..add('isOpen', isOpen)
          ..add('customField03', customField03))
        .toString();
  }
}

class OpenapiSurveyBuilder
    implements Builder<OpenapiSurvey, OpenapiSurveyBuilder> {
  _$OpenapiSurvey _$v;

  int _seid;
  int get seid => _$this._seid;
  set seid(int seid) => _$this._seid = seid;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _descr;
  String get descr => _$this._descr;
  set descr(String descr) => _$this._descr = descr;

  String _customField01;
  String get customField01 => _$this._customField01;
  set customField01(String customField01) =>
      _$this._customField01 = customField01;

  String _isOpen;
  String get isOpen => _$this._isOpen;
  set isOpen(String isOpen) => _$this._isOpen = isOpen;

  String _customField03;
  String get customField03 => _$this._customField03;
  set customField03(String customField03) =>
      _$this._customField03 = customField03;

  OpenapiSurveyBuilder();

  OpenapiSurveyBuilder get _$this {
    if (_$v != null) {
      _seid = _$v.seid;
      _title = _$v.title;
      _descr = _$v.descr;
      _customField01 = _$v.customField01;
      _isOpen = _$v.isOpen;
      _customField03 = _$v.customField03;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OpenapiSurvey other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OpenapiSurvey;
  }

  @override
  void update(void Function(OpenapiSurveyBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OpenapiSurvey build() {
    final _$result = _$v ??
        new _$OpenapiSurvey._(
            seid: seid,
            title: title,
            descr: descr,
            customField01: customField01,
            isOpen: isOpen,
            customField03: customField03);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

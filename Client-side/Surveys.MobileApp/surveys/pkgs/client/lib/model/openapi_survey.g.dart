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
    if (object.isOpen != null) {
      result
        ..add('isOpen')
        ..add(serializers.serialize(object.isOpen,
            specifiedType: const FullType(bool)));
    }
    if (object.createdBy != null) {
      result
        ..add('createdBy')
        ..add(serializers.serialize(object.createdBy,
            specifiedType: const FullType(int)));
    }
    if (object.surveyDetails != null) {
      result
        ..add('surveyDetails')
        ..add(serializers.serialize(object.surveyDetails,
            specifiedType: const FullType(
                BuiltList, const [const FullType(OpenapiSurveyDetail)])));
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
        case 'isOpen':
          result.isOpen = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'createdBy':
          result.createdBy = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'surveyDetails':
          result.surveyDetails.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(OpenapiSurveyDetail)]))
              as BuiltList<Object>);
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
  final bool isOpen;
  @override
  final int createdBy;
  @override
  final BuiltList<OpenapiSurveyDetail> surveyDetails;

  factory _$OpenapiSurvey([void Function(OpenapiSurveyBuilder) updates]) =>
      (new OpenapiSurveyBuilder()..update(updates)).build();

  _$OpenapiSurvey._(
      {this.seid,
      this.title,
      this.descr,
      this.isOpen,
      this.createdBy,
      this.surveyDetails})
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
        isOpen == other.isOpen &&
        createdBy == other.createdBy &&
        surveyDetails == other.surveyDetails;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc($jc(0, seid.hashCode), title.hashCode), descr.hashCode),
                isOpen.hashCode),
            createdBy.hashCode),
        surveyDetails.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OpenapiSurvey')
          ..add('seid', seid)
          ..add('title', title)
          ..add('descr', descr)
          ..add('isOpen', isOpen)
          ..add('createdBy', createdBy)
          ..add('surveyDetails', surveyDetails))
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

  bool _isOpen;
  bool get isOpen => _$this._isOpen;
  set isOpen(bool isOpen) => _$this._isOpen = isOpen;

  int _createdBy;
  int get createdBy => _$this._createdBy;
  set createdBy(int createdBy) => _$this._createdBy = createdBy;

  ListBuilder<OpenapiSurveyDetail> _surveyDetails;
  ListBuilder<OpenapiSurveyDetail> get surveyDetails =>
      _$this._surveyDetails ??= new ListBuilder<OpenapiSurveyDetail>();
  set surveyDetails(ListBuilder<OpenapiSurveyDetail> surveyDetails) =>
      _$this._surveyDetails = surveyDetails;

  OpenapiSurveyBuilder();

  OpenapiSurveyBuilder get _$this {
    if (_$v != null) {
      _seid = _$v.seid;
      _title = _$v.title;
      _descr = _$v.descr;
      _isOpen = _$v.isOpen;
      _createdBy = _$v.createdBy;
      _surveyDetails = _$v.surveyDetails?.toBuilder();
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
    _$OpenapiSurvey _$result;
    try {
      _$result = _$v ??
          new _$OpenapiSurvey._(
              seid: seid,
              title: title,
              descr: descr,
              isOpen: isOpen,
              createdBy: createdBy,
              surveyDetails: _surveyDetails?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'surveyDetails';
        _surveyDetails?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'OpenapiSurvey', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

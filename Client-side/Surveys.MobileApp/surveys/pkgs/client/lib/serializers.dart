library serializers;

import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'package:survey_client/model/login_request_body.dart';
import 'package:survey_client/model/login_response.dart';
import 'package:survey_client/model/refresh_token.dart';


part 'serializers.g.dart';

@SerializersFor(const [
LoginRequestBody,
LoginResponse,
RefreshToken,

])

//allow all models to be serialized within a list
Serializers serializers = (_$serializers.toBuilder()
..addBuilderFactory(
const FullType(BuiltList, const [const FullType(LoginRequestBody)]),
() => new ListBuilder<LoginRequestBody>())
..addBuilderFactory(
const FullType(BuiltList, const [const FullType(LoginResponse)]),
() => new ListBuilder<LoginResponse>())
..addBuilderFactory(
const FullType(BuiltList, const [const FullType(RefreshToken)]),
() => new ListBuilder<RefreshToken>())

..add(Iso8601DateTimeSerializer())
).build();

Serializers standardSerializers =
(serializers.toBuilder()
..addPlugin(StandardJsonPlugin())).build();

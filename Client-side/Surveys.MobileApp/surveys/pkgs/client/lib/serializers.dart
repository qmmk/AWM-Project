library serializers;

import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'package:survey_client/model/fast_login_request_body.dart';
import 'package:survey_client/model/login_request_body.dart';
import 'package:survey_client/model/login_response.dart';
import 'package:survey_client/model/logout_response.dart';
import 'package:survey_client/model/only_pid_parameter.dart';
import 'package:survey_client/model/refresh_token.dart';
import 'package:survey_client/model/user.dart';


part 'serializers.g.dart';

@SerializersFor(const [
FastLoginRequestBody,
LoginRequestBody,
LoginResponse,
LogoutResponse,
OnlyPidParameter,
RefreshToken,
User,

])

//allow all models to be serialized within a list
Serializers serializers = (_$serializers.toBuilder()
..addBuilderFactory(
const FullType(BuiltList, const [const FullType(FastLoginRequestBody)]),
() => new ListBuilder<FastLoginRequestBody>())
..addBuilderFactory(
const FullType(BuiltList, const [const FullType(LoginRequestBody)]),
() => new ListBuilder<LoginRequestBody>())
..addBuilderFactory(
const FullType(BuiltList, const [const FullType(LoginResponse)]),
() => new ListBuilder<LoginResponse>())
..addBuilderFactory(
const FullType(BuiltList, const [const FullType(LogoutResponse)]),
() => new ListBuilder<LogoutResponse>())
..addBuilderFactory(
const FullType(BuiltList, const [const FullType(OnlyPidParameter)]),
() => new ListBuilder<OnlyPidParameter>())
..addBuilderFactory(
const FullType(BuiltList, const [const FullType(RefreshToken)]),
() => new ListBuilder<RefreshToken>())
..addBuilderFactory(
const FullType(BuiltList, const [const FullType(User)]),
() => new ListBuilder<User>())

..add(Iso8601DateTimeSerializer())
).build();

Serializers standardSerializers =
(serializers.toBuilder()
..addPlugin(StandardJsonPlugin())).build();

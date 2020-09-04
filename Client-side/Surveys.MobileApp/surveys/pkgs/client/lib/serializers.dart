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
import 'package:survey_client/model/openapi_survey.dart';
import 'package:survey_client/model/openapi_survey_detail.dart';
import 'package:survey_client/model/openapi_user.dart';
import 'package:survey_client/model/openapi_vote.dart';
import 'package:survey_client/model/openapi_vote_amount.dart';
import 'package:survey_client/model/refresh_token.dart';


part 'serializers.g.dart';

@SerializersFor(const [
FastLoginRequestBody,
LoginRequestBody,
LoginResponse,
LogoutResponse,
OnlyPidParameter,
OpenapiSurvey,
OpenapiSurveyDetail,
OpenapiUser,
OpenapiVote,
OpenapiVoteAmount,
RefreshToken,

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
const FullType(BuiltList, const [const FullType(OpenapiSurvey)]),
() => new ListBuilder<OpenapiSurvey>())
..addBuilderFactory(
const FullType(BuiltList, const [const FullType(OpenapiSurveyDetail)]),
() => new ListBuilder<OpenapiSurveyDetail>())
..addBuilderFactory(
const FullType(BuiltList, const [const FullType(OpenapiUser)]),
() => new ListBuilder<OpenapiUser>())
..addBuilderFactory(
const FullType(BuiltList, const [const FullType(OpenapiVote)]),
() => new ListBuilder<OpenapiVote>())
..addBuilderFactory(
const FullType(BuiltList, const [const FullType(OpenapiVoteAmount)]),
() => new ListBuilder<OpenapiVoteAmount>())
..addBuilderFactory(
const FullType(BuiltList, const [const FullType(RefreshToken)]),
() => new ListBuilder<RefreshToken>())

..add(Iso8601DateTimeSerializer())
).build();

Serializers standardSerializers =
(serializers.toBuilder()
..addPlugin(StandardJsonPlugin())).build();

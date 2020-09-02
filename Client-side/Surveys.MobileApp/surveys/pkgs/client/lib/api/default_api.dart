import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

import 'package:survey_client/model/openapi_survey.dart';
import 'package:survey_client/model/only_pid_parameter.dart';
import 'package:survey_client/model/fast_login_request_body.dart';
import 'package:survey_client/model/logout_response.dart';
import 'package:survey_client/model/login_response.dart';
import 'package:survey_client/model/openapi_vote.dart';
import 'package:survey_client/model/openapi_user.dart';
import 'package:survey_client/model/login_request_body.dart';
import 'package:survey_client/model/openapi_survey_detail.dart';

class DefaultApi {
    final Dio _dio;
    Serializers _serializers;

    DefaultApi(this._dio, this._serializers);

        /// 
        ///
        /// Create survey
        Future<Response<List<OpenapiSurvey>>>createSurvey(List<OpenapiSurvey> openapiSurvey,{ CancelToken cancelToken, Map<String, String> headers,}) async {

        String _path = "/service/addSurveyEntity";

        Map<String, dynamic> queryParams = {};
        Map<String, String> headerParams = Map.from(headers ?? {});
        dynamic bodyData;

        queryParams.removeWhere((key, value) => value == null);
        headerParams.removeWhere((key, value) => value == null);

        List<String> contentTypes = ["application/json"];


            final type = const FullType(BuiltList, const [const FullType(OpenapiSurvey)]);
            var serializedBody = _serializers.serialize(BuiltList<OpenapiSurvey>.from(openapiSurvey), specifiedType: type);
            var jsonopenapiSurvey = json.encode(serializedBody);
            bodyData = jsonopenapiSurvey;

            return _dio.request(
            _path,
            queryParameters: queryParams,
            data: bodyData,
            options: Options(
            method: 'post'.toUpperCase(),
            headers: headerParams,
            extra: {
                'secure': [],
            },
            contentType: contentTypes.isNotEmpty ? contentTypes[0] : "application/json",
            ),
            cancelToken: cancelToken,
            ).then((response) {

                final FullType type = const FullType(BuiltList, const [const FullType(OpenapiSurvey)]);
                BuiltList<OpenapiSurvey> dataList = _serializers.deserialize(response.data is String ? jsonDecode(response.data) : response.data, specifiedType: type);
                var data = dataList.toList();

            return Response<List<OpenapiSurvey>>(
                data: data,
                headers: response.headers,
                request: response.request,
                redirects: response.redirects,
                statusCode: response.statusCode,
                statusMessage: response.statusMessage,
                extra: response.extra,
            );
            });
            }
        /// 
        ///
        /// Deletes a survey
        Future<Response>deleteSurvey({ int seid,CancelToken cancelToken, Map<String, String> headers,}) async {

        String _path = "/service/deleteSurvey";

        Map<String, dynamic> queryParams = {};
        Map<String, String> headerParams = Map.from(headers ?? {});
        dynamic bodyData;

                queryParams[r'seid'] = seid;
        queryParams.removeWhere((key, value) => value == null);
        headerParams.removeWhere((key, value) => value == null);

        List<String> contentTypes = [];



            return _dio.request(
            _path,
            queryParameters: queryParams,
            data: bodyData,
            options: Options(
            method: 'delete'.toUpperCase(),
            headers: headerParams,
            extra: {
                'secure': [],
            },
            contentType: contentTypes.isNotEmpty ? contentTypes[0] : "application/json",
            ),
            cancelToken: cancelToken,
            );
            }
        /// 
        ///
        /// Login with refresh token
        Future<Response<LoginResponse>>fastLogin(FastLoginRequestBody fastLoginRequestBody,{ CancelToken cancelToken, Map<String, String> headers,}) async {

        String _path = "/service/fastLogin";

        Map<String, dynamic> queryParams = {};
        Map<String, String> headerParams = Map.from(headers ?? {});
        dynamic bodyData;

        queryParams.removeWhere((key, value) => value == null);
        headerParams.removeWhere((key, value) => value == null);

        List<String> contentTypes = ["application/json"];


            var serializedBody = _serializers.serialize(fastLoginRequestBody);
            var jsonfastLoginRequestBody = json.encode(serializedBody);
            bodyData = jsonfastLoginRequestBody;

            return _dio.request(
            _path,
            queryParameters: queryParams,
            data: bodyData,
            options: Options(
            method: 'post'.toUpperCase(),
            headers: headerParams,
            extra: {
                'secure': [],
            },
            contentType: contentTypes.isNotEmpty ? contentTypes[0] : "application/json",
            ),
            cancelToken: cancelToken,
            ).then((response) {

        var serializer = _serializers.serializerForType(LoginResponse);
        var data = _serializers.deserializeWith<LoginResponse>(serializer, response.data is String ? jsonDecode(response.data) : response.data);

            return Response<LoginResponse>(
                data: data,
                headers: response.headers,
                request: response.request,
                redirects: response.redirects,
                statusCode: response.statusCode,
                statusMessage: response.statusMessage,
                extra: response.extra,
            );
            });
            }
        /// 
        ///
        /// Gets the specified survey&#39;s entries
        Future<Response<List<OpenapiSurveyDetail>>>getSurveyDetails({ int seid,CancelToken cancelToken, Map<String, String> headers,}) async {

        String _path = "/service/getSurveyDetails";

        Map<String, dynamic> queryParams = {};
        Map<String, String> headerParams = Map.from(headers ?? {});
        dynamic bodyData;

                queryParams[r'seid'] = seid;
        queryParams.removeWhere((key, value) => value == null);
        headerParams.removeWhere((key, value) => value == null);

        List<String> contentTypes = [];



            return _dio.request(
            _path,
            queryParameters: queryParams,
            data: bodyData,
            options: Options(
            method: 'get'.toUpperCase(),
            headers: headerParams,
            extra: {
                'secure': [],
            },
            contentType: contentTypes.isNotEmpty ? contentTypes[0] : "application/json",
            ),
            cancelToken: cancelToken,
            ).then((response) {

                final FullType type = const FullType(BuiltList, const [const FullType(OpenapiSurveyDetail)]);
                BuiltList<OpenapiSurveyDetail> dataList = _serializers.deserialize(response.data is String ? jsonDecode(response.data) : response.data, specifiedType: type);
                var data = dataList.toList();

            return Response<List<OpenapiSurveyDetail>>(
                data: data,
                headers: response.headers,
                request: response.request,
                redirects: response.redirects,
                statusCode: response.statusCode,
                statusMessage: response.statusMessage,
                extra: response.extra,
            );
            });
            }
        /// 
        ///
        /// Inserts a vote
        Future<Response>insertActualVote(List<OpenapiVote> openapiVote,{ CancelToken cancelToken, Map<String, String> headers,}) async {

        String _path = "/service/insertActualVote";

        Map<String, dynamic> queryParams = {};
        Map<String, String> headerParams = Map.from(headers ?? {});
        dynamic bodyData;

        queryParams.removeWhere((key, value) => value == null);
        headerParams.removeWhere((key, value) => value == null);

        List<String> contentTypes = ["application/json"];


            final type = const FullType(BuiltList, const [const FullType(OpenapiVote)]);
            var serializedBody = _serializers.serialize(BuiltList<OpenapiVote>.from(openapiVote), specifiedType: type);
            var jsonopenapiVote = json.encode(serializedBody);
            bodyData = jsonopenapiVote;

            return _dio.request(
            _path,
            queryParameters: queryParams,
            data: bodyData,
            options: Options(
            method: 'post'.toUpperCase(),
            headers: headerParams,
            extra: {
                'secure': [],
            },
            contentType: contentTypes.isNotEmpty ? contentTypes[0] : "application/json",
            ),
            cancelToken: cancelToken,
            );
            }
        /// 
        ///
        /// load all surveys by user
        Future<Response<List<OpenapiSurvey>>>loadAllSurveysByUser({ int pid,CancelToken cancelToken, Map<String, String> headers,}) async {

        String _path = "/service/loadAllSurveysByUser";

        Map<String, dynamic> queryParams = {};
        Map<String, String> headerParams = Map.from(headers ?? {});
        dynamic bodyData;

                queryParams[r'pid'] = pid;
        queryParams.removeWhere((key, value) => value == null);
        headerParams.removeWhere((key, value) => value == null);

        List<String> contentTypes = [];



            return _dio.request(
            _path,
            queryParameters: queryParams,
            data: bodyData,
            options: Options(
            method: 'get'.toUpperCase(),
            headers: headerParams,
            extra: {
                'secure': [],
            },
            contentType: contentTypes.isNotEmpty ? contentTypes[0] : "application/json",
            ),
            cancelToken: cancelToken,
            ).then((response) {

                final FullType type = const FullType(BuiltList, const [const FullType(OpenapiSurvey)]);
                BuiltList<OpenapiSurvey> dataList = _serializers.deserialize(response.data is String ? jsonDecode(response.data) : response.data, specifiedType: type);
                var data = dataList.toList();

            return Response<List<OpenapiSurvey>>(
                data: data,
                headers: response.headers,
                request: response.request,
                redirects: response.redirects,
                statusCode: response.statusCode,
                statusMessage: response.statusMessage,
                extra: response.extra,
            );
            });
            }
        /// 
        ///
        /// load all surveys except the ones of the current user
        Future<Response<List<OpenapiSurvey>>>loadAllSurveysExceptUser({ int pid,CancelToken cancelToken, Map<String, String> headers,}) async {

        String _path = "/service/loadAllSurveysExceptUser";

        Map<String, dynamic> queryParams = {};
        Map<String, String> headerParams = Map.from(headers ?? {});
        dynamic bodyData;

                queryParams[r'pid'] = pid;
        queryParams.removeWhere((key, value) => value == null);
        headerParams.removeWhere((key, value) => value == null);

        List<String> contentTypes = [];



            return _dio.request(
            _path,
            queryParameters: queryParams,
            data: bodyData,
            options: Options(
            method: 'get'.toUpperCase(),
            headers: headerParams,
            extra: {
                'secure': [],
            },
            contentType: contentTypes.isNotEmpty ? contentTypes[0] : "application/json",
            ),
            cancelToken: cancelToken,
            ).then((response) {

                final FullType type = const FullType(BuiltList, const [const FullType(OpenapiSurvey)]);
                BuiltList<OpenapiSurvey> dataList = _serializers.deserialize(response.data is String ? jsonDecode(response.data) : response.data, specifiedType: type);
                var data = dataList.toList();

            return Response<List<OpenapiSurvey>>(
                data: data,
                headers: response.headers,
                request: response.request,
                redirects: response.redirects,
                statusCode: response.statusCode,
                statusMessage: response.statusMessage,
                extra: response.extra,
            );
            });
            }
        /// 
        ///
        /// Performs a standard login
        Future<Response<LoginResponse>>login(LoginRequestBody loginRequestBody,{ CancelToken cancelToken, Map<String, String> headers,}) async {

        String _path = "/service/login";

        Map<String, dynamic> queryParams = {};
        Map<String, String> headerParams = Map.from(headers ?? {});
        dynamic bodyData;

        queryParams.removeWhere((key, value) => value == null);
        headerParams.removeWhere((key, value) => value == null);

        List<String> contentTypes = ["application/json"];


            var serializedBody = _serializers.serialize(loginRequestBody);
            var jsonloginRequestBody = json.encode(serializedBody);
            bodyData = jsonloginRequestBody;

            return _dio.request(
            _path,
            queryParameters: queryParams,
            data: bodyData,
            options: Options(
            method: 'post'.toUpperCase(),
            headers: headerParams,
            extra: {
                'secure': [],
            },
            contentType: contentTypes.isNotEmpty ? contentTypes[0] : "application/json",
            ),
            cancelToken: cancelToken,
            ).then((response) {

        var serializer = _serializers.serializerForType(LoginResponse);
        var data = _serializers.deserializeWith<LoginResponse>(serializer, response.data is String ? jsonDecode(response.data) : response.data);

            return Response<LoginResponse>(
                data: data,
                headers: response.headers,
                request: response.request,
                redirects: response.redirects,
                statusCode: response.statusCode,
                statusMessage: response.statusMessage,
                extra: response.extra,
            );
            });
            }
        /// 
        ///
        /// Logout
        Future<Response<LogoutResponse>>logout(OnlyPidParameter onlyPidParameter,{ CancelToken cancelToken, Map<String, String> headers,}) async {

        String _path = "/service/logout";

        Map<String, dynamic> queryParams = {};
        Map<String, String> headerParams = Map.from(headers ?? {});
        dynamic bodyData;

        queryParams.removeWhere((key, value) => value == null);
        headerParams.removeWhere((key, value) => value == null);

        List<String> contentTypes = ["application/json"];


            var serializedBody = _serializers.serialize(onlyPidParameter);
            var jsononlyPidParameter = json.encode(serializedBody);
            bodyData = jsononlyPidParameter;

            return _dio.request(
            _path,
            queryParameters: queryParams,
            data: bodyData,
            options: Options(
            method: 'post'.toUpperCase(),
            headers: headerParams,
            extra: {
                'secure': [],
            },
            contentType: contentTypes.isNotEmpty ? contentTypes[0] : "application/json",
            ),
            cancelToken: cancelToken,
            ).then((response) {

        var serializer = _serializers.serializerForType(LogoutResponse);
        var data = _serializers.deserializeWith<LogoutResponse>(serializer, response.data is String ? jsonDecode(response.data) : response.data);

            return Response<LogoutResponse>(
                data: data,
                headers: response.headers,
                request: response.request,
                redirects: response.redirects,
                statusCode: response.statusCode,
                statusMessage: response.statusMessage,
                extra: response.extra,
            );
            });
            }
        /// 
        ///
        /// Sign up
        Future<Response<bool>>signUp(OpenapiUser openapiUser,{ CancelToken cancelToken, Map<String, String> headers,}) async {

        String _path = "/service/signUp";

        Map<String, dynamic> queryParams = {};
        Map<String, String> headerParams = Map.from(headers ?? {});
        dynamic bodyData;

        queryParams.removeWhere((key, value) => value == null);
        headerParams.removeWhere((key, value) => value == null);

        List<String> contentTypes = ["application/json"];


            var serializedBody = _serializers.serialize(openapiUser);
            var jsonopenapiUser = json.encode(serializedBody);
            bodyData = jsonopenapiUser;

            return _dio.request(
            _path,
            queryParameters: queryParams,
            data: bodyData,
            options: Options(
            method: 'post'.toUpperCase(),
            headers: headerParams,
            extra: {
                'secure': [],
            },
            contentType: contentTypes.isNotEmpty ? contentTypes[0] : "application/json",
            ),
            cancelToken: cancelToken,
            ).then((response) {

        var serializer = _serializers.serializerForType(bool);
        var data = _serializers.deserializeWith<bool>(serializer, response.data is String ? jsonDecode(response.data) : response.data);

            return Response<bool>(
                data: data,
                headers: response.headers,
                request: response.request,
                redirects: response.redirects,
                statusCode: response.statusCode,
                statusMessage: response.statusMessage,
                extra: response.extra,
            );
            });
            }
        }

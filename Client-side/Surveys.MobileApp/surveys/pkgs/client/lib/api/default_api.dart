import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

import 'package:survey_client/model/login_response.dart';
import 'package:survey_client/model/login_request_body.dart';

class DefaultApi {
    final Dio _dio;
    Serializers _serializers;

    DefaultApi(this._dio, this._serializers);

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
        }

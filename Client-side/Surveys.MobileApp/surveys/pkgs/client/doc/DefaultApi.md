# survey_client.api.DefaultApi

## Load the API package
```dart
import 'package:survey_client/api.dart';
```

All URIs are relative to *https://192.168.1.206:45455*

Method | HTTP request | Description
------------- | ------------- | -------------
[**fastLogin**](DefaultApi.md#fastLogin) | **post** /service/fastlogin | 
[**loadAllSurveysByUser**](DefaultApi.md#loadAllSurveysByUser) | **get** /service/loadallsurveysbyuser | 
[**login**](DefaultApi.md#login) | **post** /service/login | 
[**logout**](DefaultApi.md#logout) | **post** /service/logout | 
[**signUp**](DefaultApi.md#signUp) | **post** /service/signup | 


# **fastLogin**
> LoginResponse fastLogin(fastLoginRequestBody)



Login with refresh token

### Example 
```dart
import 'package:survey_client/api.dart';

var api_instance = new DefaultApi();
var fastLoginRequestBody = new FastLoginRequestBody(); // FastLoginRequestBody | Refresh token

try { 
    var result = api_instance.fastLogin(fastLoginRequestBody);
    print(result);
} catch (e) {
    print("Exception when calling DefaultApi->fastLogin: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **fastLoginRequestBody** | [**FastLoginRequestBody**](FastLoginRequestBody.md)| Refresh token | 

### Return type

[**LoginResponse**](LoginResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, text/plain

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **loadAllSurveysByUser**
> List<OpenapiSurvey> loadAllSurveysByUser(pid)



load all surveys by user

### Example 
```dart
import 'package:survey_client/api.dart';

var api_instance = new DefaultApi();
var pid = 56; // int | 

try { 
    var result = api_instance.loadAllSurveysByUser(pid);
    print(result);
} catch (e) {
    print("Exception when calling DefaultApi->loadAllSurveysByUser: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pid** | **int**|  | [optional] [default to null]

### Return type

[**List<OpenapiSurvey>**](OpenapiSurvey.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **login**
> LoginResponse login(loginRequestBody)



Performs a standard login

### Example 
```dart
import 'package:survey_client/api.dart';

var api_instance = new DefaultApi();
var loginRequestBody = new LoginRequestBody(); // LoginRequestBody | Username and password

try { 
    var result = api_instance.login(loginRequestBody);
    print(result);
} catch (e) {
    print("Exception when calling DefaultApi->login: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loginRequestBody** | [**LoginRequestBody**](LoginRequestBody.md)| Username and password | 

### Return type

[**LoginResponse**](LoginResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json, text/plain

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **logout**
> LogoutResponse logout(onlyPidParameter)



Logout

### Example 
```dart
import 'package:survey_client/api.dart';

var api_instance = new DefaultApi();
var onlyPidParameter = new OnlyPidParameter(); // OnlyPidParameter | pid

try { 
    var result = api_instance.logout(onlyPidParameter);
    print(result);
} catch (e) {
    print("Exception when calling DefaultApi->logout: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **onlyPidParameter** | [**OnlyPidParameter**](OnlyPidParameter.md)| pid | 

### Return type

[**LogoutResponse**](LogoutResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **signUp**
> bool signUp(openapiUser)



Sign up

### Example 
```dart
import 'package:survey_client/api.dart';

var api_instance = new DefaultApi();
var openapiUser = new OpenapiUser(); // OpenapiUser | Username, Password and RoleID

try { 
    var result = api_instance.signUp(openapiUser);
    print(result);
} catch (e) {
    print("Exception when calling DefaultApi->signUp: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **openapiUser** | [**OpenapiUser**](OpenapiUser.md)| Username, Password and RoleID | 

### Return type

**bool**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: text/plain

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


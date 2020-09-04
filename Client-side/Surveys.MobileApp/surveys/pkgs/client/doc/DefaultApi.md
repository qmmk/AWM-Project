# survey_client.api.DefaultApi

## Load the API package
```dart
import 'package:survey_client/api.dart';
```

All URIs are relative to *https://192.168.1.206:45455*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createSurvey**](DefaultApi.md#createSurvey) | **post** /service/addSurveyEntity | 
[**deleteSurvey**](DefaultApi.md#deleteSurvey) | **delete** /service/deleteSurvey | 
[**fastLogin**](DefaultApi.md#fastLogin) | **post** /service/fastLogin | 
[**getSurveyDetails**](DefaultApi.md#getSurveyDetails) | **get** /service/getSurveyDetails | 
[**getUserSubmittedSurveys**](DefaultApi.md#getUserSubmittedSurveys) | **get** /service/getUserSubmittedSurveys | 
[**insertActualVote**](DefaultApi.md#insertActualVote) | **post** /service/insertActualVote | 
[**loadAllSurveysByUser**](DefaultApi.md#loadAllSurveysByUser) | **get** /service/loadAllSurveysByUser | 
[**loadAllSurveysExceptUser**](DefaultApi.md#loadAllSurveysExceptUser) | **get** /service/loadAllSurveysExceptUser | 
[**login**](DefaultApi.md#login) | **post** /service/login | 
[**logout**](DefaultApi.md#logout) | **post** /service/logout | 
[**signUp**](DefaultApi.md#signUp) | **post** /service/signUp | 


# **createSurvey**
> List<OpenapiSurvey> createSurvey(openapiSurvey)



Create survey

### Example 
```dart
import 'package:survey_client/api.dart';

var api_instance = new DefaultApi();
var openapiSurvey = [new List&lt;OpenapiSurvey&gt;()]; // List<OpenapiSurvey> | survey

try { 
    var result = api_instance.createSurvey(openapiSurvey);
    print(result);
} catch (e) {
    print("Exception when calling DefaultApi->createSurvey: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **openapiSurvey** | [**List&lt;OpenapiSurvey&gt;**](OpenapiSurvey.md)| survey | 

### Return type

[**List<OpenapiSurvey>**](OpenapiSurvey.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteSurvey**
> deleteSurvey(seid)



Deletes a survey

### Example 
```dart
import 'package:survey_client/api.dart';

var api_instance = new DefaultApi();
var seid = 56; // int | 

try { 
    api_instance.deleteSurvey(seid);
} catch (e) {
    print("Exception when calling DefaultApi->deleteSurvey: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **seid** | **int**|  | [optional] [default to null]

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

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
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSurveyDetails**
> List<OpenapiSurveyDetail> getSurveyDetails(seid)



Gets the specified survey's entries

### Example 
```dart
import 'package:survey_client/api.dart';

var api_instance = new DefaultApi();
var seid = 56; // int | 

try { 
    var result = api_instance.getSurveyDetails(seid);
    print(result);
} catch (e) {
    print("Exception when calling DefaultApi->getSurveyDetails: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **seid** | **int**|  | [optional] [default to null]

### Return type

[**List<OpenapiSurveyDetail>**](OpenapiSurveyDetail.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserSubmittedSurveys**
> List<int> getUserSubmittedSurveys(pid)



Gets user submitted surveys

### Example 
```dart
import 'package:survey_client/api.dart';

var api_instance = new DefaultApi();
var pid = 56; // int | 

try { 
    var result = api_instance.getUserSubmittedSurveys(pid);
    print(result);
} catch (e) {
    print("Exception when calling DefaultApi->getUserSubmittedSurveys: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pid** | **int**|  | [optional] [default to null]

### Return type

**List<int>**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **insertActualVote**
> insertActualVote(openapiVote)



Inserts a vote

### Example 
```dart
import 'package:survey_client/api.dart';

var api_instance = new DefaultApi();
var openapiVote = [new List&lt;OpenapiVote&gt;()]; // List<OpenapiVote> | votes

try { 
    api_instance.insertActualVote(openapiVote);
} catch (e) {
    print("Exception when calling DefaultApi->insertActualVote: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **openapiVote** | [**List&lt;OpenapiVote&gt;**](OpenapiVote.md)| votes | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

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

# **loadAllSurveysExceptUser**
> List<OpenapiSurvey> loadAllSurveysExceptUser(pid)



load all surveys except the ones of the current user

### Example 
```dart
import 'package:survey_client/api.dart';

var api_instance = new DefaultApi();
var pid = 56; // int | 

try { 
    var result = api_instance.loadAllSurveysExceptUser(pid);
    print(result);
} catch (e) {
    print("Exception when calling DefaultApi->loadAllSurveysExceptUser: $e\n");
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
> logout(onlyPidParameter)



Logout

### Example 
```dart
import 'package:survey_client/api.dart';

var api_instance = new DefaultApi();
var onlyPidParameter = new OnlyPidParameter(); // OnlyPidParameter | pid

try { 
    api_instance.logout(onlyPidParameter);
} catch (e) {
    print("Exception when calling DefaultApi->logout: $e\n");
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **onlyPidParameter** | [**OnlyPidParameter**](OnlyPidParameter.md)| pid | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

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


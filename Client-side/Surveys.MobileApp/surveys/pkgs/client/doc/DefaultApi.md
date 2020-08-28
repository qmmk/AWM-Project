# survey_client.api.DefaultApi

## Load the API package
```dart
import 'package:survey_client/api.dart';
```

All URIs are relative to *https://192.168.1.206:45455*

Method | HTTP request | Description
------------- | ------------- | -------------
[**login**](DefaultApi.md#login) | **post** /service/login | 


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
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)


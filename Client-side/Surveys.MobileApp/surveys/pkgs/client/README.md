# survey_client
API for Surveys

This Dart package is automatically generated by the [OpenAPI Generator](https://openapi-generator.tech) project:

- API version: 1.0.0
- Build package: org.openapitools.codegen.languages.DartDioClientCodegen

## Requirements

Dart 1.20.0 or later OR Flutter 0.0.20 or later

## Installation & Usage

### Github
If this Dart package is published to Github, please include the following in pubspec.yaml
```
name: survey_client
version: 0.0.1
description: Survey Server Client
dependencies:
  survey_client:
    git: https://github.com/GIT_USER_ID/GIT_REPO_ID.git
      version: 'any'
```

### Local
To use the package in your local drive, please include the following in pubspec.yaml
```
dependencies:
  survey_client:
    path: /path/to/survey_client
```

## Getting Started

Please follow the [installation procedure](#installation--usage) and then run the following:

```dart
import 'package:survey_client/api.dart';


var api_instance = new DefaultApi();
var openapiUser = new OpenapiUser(); // OpenapiUser | Username, Password and RoleID

try {
    api_instance.addUser(openapiUser);
} catch (e) {
    print("Exception when calling DefaultApi->addUser: $e\n");
}

```

## Documentation for API Endpoints

All URIs are relative to *https://surveyswebapiservice20200919015204.azurewebsites.net:443*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*DefaultApi* | [**addUser**](doc\/DefaultApi.md#adduser) | **post** /service/addUser | 
*DefaultApi* | [**createSurvey**](doc\/DefaultApi.md#createsurvey) | **post** /service/addSurveyEntity | 
*DefaultApi* | [**deleteSurvey**](doc\/DefaultApi.md#deletesurvey) | **delete** /service/deleteSurvey | 
*DefaultApi* | [**fastLogin**](doc\/DefaultApi.md#fastlogin) | **post** /service/fastLogin | 
*DefaultApi* | [**getActualPrincipalForVotes**](doc\/DefaultApi.md#getactualprincipalforvotes) | **get** /service/getActualPrincipalForVotes | 
*DefaultApi* | [**getActualVotes**](doc\/DefaultApi.md#getactualvotes) | **get** /service/getActualVotes | 
*DefaultApi* | [**getSurveyDetails**](doc\/DefaultApi.md#getsurveydetails) | **get** /service/getSurveyDetails | 
*DefaultApi* | [**getUserSubmittedSurveys**](doc\/DefaultApi.md#getusersubmittedsurveys) | **get** /service/getUserSubmittedSurveys | 
*DefaultApi* | [**insertActualVote**](doc\/DefaultApi.md#insertactualvote) | **post** /service/insertActualVote | 
*DefaultApi* | [**loadAllSurveysByUser**](doc\/DefaultApi.md#loadallsurveysbyuser) | **get** /service/loadAllSurveysByUser | 
*DefaultApi* | [**loadAllSurveysExceptUser**](doc\/DefaultApi.md#loadallsurveysexceptuser) | **get** /service/loadAllSurveysExceptUser | 
*DefaultApi* | [**login**](doc\/DefaultApi.md#login) | **post** /service/login | 
*DefaultApi* | [**logout**](doc\/DefaultApi.md#logout) | **post** /service/logout | 


## Documentation For Models

 - [FastLoginRequestBody](doc\/FastLoginRequestBody.md)
 - [LoginRequestBody](doc\/LoginRequestBody.md)
 - [LoginResponse](doc\/LoginResponse.md)
 - [LogoutResponse](doc\/LogoutResponse.md)
 - [OnlyPidParameter](doc\/OnlyPidParameter.md)
 - [OpenapiSurvey](doc\/OpenapiSurvey.md)
 - [OpenapiSurveyDetail](doc\/OpenapiSurveyDetail.md)
 - [OpenapiUser](doc\/OpenapiUser.md)
 - [OpenapiVote](doc\/OpenapiVote.md)
 - [OpenapiVoteAmount](doc\/OpenapiVoteAmount.md)
 - [OpenapiVoteUser](doc\/OpenapiVoteUser.md)
 - [RefreshToken](doc\/RefreshToken.md)


## Documentation For Authorization


## bearerAuth

- **Type**: HTTP basic authentication


## Author





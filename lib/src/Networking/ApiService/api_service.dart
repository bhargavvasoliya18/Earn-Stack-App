import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:earn_streak/src/Constants/app_keys.dart';
import 'package:earn_streak/src/Networking/NetworkHelper/custom_exception.dart';
import 'package:earn_streak/src/Repository/Services/Navigation/navigation_service.dart';
import 'package:earn_streak/src/Utils/Mixins/alert_dialog.dart';
import 'package:earn_streak/src/Utils/Mixins/progress_hub.dart';
import 'package:earn_streak/src/Utils/Mixins/toast_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum RequestMethods { GET, POST, PUT, DELETE, POSTFILE }
Map<String,String> commonHeader = {
  ApiServicesHeaderKEYs.accept: "application/json",
  ApiServicesHeaderKEYs.contentType: "application/json"
};

Map<String,String> commonHeaderWithToken = {
  ApiServicesHeaderKEYs.accept: "application/json",
  ApiServicesHeaderKEYs.contentType: "application/json",
  ApiServicesHeaderKEYs.authorization : "Bearer "
};

Map<String,String> commonHeaderWithMultiPartFormData={
  ApiServicesHeaderKEYs.authorization:"Bearer ",
  ApiServicesHeaderKEYs.contentType: "multipart/form-data",
};

class ApiService {
  static bool isHideProgress = false;
  static hideProgress(BuildContext context) {
    if (!isHideProgress) {
      Navigator.pop(context);
      isHideProgress = true;
    }
  }

  static Future<dynamic> request(String url, RequestMethods methods, {BuildContext? context,Map<String, String>? header, Map<String, dynamic>? requestBody, bool showLoader = true, bool showLogs = true, Color? loaderColor, List<File>? postFiles,String? fileStringKey}) async {
    BuildContext contextApi = context ?? NavigationService.navigatorKey.currentContext!;
    isHideProgress = false;
    if (showLoader) {
      showProgressThreeDots(contextApi, loaderColor: loaderColor ?? const Color(0xff4c4DDC));
    }
    try {
      if (showLogs) {
        log("---Request url: \n$url \nheader: $header \nbody: $requestBody");
      }
      var response = await apiCallMethod(url, methods, header: header ?? {}, requestBody: requestBody ?? {},postFiles: postFiles,fileStringKey:fileStringKey);
      var multiPartResponse = '';
      if (showLogs) {
        if(methods == RequestMethods.POSTFILE && response is http.StreamedResponse){
          /// listen for response
          multiPartResponse = await response.stream.bytesToString();
          log("---Multi part Response :  $multiPartResponse StatusCode: ${response.statusCode ?? 0}");
        }else {
          log("---Response :  ${response?.body ?? {}} StatusCode: ${response?.statusCode ?? 0}");
        }
      }
      if (showLoader) {
        hideProgress(contextApi);
      }
      if (response != null && response is http.Response) {
        if (response.statusCode == 200 && response.body.isNotEmpty) {
          return jsonDecode(response.body);
        } else {
          if (response.statusCode == 404 || response.statusCode == 502) {
            log("---!! AuthenticationFailed !!---");
            var displayError = jsonDecode(response.body);
            if(displayError[ApiValidationKEYs.data][ApiValidationKEYs.invalidEmail] != null){
              showAlertDialog(context!, "Oops", "Please Enter Valid E-mail", "ok");
            }
            else if(displayError[ApiValidationKEYs.data][ApiValidationKEYs.emailNotFound] != null){
              showAlertDialog(context!, "Oops", "Email Address Does Not Exists", "ok");
            } else if(displayError[ApiValidationKEYs.data][ApiValidationKEYs.incorrectPassword] != null){
              showAlertDialog(context!, "Oops", "Please Enter Valid Password", "ok");
            }else if (displayError[ApiValidationKEYs.data][ApiValidationKEYs.existingUserLogin] != null){
              showAlertDialog(context!, "Oops", "Sorry, That Username Already Exists!", "ok");
            }else if (displayError[ApiValidationKEYs.data][ApiValidationKEYs.existingUserEmail] != null){
              showAlertDialog(context!, "Oops", "Sorry, That Email Address Is Already Used!", "ok");
            }else if (displayError[ApiValidationKEYs.data][ApiValidationKEYs.error] != null){
              showAlertDialog(context!, "Oops", "Email Address Does Not Exists", "ok");
            }else if (displayError[ApiValidationKEYs.data][ApiValidationKEYs.emailError] != null){
              showAlertDialog(context!, "Oops", "Email Address Does Not Exists", "ok");
            }else if (displayError[ApiValidationKEYs.data][ApiValidationKEYs.tokenError] != null){
              showAlertDialog(context!, "Oops", "Invalid Token", "ok");
            }
          } else {
            var error = responseCodeHandle(contextApi, response).toString();
            log("--- Error : $error");
            showToast(error, contextApi);
          }
          return null;
        }
      } else if(methods == RequestMethods.POSTFILE){
        return jsonDecode(multiPartResponse);
      }else{
        log("---!! somethingWentWrong !!---");
        showToast("Something went wrong", contextApi,);
        return null;
      }
    } on SocketException catch (_) {
      if (showLoader) {
        hideProgress(contextApi);
      }
      showToast("Mobile data off", contextApi);
    } catch (e) {
      if (showLogs) {
        log("---Error : $e");
      }
      if (showLoader) {
        hideProgress(contextApi);
      }
      return null;
    }
  }

  static dynamic responseCodeHandle(
      BuildContext context, http.Response response) {
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(context, response.body.toString());
      case 401:
      case 404:
      case 403:
        throw UnauthorisedException(context, response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            context, 'An error occurred while communicating with the server: ${response.statusCode}');
    }
  }

  static Future<dynamic> apiCallMethod(String url, RequestMethods methods,
      {Map<String, String>? header, Map<String, dynamic>? requestBody, List<File>? postFiles,String? fileStringKey }) async {
    if (methods == RequestMethods.GET) {
      return await http.get(Uri.parse(url), headers: header!);
    } else if (methods == RequestMethods.POST) {
      return await http.post(Uri.parse(url),
          headers: header!, body: jsonEncode(requestBody!));
    } else if (methods == RequestMethods.PUT) {
      return await http.put(Uri.parse(url),
          headers: header!, body: jsonEncode(requestBody!));
    } else if (methods == RequestMethods.DELETE) {
      return await http.delete(Uri.parse(url),
          headers: header!, body: jsonEncode(requestBody!));
    }
    else if (methods == RequestMethods.POSTFILE && postFiles != null){
      var request = http.MultipartRequest(RequestMethods.POST.name, Uri.parse(url));
      request.headers.addAll(header!);
      request.fields.addAll(requestBody!.map((key, value) => MapEntry(key, value.toString())));
      return await request.send();
    }
    return null;
  }
}
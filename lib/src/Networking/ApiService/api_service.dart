import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:earn_streak/src/Constants/app_keys.dart';
import 'package:earn_streak/src/Networking/NetworkHelper/custom_exception.dart';
import 'package:earn_streak/src/Utils/Mixins/alert_dialog.dart';
import 'package:earn_streak/src/Utils/Mixins/progress_hub.dart';
import 'package:earn_streak/src/Utils/Mixins/toast_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

enum RequestMethods { GET, POST, PUT, DELETE, POSTFILE }

http.Client client = http.Client();

Map<String, String> commonHeader = {
  ApiServicesHeaderKEYs.accept: "application/json",
  ApiServicesHeaderKEYs.contentType: "application/json"
};

commonHeaderWithToken(String authToken) {
  Map<String, String> commonHeaderWithToken = {
    ApiServicesHeaderKEYs.accept: "application/json",
    ApiServicesHeaderKEYs.contentType: "application/json",
    ApiServicesHeaderKEYs.authorization: "Bearer $authToken"
  };
  return commonHeaderWithToken;
}

commonHeaderWithMultiPartFormData(String authToken) {
  Map<String, String> commonHeaderWithToken = {
    ApiServicesHeaderKEYs.contentType: "multipart/form-data",
    ApiServicesHeaderKEYs.authorization: "Bearer $authToken"
  };
  return commonHeaderWithToken;
}

class ApiService {
  static bool isHideProgress = false;

  static hideProgress(BuildContext context) {
    if (!isHideProgress) {
      Navigator.pop(context);
      isHideProgress = true;
    }
  }

  static Future<dynamic> request(context, String url, RequestMethods methods,
      {Map<String, String>? header,
      Map<String, dynamic>? requestBody,
      bool showLoader = true,
      bool showLogs = true,
      Color? loaderColor,
      List<XFile>? postFiles,
      String? fileStringKey}) async {
    // BuildContext contextApi = context ?? NavigationService.navigatorKey.currentContext!;
    isHideProgress = false;
    if (showLoader) {
      showProgressThreeDots(context, loaderColor: loaderColor ?? const Color(0xff4c4DDC));
    }
    try {
      if (showLogs) {
        log("---Request url: \n$url \nheader: $header \nbody: $requestBody");
      }
      var response = await apiCallMethod(url, methods,
          header: header ?? {}, requestBody: requestBody ?? {}, postFiles: postFiles, fileStringKey: fileStringKey);
      var multiPartResponse = '';
      if (showLogs) {
        if (methods == RequestMethods.POSTFILE && response is http.StreamedResponse) {
          /// listen for response
          multiPartResponse = await response.stream.bytesToString();
          log("---Multi part Response :  $multiPartResponse StatusCode: ${response.statusCode}");
        } else {
          log("---Response :  ${response?.body ?? {}} StatusCode: ${response?.statusCode ?? 0}");
        }
      }
      if (showLoader) {
        hideProgress(context);
      }
      if (response != null && response is http.Response) {
        if (response.statusCode == 200 && response.body.isNotEmpty) {
          return jsonDecode(response.body);
        } else {
          print("check status code ${response.statusCode}");
          if (response.statusCode == 404 || response.statusCode == 502) {
            log("---!! AuthenticationFailed !!---");
            var displayError = jsonDecode(response.body);
            print("display error data is ${displayError.toString()}");
            if(url == "https://ssemw.org/quizzit/wp-json/earn/v1/user/post/read/coin/add" && response.statusCode == 404){
              return null;
            }
           if(displayError[ApiValidationKEYs.message] != null && url == "https://ssemw.org/quizzit/wp-json/earn/v1/user/coin/update"){
            showAlertDialog(context, "Oops",displayError[ApiValidationKEYs.message] , "ok", onTapOk: (){Navigator.pop(context);Navigator.pop(context, true);});
          }
           if(displayError[ApiValidationKEYs.message] != null && url == "https://ssemw.org/quizzit/wp-json/earn/v1/user/payment/details/save"){
             showAlertDialog(context, "Oops", displayError[ApiValidationKEYs.message], "ok");
           }
            if (displayError[ApiValidationKEYs.data][ApiValidationKEYs.invalidEmail] != null) {
              showAlertDialog(context, "Oops", "Please Enter Valid E-mail", "ok");
            } else if (displayError[ApiValidationKEYs.data][ApiValidationKEYs.emailNotFound] != null) {
              showAlertDialog(context, "Oops", "Email Address Does Not Exists", "ok");
            } else if (displayError[ApiValidationKEYs.data][ApiValidationKEYs.incorrectPassword] != null) {
              showAlertDialog(context, "Oops", "Please Enter Valid Password", "ok");
            } else if (displayError[ApiValidationKEYs.data][ApiValidationKEYs.existingUserLogin] != null) {
              showAlertDialog(context, "Oops", "Sorry, That Username Already Exists!", "ok");
            } else if (displayError[ApiValidationKEYs.data][ApiValidationKEYs.existingUserEmail] != null) {
              showAlertDialog(context, "Oops", "Sorry, That Email Address Is Already Used!", "ok");
            } else if (displayError[ApiValidationKEYs.data][ApiValidationKEYs.error] != null) {
              showAlertDialog(context, "Oops", "Email Address Does Not Exists", "ok");
            } else if (displayError[ApiValidationKEYs.data][ApiValidationKEYs.emailError] != null) {
              showAlertDialog(context, "Oops", "Email Address Does Not Exists", "ok");
            } else if (displayError[ApiValidationKEYs.data][ApiValidationKEYs.tokenError] != null) {
              showAlertDialog(context, "Oops", "Invalid Token", "ok");
            }
            else {
              print("show dialog check please");
              showAlertDialog(context, "Oops", displayError[ApiValidationKEYs.message], "ok");
            }
          } else {
            var error = responseCodeHandle(context, response).toString();

            log("--- Error : $error");
            showToast(error, context);
          }
          return null;
        }
      } else if (methods == RequestMethods.POSTFILE) {
        return jsonDecode(multiPartResponse);
      } else {
        log("---!! somethingWentWrong !!---");
        showToast(
          "Something went wrong",
          context,
        );
        return null;
      }
    } on SocketException catch (_) {
      if (showLoader) {
        hideProgress(context);
      }
      showToast("Mobile data off", context);
    } catch (e) {
      if (showLogs) {
        log("---Error : $e");
      }
      if (showLoader) {
        hideProgress(context);
      }
      return null;
    }
  }

  static dynamic responseCodeHandle(BuildContext context, http.Response response) {
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(context, response.body.toString());
      case 401:
      case 404:
      case 403:
        throw UnauthorisedException(context, response.body.toString());
      case 500:
      default:
        throw FetchDataException(context, 'An error occurred while communicating with the server: ${response.statusCode}');
    }
  }

  static Future<dynamic> apiCallMethod(String url, RequestMethods methods,
      {Map<String, String>? header, Map<String, dynamic>? requestBody, List<XFile>? postFiles, String? fileStringKey}) async {
    if (methods == RequestMethods.GET) {
      return await client.get(Uri.parse(url), headers: header!);
      // return await http.get(Uri.parse(url), headers: header!);
    } else if (methods == RequestMethods.POST) {
      // return await http.Client().post(Uri.parse(url), headers: header!, body: jsonEncode(requestBody!));
      return await client.post(Uri.parse(url), headers: header!, body: jsonEncode(requestBody!));
    } else if (methods == RequestMethods.PUT) {
      return await http.put(Uri.parse(url), headers: header!, body: jsonEncode(requestBody!));
    } else if (methods == RequestMethods.DELETE) {
      return await http.delete(Uri.parse(url), headers: header!, body: jsonEncode(requestBody!));
    } else if (methods == RequestMethods.POSTFILE && postFiles != null) {
      var request = http.MultipartRequest(RequestMethods.POST.name, Uri.parse(url));
      request.headers.addAll(header!);
      request.fields.addAll(requestBody!.map((key, value) => MapEntry(key, value.toString())));
      for(XFile postFile in postFiles) {
        var multipartFile = await http.MultipartFile.fromPath(fileStringKey ?? 'profile', postFile.path, filename: basename(postFile.path),contentType: MediaType('image', 'jpeg'));
        request.files.add(multipartFile);
      }
      return await request.send();
    }
    return null;
  }
}

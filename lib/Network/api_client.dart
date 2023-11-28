import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:http/http.dart' as Http;
import '../Constants/Strings/app_strings.dart';

class ApiClient  {
  final String? appBaseUrl;
  static final String noInternetMessage = 'connection_to_api_server_failed';
  final int timeoutInSeconds = 80;

  String? token;
  Map<String, String>? _mainHeaders={
    'Content-Type': 'application/json',
    'Accept': 'application/json',

  };


  ApiClient({this.appBaseUrl}) {
    if(Foundation.kDebugMode) {}
  }




   Future getData({String? uri, Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
      }

      Http.Response _response = await Http.get(
        Uri.parse(appBaseUrl!+uri!),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
        // Logger().i(_response.headers);
        // Logger().i(jsonDecode(_response.body));
      return jsonDecode(utf8.decode((_response.bodyBytes)));
    } catch (e) {
      Logger().e('------------${e.toString()}');
      return null;
    }
  }

  Future postData({String? uri, dynamic body, Map<String, String>? headers}) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');

        Logger().d('====> API Url: '+BASE_URL+uri!);
        Logger().d('====> API Body: $body');


      }
      // Get.snackbar("", "",
      //     backgroundColor: Color(0XFF0EA01D),
      //     borderRadius: 4,
      //     titleText: Text("Report",style: mediumText(14,color: Colors.white),),
      //     messageText: Text('====> API Call: $uri\nHeader: $_mainHeaders',style: mediumText(14,color: Colors.white),),
      //     colorText: Colors.white,
      //     padding: EdgeInsets.symmetric(horizontal: 24,vertical: 10),
      //     duration: Duration(seconds: 2)
      // );
      Http.Response _response = await Http.post(
        Uri.parse(appBaseUrl!+uri!),
        body: jsonEncode(body),
        headers: _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Logger().i(jsonDecode(_response.body));

      return jsonDecode(_response.body);
    } catch (e) {
      return print(e.toString());
    }
  }

  Future postMultipartData({String? uri, Map<String, String>? body, List<MultipartBody>? multipartBody, Map<String, String>? headers}) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body with ${multipartBody!.length} picture');
      }
      Http.MultipartRequest _request = Http.MultipartRequest('POST', Uri.parse(appBaseUrl!+uri!));
      _request.headers.addAll(headers ?? _mainHeaders!);
      for(MultipartBody multipart in multipartBody!) {
        if(multipart.file != null) {
          Uint8List _list = await multipart.file.readAsBytes();
          _request.files.add(Http.MultipartFile(
            multipart.key, multipart.file.readAsBytes().asStream(), _list.length,
            filename: '${DateTime.now().toString()}.png',
          ));
        }
      }
      _request.fields.addAll(body!);
      Http.Response _response = await Http.Response.fromStream(await _request.send());
      Logger().i(jsonDecode(_response.body));
      return jsonDecode(_response.body);
    } catch (e) {
      Logger().i(jsonDecode(e.toString()));
      return null;
    }
  }

  Future putData({String? uri, dynamic body, Map<String, String>? headers}) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body');
      }
      Http.Response _response = await Http.put(
        Uri.parse(appBaseUrl!+uri!),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Logger().i(jsonDecode(_response.body));
      return jsonDecode(_response.body);
    } catch (e) {
      return null;
    }
  }


  Future deleteData({String? uri, Map<String, String>? headers}) async {
    try {
      if(Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      Http.Response _response = await Http.delete(
        Uri.parse(appBaseUrl!+uri!),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Logger().i(jsonDecode(_response.body));
      return jsonDecode(_response.body);
    } catch (e) {
      return null;
    }
  }

  Response handleResponse(Http.Response response, String uri) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    }catch(e) {}

    if(Foundation.kDebugMode) {
      Logger().i('====> API Header: [] $uri\n${_body}');
    }
    return _body;
  }
}

class MultipartBody {
  String key;
  File file;

  MultipartBody(this.key, this.file);
}
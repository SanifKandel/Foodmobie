import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:foodreminder/app/constants.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpServices {
  static final HttpServices _instance = HttpServices._internal();
  factory HttpServices() => _instance;
  HttpServices._internal();

  Dio? _dio;

  final int _timeout = 60 * 1000; //1 min

  Future<Map<String, String>> getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      return {
        'content-type': 'application/json',
        'accept': 'application/json',
        'language': 'en',
      };
    }
    Map<String, dynamic> payload = json.decode(
        utf8.decode(base64.decode(base64.normalize(token.split('.')[1]))));
    DateTime expirationDate =
        DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
    if (DateTime.now().isAfter(expirationDate)) {
      // Token is expired
      prefs.remove('token');
      Constant.token = '';
      return {
        'content-type': 'application/json',
        'accept': 'application/json',
        'language': 'en',
      };
    }
    Constant.token = token;
    return {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': token,
      'language': 'en',
    };
  }

  Dio getDioInstance() {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: Constant.baseURL,
        connectTimeout: _timeout,
        receiveTimeout: _timeout,
      ),
    );
    // _dio!.interceptors.add(PrettyDioLogger(
    //     requestHeader: true, requestBody: true, responseHeader: true));
    _dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers = await getHeaders();
          return handler.next(options);
        },
      ),
    );
    return _dio!;
  }
}

import 'dart:typed_data';

import 'package:admin_dashboard/services/local_storage.dart';
import 'package:dio/dio.dart';

class CafeApi {
  static Dio _dio = new Dio();
//Change of git user
  static void configureDio() {
    //Base del url
    //https://flutter-web-admin-wilmar.herokuapp.com
    // _dio.options.baseUrl = 'http://localhost:8080/api';
    _dio.options.baseUrl = 'https://flutter-web-admin-wilmar.herokuapp.com/api';
    //Headers
    _dio.options.headers = {
      'x-token': LocalStorage.prefs.getString('token') ?? ''
    };
  }

  static Future httpGet(String path) async {
    try {
      final response = await _dio.get(path);
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      throw ('Error en el Get');
    }
  }

  static Future httpPost(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      final response = await _dio.post(path, data: formData);
      return response.data;
    } catch (e) {
      print(e);
      throw ('Error en el Post');
    }
  }

  static Future httpPut(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      final response = await _dio.put(path, data: formData);
      return response.data;
    } on DioError catch (e) {
      print(e);
      throw ('Error en el Put');
    }
  }

  static Future httpDelete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response.data;
    } catch (e) {
      throw ('Error en el Delete');
    }
  }

  static Future httpUploadFile(String path, Uint8List bytes) async {
    final formData = FormData.fromMap(
      {
        'archivo': MultipartFile.fromBytes(bytes),
      },
    );
    try {
      final response = await _dio.put(path, data: formData);
      return response.data;
    } on DioError catch (e) {
      print(e);
      throw ('Error en el Put');
    }
  }
}

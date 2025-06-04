import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/configs/function/function/function.dart';

class ApiService {
  static final http.Client _httpClient = http.Client();
  final String baseUrl;
  final String? accessToken;

  ApiService({required this.baseUrl, this.accessToken});

  Future<T> callApi<T>({
    required String endpoint,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    String method = 'GET',
    dynamic body,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final uri = Uri.parse(baseUrl).replace(
        path: Uri.parse(baseUrl).path + endpoint,
        queryParameters: queryParams,
      );

      final requestHeaders = {
        "Content-Type": 'application/json; charset=UTF-8',
        'Accept': '*/*',
        if (accessToken != null) 'Authorization': 'Bearer $accessToken',
        if (headers != null) ...headers,
      };

      final encodedBody = body != null ? jsonEncode(body) : null;

      late http.Response response;

      switch (method.toUpperCase()) {
        case 'POST':
          response = await _httpClient.post(
            uri,
            headers: requestHeaders,
            body: encodedBody,
          );
          // .timeout(const Duration(seconds: 10));
          break;
        case 'PUT':
          response = await _httpClient.put(
            uri,
            headers: requestHeaders,
            body: encodedBody,
          );
          // .timeout(const Duration(seconds: 10));
          break;
        case 'DELETE':
          response = await _httpClient.delete(uri, headers: requestHeaders);
          // .timeout(const Duration(seconds: 10));
          break;
        default:
          response = await _httpClient.get(uri, headers: requestHeaders);
        // .timeout(const Duration(seconds: 10));
      }

      return _processResponse(response, fromJson);
    } catch (e) {
      debugPrint('Unexpected Error: $e');
      rethrow;
    }
  }

  Future<T> _processResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final statusCode = response.statusCode;

    if (statusCode == 200 || statusCode == 201) {
      if (response.bodyBytes.length > 10000) {
        return await compute(
          jsonDecode,
          response.body,
        ).then((data) => fromJson(data));
      } else {
        return fromJson(jsonDecode(response.body));
      }
    }

    final errorMessage = _extractErrorMessage(response);
    final datas = _extractErrorData(response);

    switch (statusCode) {
      case 400:
        notificationAlert('Status: 400 $errorMessage');
        throw ApiException(message: errorMessage, statusCode: 400, data: datas);
      case 401:
        notificationAlert('Status: 401 $errorMessage');
        throw ApiException(message: errorMessage, statusCode: 401, data: datas);
      case 403:
        notificationAlert('Status: 403 $errorMessage ');
        throw ApiException(message: errorMessage, statusCode: 403, data: datas);
      case 404:
        notificationAlert('Status: 404 $errorMessage');
        throw ApiException(message: errorMessage, statusCode: 404, data: datas);
      case 422:
        notificationAlert('Status: 422 $errorMessage');
        throw ApiException(message: errorMessage, statusCode: 422, data: datas);
      case 429:
        notificationAlert('Status: 429 $errorMessage');
        throw ApiException(message: errorMessage, statusCode: 422, data: datas);
      case 500:
        notificationAlert('Status: 500 $errorMessage');
        throw ApiException(message: errorMessage, statusCode: 500, data: datas);
      default:
        notificationAlert('Error $statusCode: $errorMessage');
        throw ApiException(
          message: errorMessage,
          statusCode: statusCode,
          data: datas,
        );
    }
  }

  String _extractErrorMessage(http.Response response) {
    try {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data.containsKey('message')) {
        return data['message'];
      } else if (data['errors'] != null &&
          data['errors'] is Map &&
          data['errors']?['message'] != null) {
        return data['errors']?['message'];
      }
      return 'An unknown error occurred.';
    } catch (e) {
      return 'Unable to parse error response.';
    }
  }

  _extractErrorData(http.Response response) {
    try {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data.containsKey('data')) {
        return data['data'];
      }
      return 'An unknown error occurred.';
    } catch (e) {
      return 'Unable to parse error response.';
    }
  }

  void closeClient() {
    _httpClient.close();
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({required this.message, this.statusCode, this.data});

  @override
  String toString() {
    return 'ApiException: $message (Status: ${statusCode ?? 'Unknown'})';
  }
}

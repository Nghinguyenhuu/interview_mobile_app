import 'package:dio/dio.dart';

import '../core.dart';

abstract class INetworkUtility {
  Future<Response> request(
    String url,
    Method method, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    Options options,
  });
}

class NetworkUtility implements INetworkUtility {
  late Dio _dio;

  final String baseUrl;
  final List<Interceptor>? interceptors;
  final ResponseType responseType;
  final INetworkInfo networkInfo;

  NetworkUtility(
    this.baseUrl, {
    this.interceptors,
    this.responseType = ResponseType.plain,
    required this.networkInfo,
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
    int sendTimeout = 30000,
  }) {
    BaseOptions _options = BaseOptions(
      connectTimeout: Duration(milliseconds: connectTimeout),
      receiveTimeout: Duration(milliseconds: receiveTimeout),
      sendTimeout: Duration(milliseconds: sendTimeout),
      responseType: responseType,
      headers: {
        'Content-Type': 'text/html',
        'Access-Token': "edf1537917752ef4edd7c7415ae6a164357ee2e5",
      },
      validateStatus: (_) {
        return true;
      },
      baseUrl: baseUrl,
    );
    _dio = Dio(_options);

    if (interceptors != null) {
      _dio.interceptors.addAll(interceptors!);
    }
  }

  Future<Response> _createRequest(
    String method,
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    options ??= Options(headers: {});
    options.method = method;

    var response;
    try {
      response = await _dio.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      print("NetworkUtility: ${e.toString()}");
    }
    return response;
  }

  @override
  Future<Response> request(
    String url,
    Method method, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      throw NetworkException("---- No internet connection");
    }
    return await _createRequest(
      method.value,
      url,
      data: data,
      options: options,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
  }
}

enum ErrorCode {
  TIME_OUT,
  UNKNOWN,
}

enum Method {
  POST,
  PUT,
  DELETE,
  GET,
}

extension MethodExtensions on Method {
  String get value => ['POST', 'PUT', 'DELETE', 'GET'][index];
}

extension ErrorCodeExtensions on ErrorCode {
  String get value => ['time_out', 'unknown'][index];
}

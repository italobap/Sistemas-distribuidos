import 'package:comida_ja/app/data/extensions/string_formater.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'api_error.dart';

abstract class IHttpApp {
  Future<Either<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  });

  Future<Either<String, dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  });

  Future<Either<String, dynamic>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  });

  Future<Either<String, dynamic>> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });
}

class HttpApp implements IHttpApp {
  final Dio _dio;

  HttpApp() : _dio = Dio() {
    _dio.options.headers['content-type'] = 'application/json';
    _dio.options.headers['accept'] = 'application/json';
    //_dio.options.headers['Access-Control-Allow-Origin'] = '*';
  }

  @override
  Future<Either<String, dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      Response response = await _dio.post(path,
          cancelToken: cancelToken,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          options: options,
          queryParameters: queryParameters);
      if (response.data is String) {
        response = Response(
            statusCode: 401,
            requestOptions: RequestOptions(
              path: response.requestOptions.path,
              headers: response.requestOptions.headers,
              data: response.requestOptions.data,
            ));
      }
      return Right(response.data);
    } on DioException catch (e) {
      return Left(handlerDioError(e));
    } catch (e, s) {
      return Left(handlerGenericError(e, s));
    }
  }

  @override
  Future<Either<String, dynamic>> put(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress}) async {
    try {
      Response response = await _dio.put(path,
          cancelToken: cancelToken,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress,
          options: options,
          queryParameters: queryParameters);
      if (response.data is String) {
        response = Response(
            statusCode: 401,
            requestOptions: RequestOptions(
              path: response.requestOptions.path,
              headers: response.requestOptions.headers,
              data: response.requestOptions.data,
            ));
      }
      return Right(response.data);
    } on DioException catch (e) {
      return Left(handlerDioError(e));
    } catch (e, s) {
      return Left(handlerGenericError(e, s));
    }
  }

  @override
  Future<Either<String, dynamic>> get(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      void Function(int p1, int p2)? onReceiveProgress}) async {
    try {
      Response response = await _dio.get(path,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          options: options,
          queryParameters: queryParameters);
      if (response.data is String) {
        response = Response(
            statusCode: 401,
            requestOptions: RequestOptions(
              path: response.requestOptions.path,
              headers: response.requestOptions.headers,
              data: response.requestOptions.data,
            ));
      }
      return Right(response.data);
    } on DioException catch (e) {
      return Left(handlerDioError(e));
    } catch (e, s) {
      return Left(handlerGenericError(e, s));
    }
  }

  @override
  Future<Either<String, dynamic>> delete(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      Response response = await _dio.delete(path,
          cancelToken: cancelToken,
          data: data,
          options: options,
          queryParameters: queryParameters);
      if (response.data is String) {
        response = Response(
            statusCode: 401,
            requestOptions: RequestOptions(
              path: response.requestOptions.path,
              headers: response.requestOptions.headers,
              data: response.requestOptions.data,
            ));
      }
      return Right(response.data);
    } on DioException catch (e) {
      return Left(handlerDioError(e));
    } catch (e, s) {
      return Left(handlerGenericError(e, s));
    }
  }

  String handlerDioError(DioException error) {
    ApiError apiError = ApiError();
    String mensagem = "";
    if (error.response?.data != null) {
      var errorData = error.response?.data;
      if (errorData is List && errorData.isNotEmpty) {
        apiError = ApiError.fromMap(errorData.first);
        mensagem = "${error.response?.statusCode ?? ""}\n"
            "${apiError.mensagem ?? ""} ${apiError.codigo}";
      } else if (errorData is Map<String, dynamic>) {
        apiError = ApiError.fromMap(errorData);
        mensagem = "${error.response?.statusCode ?? ""}\n"
            "${apiError.mensagem ?? ""} ${apiError.codigo}";
      } else if (errorData is String) {
        mensagem = "${error.response?.statusCode ?? ""}\n"
            "${errorData.clipString(end: 30)}";
      }
    }
    if (error.type == DioExceptionType.badResponse) {
      mensagem = "${error.type.name} \n${error.response?.data}";
    }
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      mensagem = "${error.type.name}\n ${error.message}";
    }

    return mensagem;
  }

  String handlerGenericError(Object error, StackTrace stackTrace) {
    String mensagem = "Ocorreu um erro\n"
        "$error\n"
        "$stackTrace";
    return mensagem;
  }
}

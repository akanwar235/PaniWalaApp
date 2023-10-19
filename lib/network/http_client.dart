import 'dart:io';

import 'package:dio/dio.dart';
import 'package:water_order/network/i_http_client.dart';
import 'package:water_order/network/network_info.dart';
import 'package:water_order/services/constants/endpoint_urls.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'i_network_info.dart';

/// provider
final httpClientProvider = Provider((ref) {
  final dio = Dio();
  final networkInfo = ref.read(networkInfoProvider);
  return WAHttpClient(dio, networkInfo);
});

const String _baseUrl = EndPointUrls.baseUrl;
const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

/// will bypass accessToken check on these urls
const noneAuthedRoute = [
  EndPointUrls.sendOtp,
  EndPointUrls.verifyOtp,
  EndPointUrls.createAccount
];

class WAHttpClient implements IHttpClient {
  final Dio dio;
  final INetworkInfo networkInfo;

  WAHttpClient(
    this.dio,
    this.networkInfo,
  ) {
    dio
      ..options.baseUrl = _baseUrl
      ..options.connectTimeout =
          const Duration(milliseconds: _defaultConnectTimeout)
      ..options.receiveTimeout =
          const Duration(milliseconds: _defaultReceiveTimeout)
      ..httpClientAdapter;

    /// refresh token interceptor
    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          /// check if the token is appended from the datasource function
          final hasAccessToken = options.headers.containsKey('Authorization') &&
              options.headers['Authorization'] != null;

          final mustHaveAuth = !noneAuthedRoute.any((x) => options.path == x);
          if (mustHaveAuth && !hasAccessToken) {
            // var cachedUserEither = await _authenticationLocalDataSource.getCachedAuth();
            // if (cachedUserEither.isLeft()) throw cachedUserEither.asLeft();

            // var cachedToken = cachedUserEither.asRight();
            // if (JwtDecoder.isExpired(cachedToken.accessToken)) {
            //   var error = const Failure.tokenFailure(TokenFailure.expired());

            //   final authenticationRemoteDataSource = AuthenticationRemoteDataSourceImpl(
            //     this,
            //     _googleSignIn,
            //   );
            //   final cryptographyRemoteDataSource = CryptographyRemoteDataSourceImpl(this);

            //   /// accessToken has expired, refresh from here
            //   final keys = await _cryptographyLocalDataSource.getCachedUserKeyPair();
            //   if (keys.isLeft()) error = keys.asLeft();

            //   if (keys.isRight()) {
            //     final deviceId = keys.asRight().deviceId;
            //     final refreshDto = TokenRefreshParamsDto(
            //       refreshToken: cachedUserEither.asRight().refreshToken,
            //     );

            //     final results = await Future.wait([
            //       cryptographyRemoteDataSource.refreshDeviceExpire(deviceId),
            //       authenticationRemoteDataSource.refreshAccessToken(refreshDto),
            //     ]);

            //     if (results.any((r) => r.isLeft())) error = results.first.asLeft();

            //     /// save refreshed tokens
            //     final refreshedTokens = results.last.asRight() as SignInResponse;
            //     refreshedTokens.maybeMap((values) {
            //       final tokens = AuthTokens(
            //           accessToken: values.accessToken, refreshToken: values.refreshToken);
            //       _authenticationLocalDataSource.cacheAuth(tokens);
            //     }, orElse: () {});
            //   }
            //   return handler.reject(
            //     DioError(requestOptions: options, type: DioErrorType.other, error: error),
            //     true,
            //   );
            // }

            // options.headers = {"Authorization": "Bearer ${cachedToken.accessToken}"};
          }
          return handler.next(options);
        },
      ),
    );
  }

  @override
  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (!(await networkInfo.isConnected)) {
      throw const SocketException("No working internet connections found");
    }

    try {
      var newOptions = options ?? Options(contentType: Headers.jsonContentType);

      Response response = await dio.get(
        uri,
        queryParameters: queryParameters,
        options: newOptions,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (!(await networkInfo.isConnected)) {
      throw const SocketException("No working internet connections found");
    }

    try {
      var newOptions = options ?? Options(contentType: Headers.jsonContentType);

      Response response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: newOptions,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> delete(
    String uri, {
    Map<String, dynamic>? queryParameters,
    data,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    if (!(await networkInfo.isConnected)) {
      throw const SocketException("No working internet connections found");
    }

    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> patch(
    String uri, {
    Map<String, dynamic>? queryParameters,
    data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) async {
    if (!(await networkInfo.isConnected)) {
      throw const SocketException("No working internet connections found");
    }

    try {
      var response = await dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> put(
    String uri, {
    Map<String, dynamic>? queryParameters,
    data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    ProgressCallback? onSendProgress,
  }) async {
    if (!(await networkInfo.isConnected)) {
      throw const SocketException("No working internet connections found");
    }

    try {
      var response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException();
    } catch (e) {
      rethrow;
    }
  }
}

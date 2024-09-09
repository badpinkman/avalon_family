import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

import '../index.dart';

/// Response统一处理回调
typedef OnResponseHandler = Future<String?> Function(
    Response<dynamic> response);

class HttpService extends GetxService {
  static const showLog = 'showLog';
  static const showError = 'showError';

  static HttpService get to => Get.find();

  late final Dio _dio;
  Dio get dio => _dio;

  // 取消请求token
  final CancelToken _cancelToken = CancelToken();

  /// 初始化
  /// [timeout] 请求超时时间
  Future<HttpService> init({int timeout = 10}) async {
    BaseOptions options = BaseOptions(
      connectTimeout: Duration(seconds: timeout),
      receiveTimeout: Duration(seconds: timeout),
      sendTimeout: Duration(seconds: timeout),
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );
    // 初始化dio
    _dio = Dio(options);
    // Log拦截器
    dio.interceptors.add(
      PrettyDioLogger(
        showRequest: false,
        showResponse: true,
        responseHeader: true,
        responseBody: true,
        showError: true,
        logPrint: Logger.network,
      ),
    );
    // 自定义添加拦截器
    _dio.interceptors.add(DioInterceptors());
    return this;
  }

  /// 设置BaseUrl
  void setBaseUrl(String baseUrl) {
    _dio.options = _dio.options.copyWith(baseUrl: baseUrl);
  }

  /// 取消网络请求
  void cancel([CancelToken? token]) {
    if (token != null) {
      token.cancel('cancel');
    } else {
      _cancelToken.cancel('cancel');
    }
  }

  /// 基础请求
  Future<Response?> request(
    String path, {
    Map<String, dynamic>? params,
    data,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    options ??= Options(method: 'get');
    try {
      Response response = await _dio.request(path,
          data: data,
          queryParameters: params,
          cancelToken: cancelToken ?? _cancelToken,
          options: options,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response;
    } on DioException catch (e) {
      bool isShowError = true;
      if (e.requestOptions.headers.containsKey(showError)) {
        isShowError = e.requestOptions.headers[showError];
      }
      if (isShowError) {
        Loading.error(e.message);
      }
      return null;
    }
  }

  /// GET请求
  Future<Response?> get(
    String path, {
    Map<String, dynamic>? params,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
  }) async {
    Options options = Options(method: 'get', headers: headers);
    return await request(
      path,
      options: options,
      params: params,
      cancelToken: cancelToken,
    );
  }

  /// POST请求
  Future<Response?> post(
    String path, {
    Map<String, dynamic>? params,
    data,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
  }) async {
    Options options = Options(method: 'post', headers: headers);
    return await request(
      path,
      options: options,
      params: params,
      data: data,
      cancelToken: cancelToken,
    );
  }

  String? _authorization;

  String? get authorization => _authorization;

  /// 设置授权(Token) 默认在开头添加Bearer
  /// [authorization] 授权Token
  void setAuthorization(String authorization, {bool addBearer = true}) {
    if (addBearer) {
      _authorization = 'Bearer $authorization';
    } else {
      _authorization = authorization;
    }
  }

  /// 清除授权
  void clearAuthorization() {
    _authorization = null;
  }

  OnResponseHandler? _onResponseHandler;

  OnResponseHandler? get onResponseHandler => _onResponseHandler;

  /// 设置响应拦截器
  void setOnResponseHandler(OnResponseHandler? handler) {
    _onResponseHandler = handler;
  }
}

/// 拦截器
class DioInterceptors extends Interceptor {
  @override
  void onRequest(options, handler) {
    String? authorization = HttpService.to.authorization;
    if (authorization.isNotEmptyOrNull) {
      if (!options.headers.containsKey('Authorization')) {
        options.headers.addAll({'Authorization': authorization});
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(response, handler) async {
    if (response.statusCode != 200 && response.statusCode != 201) {
      OnResponseHandler? onResponseHandler = HttpService.to.onResponseHandler;
      if (onResponseHandler != null) {
        String? msg = await onResponseHandler(response);
        if (msg != null) {
          handler.reject(
            DioException(
              type: DioExceptionType.badResponse,
              message: msg.isEmpty ? '服务器异常' : msg,
              requestOptions: response.requestOptions,
              response: response,
              error: null,
            ),
          );
          return;
        }
      }
    } else {
      handler.next(response);
    }
  }

  /// 退出并重新登录
  // Future<void> _errorNoAuthLogout() async {
  //   await UserService.to.logout();
  //   Get.toNamed(RouteNames.systemLogin);
  // }

  // @override
  // Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
  //   final exception = HttpException(err.message);
  //   switch (err.type) {
  //     case DioErrorType.response: // 服务端自定义错误体处理
  //       {
  //         // final response = err.response;
  //         // final errorMessage = ErrorMessageModel.fromJson(response?.data);
  //         // switch (errorMessage.statusCode) {
  //         //   case 401:
  //         //     _errorNoAuthLogout();
  //         //     break;
  //         //   case 404:
  //         //     break;
  //         //   case 500:
  //         //     break;
  //         //   case 502:
  //         //     break;
  //         //   default:
  //         //     break;
  //         // }
  //         // Loading.error(errorMessage.message);
  //       }
  //       break;
  //     case DioErrorType.other:
  //       break;
  //     case DioErrorType.cancel:
  //       break;
  //     case DioErrorType.connectTimeout:
  //       break;
  //     default:
  //       break;
  //   }
  //   err.error = exception;
  //   handler.next(err);
  // }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    String? errorMessage;
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = '服务器连接超时';
        break;
      case DioExceptionType.connectionError:
        errorMessage = '服务器连接失败';
        break;
      case DioExceptionType.badCertificate:
        errorMessage = '无效的证书';
        break;
      case DioExceptionType.cancel:
        errorMessage = '请求取消';
        break;
      case DioExceptionType.unknown:
        if (await isNetworkAvailable()) {
          errorMessage = '服务器连接失败';
        } else {
          errorMessage = '设备未连接网络';
        }
        break;
      case DioExceptionType.badResponse:
        int? statusCode = err.response?.statusCode;
        if (statusCode != null) {
          errorMessage = '服务器异常:$statusCode';
        }
        break;
    }
    handler.reject(
      DioException(
        type: err.type,
        message: errorMessage,
        requestOptions: err.requestOptions,
        response: err.response,
        error: null,
      ),
    );
  }
}

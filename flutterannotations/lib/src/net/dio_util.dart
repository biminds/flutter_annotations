import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'log_of_format_interceptor.dart';

/// <BaseResp<T> 返回 status code msg data.
class BaseResp<T> {
  String status;
  int errorCode;
  String errorMsg;
  T data;

  BaseResp(this.status, this.errorCode, this.errorMsg, this.data);

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"status\":\"$status\"");
    sb.write(",\"code\":$errorCode");
    sb.write(",\"msg\":\"$errorMsg\"");
    sb.write(",\"data\":\"$data\"");
    sb.write('}');
    return sb.toString();
  }
}

/// <BaseRespR<T> 返回 status code msg data Response.
class BaseRespR<T> {
  String status;
  int code;
  String msg;
  T data;
  Response response;

  BaseRespR(this.status, this.code, this.msg, this.data, this.response);

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"status\":\"$status\"");
    sb.write(",\"code\":$code");
    sb.write(",\"msg\":\"$msg\"");
    sb.write(",\"data\":\"$data\"");
    sb.write('}');
    return sb.toString();
  }
}

/// 请求方法.
class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

///Http配置.
class HttpConfig {
  /// constructor.
  HttpConfig({
    this.status,
    this.code,
    this.msg,
    this.data,
    this.options,
    this.pem,
    this.pKCSPath,
    this.pKCSPwd,
  });

  /// BaseResp [String status]字段 key, 默认：status.
  String status;

  /// BaseResp [int code]字段 key, 默认：errorCode.
  String code;

  /// BaseResp [String msg]字段 key, 默认：errorMsg.
  String msg;

  /// BaseResp [T data]字段 key, 默认：data.
  String data;

  /// Options.
  RequestOptions options;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PEM证书内容.
  String pem;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PKCS12 证书路径.
  String pKCSPath;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PKCS12 证书密码.
  String pKCSPwd;
}

/// 单例 DioUtil.
/// debug模式下可以打印请求日志. DioUtil.openDebug().
/// dio详细使用请查看dio官网(https://github.com/flutterchina/dio).
class DioUtil {
  Dio _dio;

  /// BaseResp [String status]字段 key, 默认：status.
  String _statusKey = "errorCode";

  /// BaseResp [int code]字段 key, 默认：errorCode.
  String _codeKey = "code";

  /// BaseResp [String msg]字段 key, 默认：errorMsg.
  String _msgKey = "errorMsg";

  /// BaseResp [T data]字段 key, 默认：data.
  String _dataKey = "data";

  /// Options.
  BaseOptions _options;

  /// PEM证书内容.
  String _pem;

  /// PKCS12 证书路径.
  String _pKCSPath;

  /// PKCS12 证书密码.
  String _pKCSPwd;

  /// 是否是debug模式.
  static bool _isDebug = false;

  DioUtil() {
    _options = getDefOptions();
    _dio = new Dio(_options);
    setInterceptor();
  }

  /// 打开debug模式.
  static void openDebug() {
    _isDebug = true;
  }

  /// set Config.
  void setConfig(HttpConfig config) {
    _statusKey = config.status ?? _statusKey;
    _codeKey = config.code ?? _codeKey;
    _msgKey = config.msg ?? _msgKey;
    _dataKey = config.data ?? _dataKey;
    _mergeOption(config.options);
    _pem = config.pem ?? _pem;

    DefaultHttpClientAdapter httpClientAdapter = _dio.httpClientAdapter;

    if (_dio != null) {
      _dio.options = _options;
      if (_pem != null) {
        httpClientAdapter.onHttpClientCreate = (HttpClient client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) {
            if (cert.pem == _pem) {
              // 证书一致，则放行
              return true;
            }
            return false;
          };
        };
      }
      if (_pKCSPath != null) {
        httpClientAdapter.onHttpClientCreate = (HttpClient client) {
          SecurityContext sc = new SecurityContext();
          //file为证书路径
          sc.setTrustedCertificates(_pKCSPath, password: _pKCSPwd);
          HttpClient httpClient = new HttpClient(context: sc);
          return httpClient;
        };
      }
    }
  }

  ///
  /// Get
  Future<BaseResp<T>> get<T>(String path,
      {data,
      Options options,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken}) {
    return request(Method.get, path,
        data: data,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken);
  }

  ///
  /// Post
  Future<BaseResp<T>> post<T>(String path,
      {data,
      Options options,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken}) {
    return request(Method.post, path,
        data: data,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken);
  }

  ///
  /// Delete
  Future<BaseResp<T>> delete<T>(String path,
      {data,
      Options options,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken}) {
    return request(Method.delete, path,
        data: data,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken);
  }

  ///
  /// Put
  Future<BaseResp<T>> put<T>(String path,
      {data,
      Options options,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken}) {
    return request(Method.put, path,
        data: data,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken);
  }

  /// Make http request with options.
  /// [method] The request method.
  /// [path] The url path.
  /// [data] The request data
  /// [options] The request options.
  /// <BaseResp<T> 返回 status code msg data .
  Future<BaseResp<T>> request<T>(String method, String path,
      {data,
      Options options,
      CancelToken cancelToken,
      Map<String, dynamic> queryParameters}) async {
    //处理  url传参问题
    while (path.contains("{") && path.contains("}")) {
      int start = path.indexOf("{");
      int end = path.indexOf("}");
      String pathPara = path.substring(start + 1, end);
      if (queryParameters.containsKey(pathPara)) {
        var pathParaV = queryParameters.remove(pathPara);
        path = path.replaceRange(start, end + 1, pathParaV.toString());
      } else {
        return new BaseResp("-1", -1, "$pathPara parameters error", null);
      }
    }
//    _printHttpRequestLog(path, data, options, queryParameters);
    Response response = await _dio.request(path,
        data: data,
        options: _checkOptions(method, options),
        queryParameters: queryParameters,
        cancelToken: cancelToken);
    String _status;
    int _code;
    String _msg;
    T _data;
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        if (response.data is Map) {
          _status = (response.data[_statusKey] is int)
              ? response.data[_statusKey].toString()
              : response.data[_statusKey];
          _code = (response.data[_codeKey] is String)
              ? int.tryParse(response.data[_codeKey])
              : response.data[_codeKey];
          if (_code == null) {
            _code = (response.data[_statusKey] is String)
                ? int.tryParse(response.data[_statusKey])
                : response.data[_statusKey];
          }
          _msg = response.data[_msgKey];
          _data = response.data[_dataKey];
        } else {
          Map<String, dynamic> _dataMap = _decodeData(response);
          _status = (_dataMap[_statusKey] is int)
              ? _dataMap[_statusKey].toString()
              : _dataMap[_statusKey];
          _code = (_dataMap[_codeKey] is String)
              ? int.tryParse(_dataMap[_codeKey])
              : _dataMap[_codeKey];
          if (_code == null) {
            _code = (_dataMap[_statusKey] is String)
                ? int.tryParse(_dataMap[_statusKey])
                : _dataMap[_statusKey];
          }
          _msg = _dataMap[_msgKey];
          _data = _dataMap[_dataKey];
        }
      } catch (e) {
        return new Future.error(new DioError(
          response: response,
          message: "data parsing exception...",
          type: DioErrorType.RESPONSE,
        ));
      }
    }
    return new BaseResp(_status, _code, _msg, _data);
  }

  /// Download the file and save it in local. The default http method is "GET",you can custom it by [Options.method].
  /// [urlPath]: The file url.
  /// [savePath]: The path to save the downloading file later.
  /// [onProgress]: The callback to listen downloading progress.please refer to [OnDownloadProgress].
  Future<Response> download(
    String urlPath,
    savePath, {
    ProgressCallback onProgress,
    CancelToken cancelToken,
    data,
    Options options,
  }) {
    return _dio.download(urlPath, savePath,
        onReceiveProgress: onProgress,
        cancelToken: cancelToken,
        data: data,
        options: options);
  }

  /// decode response data.
  Map<String, dynamic> _decodeData(Response response) {
    if (response == null ||
        response.data == null ||
        response.data.toString().isEmpty) {
      return new Map();
    }
    return json.decode(response.data.toString());
  }

  /// check Options.
  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  /// merge Option.
  void _mergeOption(RequestOptions opt) {
    _options.method = opt.method ?? _options.method;
    _options.headers = (new Map.from(_options.headers))..addAll(opt.headers);
    _options.baseUrl = opt.baseUrl ?? _options.baseUrl;
    _options.connectTimeout = opt.connectTimeout ?? _options.connectTimeout;
    _options.receiveTimeout = opt.receiveTimeout ?? _options.receiveTimeout;
    _options.responseType = opt.responseType ?? _options.responseType;
    _options.extra = (new Map.from(_options.extra))..addAll(opt.extra);
    _options.contentType = opt.contentType ?? _options.contentType;
    _options.validateStatus = opt.validateStatus ?? _options.validateStatus;
    _options.followRedirects = opt.followRedirects ?? _options.followRedirects;
  }

  /// get dio.
  Dio getDio() {
    return _dio;
  }

  /// create new dio.
  Dio createNewDio([BaseOptions options]) {
    options = options ?? getDefOptions();
    Dio dio = new Dio(options);
    return dio;
  }

  /// get Def Options.
  BaseOptions getDefOptions() {
    BaseOptions options = new BaseOptions();
    options.contentType = ContentType.json;
    options.responseType = ResponseType.json;
    options.connectTimeout = 1000 * 10;
    options.receiveTimeout = 1000 * 20;
    return options;
  }

  setInterceptor() {
    _dio.interceptors
        .add(LogOfFormatInterceptor(requestBody: true, responseBody: true));
  }

  setOption(RequestOptions opt) {
    _mergeOption(opt);
  }
}

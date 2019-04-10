// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// FlutterAnnotationsGenerator
// **************************************************************************

import 'package:flutterannotations/flutterannotations.dart';

import 'package:flutterannotations_generator_example/model/home_banner_model.dart';
import 'package:flutterannotations_generator_example/src/rest_client.dart';

class RestClientImpl extends RestClient {
  DioUtil _dio;
  static final RestClientImpl _singleton = RestClientImpl._init();

  factory RestClientImpl() {
    return _singleton;
  }
  RestClientImpl._init() {
    _dio = DioUtil();
    RequestOptions requestOptions = RequestOptions();
    requestOptions.baseUrl = "https://api.biminds.cn/";
    HttpConfig httpConfig = HttpConfig(options: requestOptions);
    List<Interceptor> interceptors = <Interceptor>[];
    interceptors.add(LogOfFormatInterceptor());
    _dio.addInterceptor(interceptors);
    _dio.setConfig(httpConfig);
  }

  ///
  /// queryTeachers by name and it
  @override
  HomeBannerModel getData<L>(String name, int id,
      {Function successCallback, Function failCallback}) {
    String path = "queryTeachers";
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    Map<String, dynamic> headers = <String, dynamic>{};
    var data = {};
    queryParameters = <String, dynamic>{"name": name, "id": id};
    Options options = Options(headers: headers);
    headers = <String, dynamic>{"1": "111", "2": "222"};
    _dio
        .get<List>(path,
            data: data, options: options, queryParameters: queryParameters)
        .then((response) {
      _execute(response, (data) {
        List<HomeBannerModel> result = [];
        data.forEach((item) {
          result.add(HomeBannerModel.fromJson(item));
        });
        successCallback(result);
      }, failCallback: failCallback);
    }, onError: (err) {
      failCallback(1, err.toString());
    });
    return null;
  }

  ///
  /// addTeacherInfo
  @override
  addTeacherInfo<M>(Map<dynamic, dynamic> map,
      {Function successCallback, Function failCallback}) {
    String path = "addTeacherInfo";
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    Map<String, dynamic> headers = <String, dynamic>{};
    var data = {};
    data = map;
    queryParameters = <String, dynamic>{};
    Options options = Options(headers: headers);
    headers = <String, dynamic>{};
    _dio
        .post<Map>(path,
            data: data, options: options, queryParameters: queryParameters)
        .then((response) {
      _execute(response, (data) {
        successCallback(data);
      }, failCallback: failCallback);
    }, onError: (err) {
      failCallback(1, err.toString());
    });
    return null;
  }

  ///
  /// deleteTeacherById by name and id
  @override
  deleteDate(String name, int id, String Hh,
      {Function successCallback, Function failCallback}) {
    String path = "deleteTeacherById";
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    Map<String, dynamic> headers = <String, dynamic>{};
    var data = {};
    queryParameters = <String, dynamic>{"aaaa": name, "id": id};
    Options options = Options(headers: headers);
    headers = <String, dynamic>{"Hh": Hh};
    _dio
        .delete<Map>(path,
            data: data, options: options, queryParameters: queryParameters)
        .then((response) {
      _execute(response, (data) {
        successCallback(data);
      }, failCallback: failCallback);
    }, onError: (err) {
      failCallback(1, err.toString());
    });
    return null;
  }

  ///
  /// updateTeacher
  @override
  updateTeacher(Map<dynamic, dynamic> map,
      {Function successCallback, Function failCallback}) {
    String path = "updateTeacher";
    Map<String, dynamic> queryParameters = <String, dynamic>{};
    Map<String, dynamic> headers = <String, dynamic>{};
    var data = {};
    data = map;
    queryParameters = <String, dynamic>{};
    Options options = Options(headers: headers);
    headers = <String, dynamic>{};
    _dio
        .put<Map>(path,
            data: data, options: options, queryParameters: queryParameters)
        .then((response) {
      _execute(response, (data) {
        successCallback(data);
      }, failCallback: failCallback);
    }, onError: (err) {
      failCallback(1, err.toString());
    });
    return null;
  }

  /// 统一处理 返回结果
  void _execute(BaseResp data, Function successCallback,
      {Function failCallback}) {
    if (data.errorCode == 0) {
      successCallback(data.data);
    } else {
      failCallback(data.errorCode, data.errorMsg);
    }
  }
}

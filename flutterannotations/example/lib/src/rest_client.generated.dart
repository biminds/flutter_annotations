//// GENERATED CODE - DO NOT MODIFY BY HAND
//
//// **************************************************************************
//// FlutterAnnotationsGenerator
//// **************************************************************************
//
//import 'package:dio/dio.dart';
//import 'package:flutterannotations/src/net/dio_util.dart';
//
//import 'package:flutterannotations_example/model/home_banner_model.dart';
//import 'package:flutterannotations_example/src/rest_client.dart';
//
//class RestClientImpl extends RestClient {
//  DioUtil _dio;
//  static final RestClientImpl _singleton = RestClientImpl._init();
//
//  factory RestClientImpl() {
//    return _singleton;
//  }
//  RestClientImpl._init() {
//    _dio = DioUtil();
//    RequestOptions requestOptions = RequestOptions();
//    requestOptions.baseUrl = "https://api.biminds.cn/";
//    _dio.setOption(requestOptions);
//  }
//
//  ///
//  /// queryTeachers by name and it
//  @override
//  HomeBannerModel getData<List>(String name, int id,
//      {Function successCallback, Function failCallback}) {
//    String path = "queryTeachers";
//    Map<String, dynamic> queryParameters = <String, dynamic>{};
//    var data = {};
//    queryParameters = <String, dynamic>{"name": name, "id": id};
//    _dio.get<List>(path, data: data, queryParameters: queryParameters).then(
//        (response) {
//      _execute(response, (data) {
//        successCallback(HomeBannerModel.fromJson(data));
//      }, failCallback: failCallback);
//    }, onError: (err) {
//      failCallback(1, err.toString());
//    });
//    return null;
//  }
//
//  ///
//  /// addTeacherInfo
//  @override
//  addTeacherInfo(Map<dynamic, dynamic> map,
//      {Function successCallback, Function failCallback}) {
//    String path = "addTeacherInfo";
//    Map<String, dynamic> queryParameters = <String, dynamic>{};
//    var data = {};
//    data = map;
//    queryParameters = <String, dynamic>{};
//    _dio.post<Map>(path, data: data, queryParameters: queryParameters).then(
//        (response) {
//      _execute(response, (data) {
//        successCallback(data);
//      }, failCallback: failCallback);
//    }, onError: (err) {
//      failCallback(1, err.toString());
//    });
//    return null;
//  }
//
//  ///
//  /// deleteTeacherById by name and id
//  @override
//  deleteDate(String name, int id,
//      {Function successCallback, Function failCallback}) {
//    String path = "deleteTeacherById";
//    Map<String, dynamic> queryParameters = <String, dynamic>{};
//    var data = {};
//    queryParameters = <String, dynamic>{"name": name, "id": id};
//    _dio.delete<Map>(path, data: data, queryParameters: queryParameters).then(
//        (response) {
//      _execute(response, (data) {
//        successCallback(data);
//      }, failCallback: failCallback);
//    }, onError: (err) {
//      failCallback(1, err.toString());
//    });
//    return null;
//  }
//
//  ///
//  /// updateTeacher
//  @override
//  updateTeacher(Map<dynamic, dynamic> map,
//      {Function successCallback, Function failCallback}) {
//    String path = "updateTeacher";
//    Map<String, dynamic> queryParameters = <String, dynamic>{};
//    var data = {};
//    data = map;
//    queryParameters = <String, dynamic>{};
//    _dio.put<Map>(path, data: data, queryParameters: queryParameters).then(
//        (response) {
//      _execute(response, (data) {
//        successCallback(data);
//      }, failCallback: failCallback);
//    }, onError: (err) {
//      failCallback(1, err.toString());
//    });
//    return null;
//  }
//
//  /// 统一处理 返回结果
//  void _execute(BaseResp data, Function successCallback,
//      {Function failCallback}) {
//    if (data.errorCode == 0) {
//      successCallback(data.data);
//    } else {
//      failCallback(data.errorCode, data.errorMsg);
//    }
//  }
//}

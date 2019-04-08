const String clazzTpl = """

import 'package:dio/dio.dart';
import 'package:flutterannotations/src/net/dio_util.dart';

{{#restAnnotationMap}}

{{#importList}}
  import '{{.}}';
{{/importList}}

{{{classDocumentationComment}}}
class {{{className}}}Impl extends {{{className}}}{
  
  DioUtil _dio;
  
  static final {{{className}}}Impl _singleton = {{{className}}}Impl._init();

  factory {{{className}}}Impl() {
    return _singleton;
  }
  
  {{{className}}}Impl._init(){
    _dio=DioUtil();
     RequestOptions requestOptions =RequestOptions();
    requestOptions.baseUrl={{{rootUrl}}};
    _dio.setOption(requestOptions);
  }

  {{#methods}}
  {{{methodDocumentationComment}}}
  @override
  {{returnType}} {{methodName}}{{#methodGeneric}}<{{.}}> {{/methodGeneric}} ({{#methodParameters}}{{{parameterType}}} {{{parameterName}}} ,{{/methodParameters}}  {Function successCallback,Function failCallback}){
    
     
    {{#methodAnnotation}}
    {{#methodAnnotationParameters}}
    String path = {{{path}}};
    {{/methodAnnotationParameters}} 
    
    Map<String, dynamic> queryParameters = <String, dynamic>{};
             
    var data ={};
    {{#data}}
    data ={{.}};
    {{/data}}
    
    {{#queryParameters}}
    queryParameters = <String, dynamic>{{{.}}};
    {{/queryParameters}}
    
    _dio.{{{methodAnnotationName}}}<{{returnType}}>(path,data: data, queryParameters: queryParameters)
          .then((response) {
        _execute(response, (data) {
            {{#methodGeneric}}
            successCallback({{.}}.fromJson(data));
            {{/methodGeneric}}
            {{^methodGeneric}}
            successCallback(data);
            {{/methodGeneric}}
        }, failCallback: failCallback);
        }, onError: (err) {
        failCallback(1, err.toString());
      });
     {{/methodAnnotation}} 
    return null;      
  }
  {{/methods}}
  
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

{{/restAnnotationMap}}

""";

const String instanceCreatedTpl = """
""";

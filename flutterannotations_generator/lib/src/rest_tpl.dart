const String clazzTpl = """

import 'package:flutterannotations/flutterannotations.dart';


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
    HttpConfig httpConfig = HttpConfig({{#resultCode}}code:{{.}},{{/resultCode}} {{#resultMessage}}msg:{{.}},{{/resultMessage}}{{#resultData}}data:{{.}},{{/resultData}}options:requestOptions);
    
    List<Interceptor> interceptors = <Interceptor>[];
    {{#interceptors}}
      interceptors.add({{.}}());
    {{/interceptors}}
    _dio.addInterceptor(interceptors);
    _dio.setConfig(httpConfig);
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
    
    Map<String, dynamic> headers = <String, dynamic>{};  
           
    var data ={};
    {{#data}}
    data ={{.}};
    {{/data}}
    
    {{#queryParameters}}
    queryParameters = <String, dynamic>{{{.}}};
    {{/queryParameters}}
    
    {{#paramMap}}
    queryParameters.addAll({{.}});
    {{/paramMap}}
    
    Options options =Options(headers:headers);
    
    {{#headers}}
    headers = <String, dynamic>{{{.}}};
    {{/headers}}
    
    _dio.{{{methodAnnotationName}}}<{{methodGenericType}}>(path,data: data, options:options,queryParameters: queryParameters)
          .then((response) {
        _execute(response, (data) {
            {{#mapType}}
            successCallback({{returnType}}.fromJson(data));
            {{/mapType}}
            
            {{#listType}}
            List<{{returnType}}> result = [];
            data.forEach((item){
            result.add({{returnType}}.fromJson(item));
            });
            successCallback(result);
            {{/listType}}
            
            {{#nullType}}
            successCallback(data);
            {{/nullType}}
        }, failCallback: failCallback);
        }, onError: (err) {
        failCallback(err.errorCode, err.errorMsg);
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

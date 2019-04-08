import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:mustache4dart/mustache4dart.dart';
import 'rest_tpl.dart';

class RestCollector {
  RestCollector();

  //{
  //  	"className":"RestClient",
  //    "rootUrl":"http://adfadfaadsad",
  //  	"classDocumentationComment":"balabalabal",
  //		"methods": [{
  //			"methodName": "getData",
  //      "methodGeneric":"Map",
  //      "methodGenericType":"Map",
  //			"queryParameters": {
  //        "pageSize":"1",
  //      },
  //			"data":"data",
  //			"methodParameters": [{
  //				"parameterType": "String",
  //				"parameterName": "sq",
  //				"parametersAnnotation": {
  //					"parameterAnnotationName": "Body",
  //					"parameterAnnotationParameters": {
  //						"name": ""
  //					}
  //				}
  //			}],
  //			"methodAnnotation": {
  //				"methodAnnotationName": "Get",
  //				"methodAnnotationParameters": {
  //					"path": "path"
  //				}
  //			}
  //		}],
  //		"returnType": "Model",
  //		"importList": [
  //       "import 'aaaaaaaa'",
  //       "import 'aaaaaaaa'"
  //    ]
  //	}
  //

  Map<String, dynamic> restAnnotationMap = <String, dynamic>{};

  void collect(ClassElement element, ConstantReader reader) {
    restAnnotationMap["className"] = element.name;

    restAnnotationMap["rootUrl"] = wK(reader.peek("rootUrl")?.stringValue);

    restAnnotationMap["classDocumentationComment"] =
        element.documentationComment;

    List<String> importList = <String>[];

    restAnnotationMap['importList'] = importList;

    List<Map<String, dynamic>> methodsList = <Map<String, dynamic>>[];

    element.methods.forEach((method) {
      _addMethodEntry(method, methodsList, importList);
    });

    restAnnotationMap["methods"] = methodsList;

    importClazz(element, importList);
  }

  void _addMethodEntry(MethodElement method,
      List<Map<String, dynamic>> methodsList, List<String> importList) {
    Map<String, dynamic> methodMap = <String, dynamic>{};
    methodsList.add(methodMap);

    methodMap['methodName'] = method.name;
    methodMap['methodDocumentationComment'] = method.documentationComment;

    var returnType = method.returnType.name;

    if (returnType == "dynamic" ||
        returnType == "Object" ||
        returnType == "List" ||
        returnType == "int" ||
        returnType == "BigInt" ||
        returnType == "String" ||
        returnType == "double" ||
        returnType == "num" ||
        returnType == "bool" ||
        returnType == "Set" ||
        returnType == "StringBuffer" ||
        returnType == "Map") {
      returnType = null;
    } else {
      importClazz(method.returnType.element, importList);
    }
    methodMap['returnType'] = returnType;
//    print("==============${method.returnType.element.location.components}");

    method.typeParameters.forEach((e) {
      methodMap['methodGeneric'] = e.name;
    });

    String methodGeneric = methodMap['methodGeneric'];

    if (methodGeneric == "List" || methodGeneric == "Map") {
      methodMap['methodGenericType'] = methodGeneric;
    } else {
      methodMap['methodGenericType'] = "Map";
    }

    Map<String, dynamic> methodAnnotation = <String, dynamic>{};
    methodMap['methodAnnotation'] = methodAnnotation;

    //获取方法中的注解 并且遍历
    method.metadata.forEach((annotation) {
      DartObject dartObject = annotation.computeConstantValue();
      //判断方法中的注解 是 Get，Post，Delete，Put
      switch (dartObject.type.name) {
        case "Get":
        case "Post":
        case "Delete":
        case "Put":
          methodAnnotation["methodAnnotationName"] =
              dartObject.type.name.toLowerCase();
          Map<String, dynamic> methodAnnotationParameters = <String, dynamic>{};
          ConstantReader constantReader = ConstantReader(dartObject);
          //获取 注解类里的 参数
          String path = constantReader.peek("path")?.stringValue;
          methodAnnotationParameters["path"] = wK(path);
          methodAnnotation["methodAnnotationParameters"] =
              methodAnnotationParameters;
          break;
        default:
      }
    });

    List<Map<String, dynamic>> methodParametersMap = <Map<String, dynamic>>[];
    methodMap["methodParameters"] = methodParametersMap;
    //获取方法中的参数 并且遍历

    Map<String, dynamic> queryParameters = <String, dynamic>{};
    methodMap["queryParameters"] = queryParameters;

    method.parameters.forEach((typeParameter) {
      Map<String, dynamic> methodParameters = <String, dynamic>{};
      methodParametersMap.add(methodParameters);
      methodParameters["parameterType"] = typeParameter.type;
      methodParameters["parameterName"] = typeParameter.name;
      //获取参数中的注解 并且遍历
      typeParameter.metadata.forEach((parameterAnnotation) {
        DartObject dartObject = parameterAnnotation.computeConstantValue();
        switch (dartObject.type.name) {
          case "Body":
            methodMap["data"] = typeParameter.name;
            ConstantReader constantReader = ConstantReader(dartObject);
            String name = constantReader.peek("name")?.stringValue;

            Map<String, dynamic> parametersAnnotation = <String, dynamic>{};
            methodParameters["parametersAnnotation"] = parametersAnnotation;

            parametersAnnotation["parameterAnnotationName"] =
                wK(dartObject.type.name);

            Map<String, dynamic> parameterAnnotationParameters =
                <String, dynamic>{};
            parameterAnnotationParameters["name"] = name;
            parametersAnnotation["parameterAnnotationParameters"] =
                parameterAnnotationParameters;
            break;
          case "Param":
          case "Path":
            queryParameters[wK(typeParameter.name)] = typeParameter.name;

            ConstantReader constantReader = ConstantReader(dartObject);
            String name = constantReader.peek("name")?.stringValue;

            Map<String, dynamic> parametersAnnotation = <String, dynamic>{};
            methodParameters["parametersAnnotation"] = parametersAnnotation;

            parametersAnnotation["parameterAnnotationName"] =
                wK(dartObject.type.name);

            Map<String, dynamic> parameterAnnotationParameters =
                <String, dynamic>{};
            parameterAnnotationParameters["name"] = name;
            parametersAnnotation["parameterAnnotationParameters"] =
                parameterAnnotationParameters;

            break;
          case "Header":
            break;
          default:
        }
      });
    });
  }

  void importClazz(ClassElement element, List<String> importList) {
    element.location.components.forEach((e) {
      if (!importList.contains(e) && e.contains("/")) {
        importList.add(e);
      }
    });
  }

  String wK(String key) {
    if (key == null) {
      return null;
    }
    return '"${key}"';
  }

  dynamic write() {
    return render(clazzTpl, <String, dynamic>{
      'restAnnotationMap': restAnnotationMap,
    });
  }
}

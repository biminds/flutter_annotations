import 'package:dio/dio.dart';
import 'dart:convert';

class LogOfFormatInterceptor extends LogInterceptor {
  LogOfFormatInterceptor({
    request = true,
    requestHeader = true,
    requestBody = false,
    responseHeader = true,
    responseBody = false,
    error = true,
    logSize = 2048,
  }) : super(
            request: request,
            requestHeader: requestHeader,
            requestBody: requestBody,
            responseHeader: responseHeader,
            responseBody: responseBody,
            error: error,
            logSize: logSize);

  @override
  onRequest(RequestOptions options) {
    print('======================== Request End========================');
    printKV('uri', options.uri);
    if (request) {
      printKV('method', options.method);
      printKV('contentType', options.contentType.toString());
      printKV('responseType', options.responseType.toString());
      printKV('followRedirects', options.followRedirects);
      printKV('connectTimeout', options.connectTimeout);
      printKV('receiveTimeout', options.receiveTimeout);
      printKV('extra', options.extra);
    }
    if (requestHeader) {
      StringBuffer stringBuffer = new StringBuffer();
      options.headers.forEach((key, v) => stringBuffer.write('\n  $key:$v'));
      printKV('header', stringBuffer.toString());
      stringBuffer.clear();
    }
    if (requestBody) {
      print("data:");
      _printDataStr(options.data);
    }
  }

  @override
  onResponse(Response response) {
    print("======================== Response Start========================");
    _printResponse(response);
    print("======================== Response End========================");
  }

  void _printResponse(Response response) {
    printKV('uri', response.request.uri);
    if (responseHeader) {
      printKV('statusCode', response.statusCode);
      if (response.isRedirect) printKV('redirect', response.realUri);
      print("headers:");
      print(" " + response.headers.toString().replaceAll("\n", "\n "));
    }
    if (responseBody) {
      print("Response Text:");
      _printDataStr(response.toString());
    }
  }

  /// print Data Str.
  void _printDataStr(Object value) {
    String temp;
    if (value is Map) {
      temp = json.encode(value).replaceAll(" ", "");
    } else {
      temp = value.toString().replaceAll(" ", "");
    }
    int startTimes = 0;
    while (temp.contains("{") ||
        temp.contains("}") ||
        temp.contains("[") ||
        temp.contains("]")) {
      int startH = temp.indexOf("{");
      int startD = temp.indexOf("[");
      int endH = temp.indexOf("}");
      int endD = temp.indexOf("]");
      int dot = temp.indexOf(",");

      var arr = [startH, startD, endH, endD, dot];
      arr.removeWhere((item) => item < 0);
      arr.sort();
      int index = arr[0];

      String symbol = temp.substring(index, index + 1);
      String stringAndSymbol = temp.substring(0, index + 1);
      temp = temp.substring(index + 1, temp.length);

      if (symbol == "{" || symbol == "[" || symbol == ",") {
        String space = "";
        int tempStartTimes = startTimes;
        while (tempStartTimes > 0) {
          space += "  ";
          tempStartTimes--;
        }
        print(space + "$stringAndSymbol");
        if (symbol != ",") {
          startTimes++;
        }
      }
      if (symbol == stringAndSymbol &&
          stringAndSymbol.length == 1 &&
          symbol == "}") {
        print("$stringAndSymbol");
      } else if (symbol == "}" || symbol == "]") {
        if (temp.startsWith(",")) {
          temp = temp.replaceFirst(",", "");
          String endSymbol = stringAndSymbol.substring(
                  stringAndSymbol.length - 1, stringAndSymbol.length) +
              ",";
          stringAndSymbol =
              stringAndSymbol.substring(0, stringAndSymbol.length - 1);
          String space = "";
          int tempEndTimes = startTimes;
          String endSpace = "";
          while (tempEndTimes > 0) {
            space += "  ";
            if (tempEndTimes > 1) {
              endSpace += "  ";
            }
            tempEndTimes--;
          }
          print(space + "$stringAndSymbol");
          print(endSpace + "$endSymbol");
          startTimes--;
        } else if (temp.startsWith("}") || temp.startsWith("]")) {
          String space = "";
          int tempEndTimes = startTimes;
          String endSpace = "";
          while (tempEndTimes > 0) {
            space += "  ";
            if (tempEndTimes > 1) {
              endSpace += "  ";
            }
            tempEndTimes--;
          }
          print(space +
              "${stringAndSymbol.substring(0, stringAndSymbol.length - 1)}");
          print(endSpace +
              "${stringAndSymbol.substring(stringAndSymbol.length - 1)}");
          startTimes--;
        } else {
          String space = "";
          int tempEndTimes = startTimes;
          while (tempEndTimes > 0) {
            space += "  ";
            tempEndTimes--;
          }
          print(space + "$stringAndSymbol");
          startTimes--;
        }
      }
    }
  }
}

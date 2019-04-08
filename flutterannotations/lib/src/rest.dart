import 'package:dio/dio.dart';

class Rest {
  final String rootUrl;

  final Interceptor interceptor;

  const Rest({this.rootUrl, this.interceptor});
}

class Post {
  final String path;

  const Post({this.path});
}

class Get {
  final String path;

  const Get({this.path});
}

class Delete {
  final String path;

  const Delete({this.path});
}

class Put {
  final String path;

  const Put({this.path});
}

class Body {
  final String name;

  const Body({this.name});
}

class Param {
  final String name;

  const Param({this.name});
}

class Path {
  final String name;

  const Path({this.name});
}

class Header {
  final Map header;

  const Header({this.header});
}

import 'package:flutterannotations/flutterannotations.dart';
import 'package:meta/meta.dart';

@immutable
class Rest {
  final String rootUrl;

  final String resultCode;

  final String resultMessage;

  final String resultData;

  final List<Type> interceptors;

  const Rest(
      {this.rootUrl,
      this.resultCode,
      this.resultMessage,
      this.resultData,
      this.interceptors});
}

class AAMethod {
  /**
   * The URI or the full URL of the web service.
   *
   * @return the address of the web service
   */

  final String path;

  final Map<String, String> header;

  const AAMethod(this.path, {this.header});
}

/**
 * <p>
 * Use on methods in {@link Rest} annotated class to add a new rest service of
 * type POST.
 * </p>
 * <p>
 * This annotation as the same constraints as {@link Get}.
 * </p>
 * <p>
 * If an extra parameter is present (ie the only one not mapped with URI
 * placeholders) it will be send in the request body using given converter.
 * @see Rest
 * @see Get
 * @see Put
 * @see Delete
 * @see Body
 */
@immutable
class Post extends AAMethod {
  const Post(String path, {Map<String, String> header})
      : super(path, header: header);
}

/**
 * <p>
 * Use on methods in {@link Rest} annotated class to add a new rest service of
 * type GET.
 * </p>
 * <p>
 * The annotation {@link #path} is mandatory and define the URI or the full
 * URL of the web service. It MAY contain placeholders defined as follow :
 * <code>{name}</code>
 * </p>
 * <p>
 * The annotated method MAY have parameters as soon as each parameter names are
 * present as placeholders in the URI.
 * </p>
 * <p>
 * The annotated method CAN return <code>void</code>,
 * {@link org.springframework.http.ResponseEntity} or any concrete java classes.
 * Interfaces CAN'T be used as return type because converters have to know which
 * object to instantiate while returning result.
 * </p>
 * <p>
 * <b>Note:</b> Generics classes are also supported both for return type and
 * parameters.
 *
 * @see Rest
 * @see Post
 * @see Put
 * @see Delete
 * @see Head
 */
@immutable
class Get extends AAMethod {
  const Get(String path, {Map<String, String> header})
      : super(path, header: header);
}

/**
 * <p>
 * Use on methods in {@link Rest} annotated class to add a new rest service of
 * type DELETE.
 * </p>
 * <p>
 * This annotation as the EXACT same constraints as {@link Post}.
 * </p>
 * @see Rest
 * @see Get
 * @see Post
 * @see Put
 * @see Body
 */
@immutable
class Delete extends AAMethod {
  const Delete(String path, {Map<String, String> header})
      : super(path, header: header);
}

/**
 * <p>
 * Use on methods in {@link Rest} annotated class to add a new rest service of
 * type PUT.
 * </p>
 * <p>
 * This annotation as the EXACT same constraints as {@link Post}.
 * </p>
 *
 * @see Rest
 * @see Get
 * @see Post
 * @see Delete
 * @see Head
 * @see Body
 */
@immutable
class Put extends AAMethod {
  const Put(String path, {Map<String, String> header})
      : super(path, header: header);
}

/**
 * This annotation can be used to add a method body to the POST, PUT
 * request from a method parameter.
 *
 * @see Rest
 * @see Post
 * @see Put
 */
@immutable
class Body {
  const Body();
}

/**
 * This annotation can be used to mark a method parameter to be an url variable.
 * This annotation is optional, because method parameters which are not
 * annotated with any annotation or not correspond to the request entity,
 * implicitly interpreted as url variables. However with this annotation you can
 * explicitly mark them. Also, with the annotation value, you can add another
 * name to the url variable. If an url variable method parameter does not have
 * the {@link Param} annotation, or the annotation value is not specified, the
 * method parameter name will be used as the url variable name. The url in the
 * {@link Get} etc. annotation must contain an url variable, which the
 * corresponding method variable will be substituted into.
 **
 * @see Rest
 */
@immutable
class Param {
  /**
   * Name of the url variable.
   *
   * @return the url variable name
   */
  final String name;

  const Param([this.name]);
}

/**
 * This annotation can be used to mark a method parameter to be an url variable.
 * This annotation is optional, because method parameters which are not
 * annotated with any annotation or not correspond to the request entity,
 * implicitly interpreted as url variables. However with this annotation you can
 * explicitly mark them. Also, with the annotation value, you can add another
 * name to the url variable. If an url variable method parameter does not have
 * the {@link Path} annotation, or the annotation value is not specified, the
 * method parameter name will be used as the url variable name. The url in the
 * {@link Get} etc. annotation must contain an url variable, which the
 * corresponding method variable will be substituted into.
 **
 * @see Rest
 */
@immutable
class Path {
  /**
   * Name of the url variable.
   *
   * @return the url variable name
   */
  final String name;

  const Path([this.name]);
}

/// Override header using method parameter
/// @Get()
/// fetch(@Header('foo') String headerFoo)
@immutable
class Header {
  final String name;

  const Header([this.name]);
}

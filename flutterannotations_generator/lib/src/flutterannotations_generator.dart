import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'collector.dart';
import 'package:flutterannotations/src/rest.dart';

class FlutterAnnotationsGenerator extends GeneratorForAnnotation<Rest> {
  @override
  dynamic generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    RestCollector restCollector = RestCollector();
    restCollector.collect(element, annotation);
    return restCollector.write();
  }
}

import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'package:flutterannotations_generator/src/flutterannotations_generator.dart';

Builder flutterAnnotationsWriteBuilder(BuilderOptions options) =>
    LibraryBuilder(FlutterAnnotationsGenerator(),
        generatedExtension: '.generated.dart');

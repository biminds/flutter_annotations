import 'package:flutterannotations/flutterannotations.dart';
import 'package:flutterannotations_generator_example/model/home_banner_model.dart';

@Rest(
    rootUrl: "https://api.biminds.cn/", interceptors: [LogOfFormatInterceptor])
abstract class RestClient {
  ///
  /// queryTeachers by name and it
  @Get("queryTeachers", header: {"1": "111", "2": "222"})
  HomeBannerModel getData<List>(@Param() String name, @Param() int id);

  ///
  /// addTeacherInfo
  @Post("addTeacherInfo")
  Map addTeacherInfo(@Body() Map map);

  ///
  /// deleteTeacherById by name and id
  @Delete("deleteTeacherById")
  deleteDate(@Param("aaaa") String name, @Param() int id ,@Header() String Hh);

  ///
  /// updateTeacher
  @Put("updateTeacher")
  updateTeacher(@Body() Map map);
}

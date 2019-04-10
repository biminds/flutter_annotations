# FlutterAnnotations


# Description

Fast Flutter Development. Easy maintenance.


# Usage

# Create your REST API interface

The Rest API works with a @Rest annotated interface. It's the entry point.

1. **Rest**

   ```Dart
      @Rest(rootUrl: "https://api.biminds.cn/")
      abstract class RestClient {
        
      }
   ```
2. Annotate **your own RestClient class** with **@Get** 

   ```Dart
       @Rest(rootUrl: "https://api.biminds.cn/")
       abstract class RestClient {
         
        // OK
        @Get(path: "queryTeachers")
        List getData(@Param() String name,@Param() int id);
        
        // OK
        @Get(path: "queryTeachers/{name}")
        List getData(@Path() String name,@Param() int id);
        
        // OK
        @Get(path: "queryTeachers?name={name}")
        List getData(@Path() String name,@Param() int id);
        
        // OK
        @Get(path: "queryTeachers?name={name}&id={id}")
        Map getData(@Path() String name,@Param() int id);
        
        // OK
        @Get(path: "queryTeachers/{name}/{id}")
        dynamic getData(@Path() String name,@Param() int id); 
        
        // WRONG
        @Get(path: "queryTeachers")
        getData(@Body() String name);// Wrong, `@Body` can't be defined in `@Get`.

        // WRONG
        @Get(path: "queryTeachers/{name}/{id}")
        getData(@Path() String name); // Wrong, "id" must be defined with `@Path`.
        
        // WRONG
        @Get(path: "queryTeachers/{name}/{id}")
        getData(@Path() String name,@Param() int id); // Wrong, "id" must be defined with `@Path`.
        
        // WRONG
        @Get(path: "queryTeachers/{name}/{id}")
        Map getData(@Param() String name,@Param() int id); // Wrong, "name"  and "id" must be defined with `@Path`.
        
        // WRONG
        @Get(path: "queryTeachers")
        List<HomeBannerModel> getData<L>(@Param() String name,@Param() int id); // Wrong, method return must be HomeBannerModel
        
        // OK
        @Get(path: "queryTeachers")
        HomeBannerModel getData<L>(@Param() String name,@Param() int id); // OK, method return must be HomeBannerModel

        // WRONG
        @Get(path: "queryTeachers")
        Map<HomeBannerModel> getData<M>(@Param() String name,@Param() int id); // Wrong, method return must be HomeBannerModel
        
        // OK
        @Get(path: "queryTeachers")
        HomeBannerModel getData<M>(@Param() String name,@Param() int id); // OK, method return must be HomeBannerModel        
        
      }
   ```   
3. Annotate **your own RestClient class** with **Post**

   ```Dart
      @Rest(rootUrl: "https://api.biminds.cn/")
      abstract class RestClient {
      
        // OK
        @Post(path: "updateTeacherInfo")
        Map postData(@Body() Map map);      
      }
   ```   
4. Annotate **your own RestClient class** with **Delete**

   ```Dart
      @Rest(rootUrl: "https://api.biminds.cn/")
      abstract class RestClient {
  
        // OK
        @Delete(path: "deleteTeacherById")
        deleteDate(@Param() String name,@Param() int id);
        
        // OK
        @Delete(path: "deleteTeacherById/{name}")
        deleteDate(@Path() String name,@Param() int id);

        // OK
        @Delete(path: "deleteTeacherById?name={name}")
        deleteDate(@Path() String name,@Param() int id);

        // OK
        @Delete(path: "deleteTeacherById?name={name}&id={id}")
        deleteDate(@Path() String name,@Param() int id);
     
        // OK
        @Delete(path: "deleteTeacherById/{name}/{id}")
        deleteDate(@Path() String name,@Param() int id);
     
        // WRONG
        @Delete(path: "deleteTeacherById")
        deleteDate(@Body() String name);// Wrong, `@Body` can't be defined in `@Delete`.
 
        // WRONG
        @Delete(path: "deleteTeacherById/{name}/{id}")
        deleteDate(@Path() String name); // Wrong, "id" must be defined with `@Path`.
     
        // WRONG
        @Delete(path: "deleteTeacherById/{name}/{id}")
        deleteDate(@Path() String name,@Param() int id); // Wrong, "id" must be defined with `@Path`.
            
        // WRONG
        @Delete(path: "deleteTeacherById/{name}/{id}")
        deleteDate(@Param() String name,@Param() int id); // Wrong, "name"  and "id" must be defined with `@Path`.
              
      }
   ```   
5. Annotate **your own RestClient class** with **Put**

   ```Dart
      @Rest(rootUrl: "https://api.biminds.cn/")
      abstract class RestClient {
  
        ///更新数据
        /// comment
        @Put(path: "updateTeacher")
        updateTeacher(@Body() Map map);
     
       
      }
   ```   
6. run the build_annotation_route.sh in your workspace Or just run the command below in your workspace  
   build:

   ```shell
    flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

   suggest you running the clean command before build:  
    clean:

   ```shell
    flutter packages pub run build_runner clean

# Installation

## install from packages

add packages to dev_dependencies in your pubspec.yaml  
example:

```yaml
dependencies:
  flutterannotations: ^1.0.1
```

## install from source code

clone the code, then put it into your workspace, announce it in your pubspec.yaml
example:

```yaml
dependencies:
  flutterannotations:
    path: flutterannotations
```
  
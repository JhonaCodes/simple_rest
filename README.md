# simple_rest


<div style="background-color: #0000; padding: 10px;">
  <img src="https://pub.dev/static/img/pub-dev-logo-2x.png?hash=EG7dN74T-aRg8OtEFW85_g" width="200" alt="pub.dev logo">
</div>

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![simple_rest](https://img.shields.io/pub/v/simple_rest.svg)](https://pub.dev/packages/simple_rest)

### simple_rest is a Dart package that provides a simple way to create RESTful APIs in Dart.

## Installation
To install simple_rest, add the following dependency to your pubspec.yaml file:

````dart
dependencies:
  simple_rest: ^0.4.3
````
Or just type on console:
```dart
dart pub add simple_rest
```

Then run ```dart pub get``` on the command line.

## Use
```dart
import 'package:simple_rest/simple_rest.dart';
```

## Estructure (Opcional)

Initially, the example suggests a folder structure to follow some best practices when building the system, but you can structure it however you prefer.

```
model
crud
repository
service
controller
main.dart
```

How to create Endpoints:
```dart
/// Call the methods we need and use them in our controller functions.
/// Declare controller using [RestController] + path
/// USE:
/// GetMapping
/// PostMapping
/// DeleteMapping
/// PatchMapping
/// PutMapping
/// Request its obligatory parameter for 
@RestController('/school')
class SchoolController {

  Request request;


  SchoolController(this.request);

  @GetMapping(path: '/id/<number>')
  Map<String, dynamic> printSchoolIdWithNumber(@PathVariable('number') dynamic number) {
    var token = request.headers['Authorization'];
    return {'name': 'Name School', 'number': number, 'token':token};
  }

  @GetMapping(path: '/')
  Map<String, dynamic> printSchoolIdWithNumber5() {
    var token = request.headers['Authorization'];
    return {'name': 'Name School', 'token':token};
  }

  @GetMapping(path: '/apellido/<ape>')
  Map<String, dynamic> printSchoolIdWithName2(@PathVariable('ape') dynamic name) {
    return {'address': 'J 23 Remuerandia', 'apellido': name};
  }

  @GetMapping(path: '/name/<name>')
  Map<String, dynamic> printSchoolIdWithName(@PathVariable('name') dynamic name) {
    return {'address': 'J 23 Remuerandia', 'school': name};
  }

  @PostMapping(path: '/')
  List<Map<String, dynamic>> saveSchool(@BodyAttribute('body') dynamic bodyData) {
    Map<String, dynamic> moreInfo = {
      "school": "san jose"
    };

    var dataSchool = jsonDecode(bodyData );
    return [
      moreInfo,
      dataSchool
    ];
  }

  @DeleteMapping(path: '/id/<id>')
  Map<String, dynamic> deleteSchool(@PathVariable('id') String id){

    List<String> dates = ['jhon','juan','pedro'];
    dates.remove(id);

    return {
      "names": dates
    };
  }

  @PatchMapping(path: '/')
  Map<String, dynamic> updateSchool(@BodyAttribute('body') dynamic body){
    var dataSchool = jsonDecode(body );
    return dataSchool;
  }


  @PutMapping(path: '/')
  Map<String, dynamic> updateSchoolComplete(@BodyAttribute('body') dynamic body){
    var dataSchool = jsonDecode(body );
    return dataSchool;
  }

}
```

### Envoroment Data

Create a ```.env``` file on main path on your project, then use a personalized class for calling data.

```dart
class Env{

  static final SEnviromentData _sEnviromentData = SEnviromentData(path: '.env');

  static int get port => int.parse( _sEnviromentData.eniValue(key: 'PORT_SERVER') );
  static String get url => _sEnviromentData.eniValue(key: 'URL_API');
  static String get apiKey => _sEnviromentData.eniValue(key: 'API_KEY');

}
```
On ```.env``` file your server data, and use those key for calling data from class Env.
```yaml
IP_SERVER=127.0.0.1
PORT_SERVER=8090
JWT_LOCAL_KEY=0283hr9h39238r
MY_CUSTOM_NAME=0283hr9h39238r
URL_API=23oifh23iuf
API_KEY=2oihf23ibf
API_AUTH=poi2jf932ifo
USER_DB=2o3hfi23iufb
PASS_DB=iwufbweif
URL_DB=wouifh2iufb
```

For initialize our server as follows and Just register the controllers on controllerList.

```dart
void main() {

  Router  app = Router();
  SServer server = SServer();

  server.start(
    port:  Env.port,
    isRouterControlActive: false,
    app: app,
    controllerList: [
      SchoolController
    ],
  );


}

```

This is how our server will be initialized and in my case, we can use our server as localhost on port 8080 with the endpoint user/all, which would look like this."https://localhost:8080/user/al"

![server_inicialization.png](https://raw.githubusercontent.com/JhonaCodes/simple_rest/e8bae7d470798e7860767458864c708ffcb1f660/screenshoots/server_inicialization.png)

using
![endpoint.png](https://raw.githubusercontent.com/JhonaCodes/simple_rest/e8bae7d470798e7860767458864c708ffcb1f660/screenshoots/endpoint.png)


# Additional Notes.

This mini library was created with only one purpose in mind - to be able to quickly and easily initialize your backend. That's why I made sure to use as few libraries as possible. This makes it lightweight and powerful, which improves the performance of our API. I tried to make the library easy to implement.

As a developer, you will likely find redundancy in some parts of the code, so I would appreciate it if you inform me in the most polite way possible. Remember, we can grow together 😘.

# simple_rest -> UNDER CONSTRUCTION


<div style="background-color: #0000; padding: 10px;">
  <img src="https://pub.dev/static/img/pub-dev-logo-2x.png?hash=EG7dN74T-aRg8OtEFW85_g" width="200" alt="pub.dev logo">
</div>

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Nombre del paquete](https://img.shields.io/pub/v/simple_rest.svg)](https://pub.dev/packages/simple_rest)

### Simple REST is a Dart package that provides a simple way to create RESTful APIs in Dart.

## Installation
To install Simple REST, add the following dependency to your pubspec.yaml file:

````dart
dependencies:
  simple_rest: ^0.3.3
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

## Estructura (Opcional)

Initially, the example suggests a folder structure to follow some best practices when building the system, but you can structure it however you prefer.

```
model
crud
repository
service
controller
main.dart
```

Initially, you should create your model and its CRUD methods.

```dart
class UserModel{}

/// Luego debria crear su crud y podria usar el estandar de simple_rest.
/// para esto solo debe implements el mixin STCrud a su mixin o class crud.

mixin UserCrud implements STCrud<UserModel>{}
/// esto actuaria como una interface para java

/// Posteriormente usted deberia crear su reository.
/// Usted debe implements el mixin UserCrud en UserRepository
/// Asi usaria los metodos establecidos en crud y podra agregar los suyos directamente al UserCrud
class UserRepository implements UserCrud{}

/// Luego debemos crear nuestra clase service que va a usar los metodos del repository.
/// Creas una isntancia de repository, creamos los metodos contenedores y usamos nuestras funciones.

class UserService {
  var userRepository = UserRepository();
    Future<List<UserModel>> getAllUsers() async{

    return await userRepository.getAll();
  }
}

/// Finally, we create our Controller class, create an instance of Service,
/// call the methods we need and use them in our controller functions.
class UserController {

  /// This class interacts with the service and processes the received information by sending it to the SubscribeData method.
  static var userService = UserService();
  
    static  Future<void> getAllUser() async{

    List<UserModel> users = await userService.getAllUsers();
    List<Map<String, dynamic>> usersJson = users.map((user) => user.toJson()).toList();

    SController.subscribeData(
      jsonDataList: usersJson
    );

  }
}
```
It is from this class where simple_rest starts to do its job, since it follows a class-based reference architecture. You don't need to create annotations like @Get, etc, but only subscribe services to a function. This function is constantly listening to the server and simply subscribes to the server initialization.
## Here's an example of how to use it (mandatory).

Requirements:
- Have our controller class with the methods we will use already established as static.
- Create a static function named "init" or any other name that helps us identify that we want to initialize our functions.

1. Create functions that return the information we need, for example, to view all the users.
```dart
  static  Future<void> getAllUser() async{

    List<UserModel> users = await userService.getAllUsers();
    List<Map<String, dynamic>> usersJson = users.map((user) => user.toJson()).toList();
  }
```
At this point we have user data in the format of List<Map<String, dynamic>>.

2. We need to subscribe our result to our class that subscribes all our results, these results are displayed to the user depending on what they query, simple_rest takes care of that, so we do the following.

```dart
  static  Future<void> getAllUser() async{

    List<UserModel> users = await userService.getAllUsers();
    List<Map<String, dynamic>> usersJson = users.map((user) => user.toJson()).toList();
    
    /// Data Subscription
        SController.subscribeData(
      jsonDataList: usersJson
    );
  }

```
At this point, we subscribe our result with the SController class using the SubscribeData function. 🙃

### This process is similar for all query data. I will leave an example of the complete implementation of my sample controller at the end.

3. We must create the static function that will be in charge of initializing our methods, in this case, getAllUser(). Note that at this point, none of the functions should receive data as parameters, everything is being handled internally.

```dart
/// On my case my function for initialization is init 🤪
  static void init() {}
```

4. Then we must define the functions with the endpoints we want to establish, along with the requests that must be executed to call them. In other words, we will create the endpoints for each function.

```dart
    SController.registerEndpoints(endPoints: [

      SRouterController(
        http: SHttpMethod.GET,
        literalPath: 'user/all',
        function: getAllUser,
      ),
    }
```
For this case, we will use SController to call registerEndpoints, which obviously does what we think it does. Inside this function, we create a list that will contain our endpoints. Each endpoint is registered using the SRouterController class, which in turn contains parameters that must be set.

Where "http" sets the type of request it will listen for, "function" is the function that is referenced in this case getAllUser without initializing it, and finally we set its endpoint literalPath, which, if we're not sending parameters, must be declared without ending in "/", just as it is in the example.

The SRouterController class also contains an attribute called "pathList", which is a list of our endpoint paths. It works like this: "pathList: [user, all]". This way, the endpoint would be "user/all". It's just a different way of doing it.

This process is done for each function in our Controller class.

## That's it! Our endpoint is ready to be initialized and used on our server. Here's how to do it:
In our main void() function, we will initialize our server. To do this, we have 3 options:

1. Using the [.env] file, which sets the access IP and port that can later be instantiated using the SEnviromentData class, which has multiple import options. The [.env] file must be created in the root of your project to be able to use the SEnviromentData class.

The options currently available in the SEnviromentData class are: 
```
urlApi
someData
apiKey
apiAuth
userDb
passDb
urlDb
ipServer
jwtSecretKey
portServer
```
You can use the pre-established keys for each method, or if you prefer, you can use your own pre-established names. Also, if you need more data, you can use the 'someData' option and pass your custom key as a string reference, as follows.
```dart
SEnviromentData.someData("MY_CUSTOM_KEY_NAME")
```
2. Using the default configuration, for this we simply use the defaultConfig() function, which will use the local IP and port 8080 for the server.

3. We use the customized configuration, which is customConfig(), which receives 2 parameters, the IP and the Port.

For this example, we will use the default configuration as follows.

```dart
void mian()async{
  SServer server = SServer.defaultConfig();
  
}

```

Then we initialize our server as follows.

```dart
void mian()async{
  SServer server = SServer.defaultConfig();
  
    await server.started();
  
}
```

Finally, we add our endpoints that are already initialized and waiting to listen to the server to be executed. We do this as follows.

```dart
void mian()async{
  SServer server = SServer.defaultConfig();
  
    await server.started(
          [
        UserController.init
      ]
    );
  
}
```

This is how our server will be initialized and in my case, we can use our server as localhost on port 8080 with the endpoint user/all, which would look like this."https://localhost:8080/user/al"

![server_inicialization.png](screenshoots%2Fserver_inicialization.png)

using
![endpoint.png](screenshoots%2Fendpoint.png)

# Aditional

simple_rest has the SSecretKey.generate() class which generates a key that we can use for our JWT, which is also implemented in Simple_rest. To use JWT, we use SJwt.generateJWT as follows.

```dart
 var userJwt = SJwt.generateJWT(
      customSecureKey: SEnviromentData.jwtSecretKey(key: "MY_CUSTOM_NAME"),
      jwtUserInfo:
      {
        "mail": "my_client_mail@gmail.com",
      }
  );
```
To check if the incoming user is authenticated via JWT, we simply do the following.

```dart
  if (SJwt.verifyUser(token: userJwt)['response']) {
    print("USER VALID");
  }
```

# FULL CODE CONTROLLER
```dart
import 'package:simple_rest/simple_rest.dart';

import '../model/user_model.dart';
import '../service/user_service.dart';

///We use our [UserController] to call the data from our service,
///then transform it into a json using our [userModel] function [toJson]
///and transform it into a [List] to return a [Map] listing.
class UserController {

  /// Esta clase interaactua con el service y procesa la infromacion recibida enviandola al Suscribedata
  static var userService = UserService();

  /// Example GET
  static  Future<void> getAllUser() async{

    List<UserModel> users = await userService.getAllUsers();
    List<Map<String, dynamic>> usersJson = users.map((user) => user.toJson()).toList();

    ///After processing our information, we subscribe our data
    ///to the response string to be displayed -
    ///under the query made by our client, which is -
    ///managed by our [simple_rest] library
    SController.subscribeData(
      jsonDataList: usersJson
    );

  }

  /// The get parameters on link
  static Future<void> getUserByName()async{

    var uri = Uri.parse(SController.request.uri.toString());

    var idOrName = uri.queryParameters['Id'];
    Logs.info(title: "QUERRY PARAMETERS", msm: idOrName);

    SController.subscribeData(
        jsonData: uri.queryParameters
    );

  }

  /// Example POST
  static Future<void> saveUser() async{

    /// Coming data form json format
    /// use [SSerializer.build(SController.request)]
    /// Read Data with SController.request
    /// Serialize data with [SSerializer.build]
    UserModel userModel = UserModel.fromJson(
        await SSerializer.buildModel( SController.request )
    );

    userService.saveUser(userModel);

    SController.subscribeData(
        jsonDataList: [userModel.toJson()]
    );

  }

  /// Example Upload File
  static Future<void> saveFile() async{

    Map status = {};

    /// This way we save all types of files.
    /// You define at this point what type of files and size you allow.
    /// the response is added to your variable in this case [status].
    /// you name it whatever you want.
    /// don't end your path with [/].
    await SSerializer.buildFile(
        SController.request,
        pathToSaveFile: '/Volumes/Data/DartLang/files_simple_rest',
    ).then((value) => status = value);


    SController.subscribeData(
        jsonDataList: [status]
    );


  }

  /// Example DELETE
  static Future<bool> deleteUser()async{

    /// In this way you use the data that you add to the url of your request
    var uri = Uri.parse(SController.request.uri.toString());
    var idOrName = uri.queryParameters['id'];
    /// At this point you get the id of your user in the variable[idOrName]

    bool statusDeleteUser = await userService.removeUser(idOrName.toString());

    SController.subscribeData(
        jsonData: {
          "response": statusDeleteUser
        }
    );

    return true;

  }


  /// We create our init function inside the [UserController] class
  /// this should contain our function [registerEndpoints]
  /// fetched from [SController]
  /// inside this we register our [endPoints],
  /// using the [SRouterController] case as a model and for Http requests,
  /// we use the [SHttpMethod] class which in this case is a [GET] type
  /// We create our path which can be literal or list of text.
  /// We add the function in this case [getAllUser] and that's it.
  static void init() {

    SController.registerEndpoints(endPoints: [

      SRouterController(
        http: SHttpMethod.GET,
        literalPath: 'user/all',
        function: getAllUser,
      ),

      SRouterController(
        http: SHttpMethod.GET,
        literalPath: 'user/',
        function: getUserByName,
      ),

      SRouterController(
        http: SHttpMethod.POST,
        literalPath: 'user',
        function: saveUser,
      ),

      /// To send values or parameters in the link.
      /// You must end the path with [/]
      /// on the client should have something like [http://myapihost:123/user/?id=12e23ed23e]
      SRouterController(
        http: SHttpMethod.DELETE,
        literalPath: 'user/',
        function: deleteUser,
      ),

      /// In this way, the path and the function that is responsible for adding files are added.
      /// In this case the idea was to add photos, you can put the path that you like best.
      SRouterController(
        http: SHttpMethod.POST,
        literalPath: 'user/photo',
        function: saveFile,
      ),
    ]);
  }

}
```

#FULL CODE MAIN

```dart
/// ****************************************************
///                                                    *
///               By: JhonaCode                        *
///               Web:     https://jhonacode.com       *
///               Email:   jhoancode2020@gmail.com     *
///               Twitter: @jhonacode                  *
///               Facebook: @jhonacode                 *
///               Telegram: @jhoancode                 *
///               March 2023                           *
///                                                    *
///         Licensed under the MIT License             *
///                                                    *
/// ****************************************************

import 'package:simple_rest/simple_rest.dart';

import 'controller/user_controller.dart';


void main() async {

  /// Server config initialization
  /// [SServer.envConfig], [SServer.customConfig], [SServer.defaultConfig]
  /// If we are going to use the [envConfig] configuration we must create a file
  /// hidden inside the root of our project name [.env]
  /// for this we use the defined keys or the ones we decide
  /// IF we add our keys, these must be passed as a parameter to the function.
  SServer server = SServer.defaultConfig();

  /// Here we use our instance of  [SServer]
  /// to call our init methods of each controller we have in our project.
  await server.started(
      [
        UserController.init
      ]
  );

  /// ADDITIONAL NOTES

  /// We can also use the JWT function
  /// that is implemented in this library as follows.

  /// We can create a key for our JWT that is also included in this library.
  /// we must use the [SSecretKey] class and generate the class by starting our main method

  /// When generating we copy that key and we can delete or comment this invasion.
  SSecretKey.generate();

  /// Create a token and use the key before general so we can add it in our [.env] file
  /// for that we can use our class [SEnviromentData] and call the information we need.
  /// in this case we are looking for the [jwtSecretKey()]
  /// If we use our custom names in the [.env] file, we must call them when calling the value
  /// [SEnviromentData.jwtSecretKey("MY_CUSTOM_NAME")]
  /// If you have other data you want to add you can use the function [someData(key:'MY_CUSTOM_NAME')]
  var userJwt = SJwt.generateJWT(
      customSecureKey: SEnviromentData.jwtSecretKey(key: "MY_CUSTOM_NAME"),
      jwtUserInfo:
      {
        "mail": "JHonatan@gmail.com",
      }
  );

  /// Then to validate our user, we use the [verifyUser] function
  /// to which we pass the parameter [token] our [userJwt]
  /// We also call the check the value of the response since this -
  /// returns a Map<String, bool>
  if (SJwt.verifyUser(token: userJwt)['response']) {
    print("USER VALID");
  }

  /// External library used:
  /// [logger] ^1.3.0
  /// [dart_jsonwebtoken] ^2.7.1

}

```



# Additional Notes.

This mini library was created with only one purpose in mind - to be able to quickly and easily initialize your backend. That's why I made sure to use as few libraries as possible. This makes it lightweight and powerful, which improves the performance of our API. I tried to make the library easy to implement.

As a developer, you will likely find redundancy in some parts of the code, so I would appreciate it if you inform me in the most polite way possible. Remember, we can grow together 😘.
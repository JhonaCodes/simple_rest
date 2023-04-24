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


  /// Next update:
  /// Ability to upload files using only the dart:io library.

}

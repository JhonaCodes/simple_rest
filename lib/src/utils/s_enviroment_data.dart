import 'dart:io';

import 'package:simple_rest/simple_rest.dart';

/// This class is responsible for reading data from the environment file.
/// We can define our .env file path or use the default one in the library.
/// Environment variables:
/// IP_SERVER=0.0.0.0
/// PORT_SERVER=8090
/// JWT_LOCAL_KEY=9832yr794yw
/// URL_API=https://link your res api [supabase, firebase, etc]
/// API_KEY
/// API_AUTH
/// USER_DB
/// PASS_DB
/// URL_DB
class SEnviromentData{

  static String path = '';

  static final _enviroment = _loadEnvFile;

  static String get ipServer     => _enviroment['IP_SERVER'].toString();
  static int get portServer      => int.parse(_enviroment['PORT_SERVER'].toString());
  static String get jwtSecretKey => _enviroment['JWT_LOCAL_KEY'].toString();
  static String get urlApi  => _enviroment['URL_API'].toString();
  static String get apiKey  => _enviroment['API_KEY'].toString();
  static String get apiAuth => _enviroment['API_AUTH'].toString();
  static String get userDb  => _enviroment['USER_DB'].toString();
  static String get passDb  => _enviroment['PASS_DB'].toString();
  static String get urlDb   => _enviroment['URL_DB'].toString();

 static Map<String, String> get _loadEnvFile {

   String filePath = "../.env";

   File env = File( path.isEmpty ? filePath : path);

   if( !env.existsSync() ){
     filePath = ".env";
     env = File( path.isEmpty ? filePath : path);
   }

   String envContents = env.readAsStringSync();

    final envVars = envContents.split('\n');
    final envMap = <String, String>{};
    for (final envVar in envVars) {
      final keyValue = envVar.split('=');
      if (keyValue.length == 2) {
        envMap[keyValue[0].trim()] = keyValue[1].trim();
      }
    }
    return envMap;
  }

}

/// ****************************************************
///                                                    *
///               By: JhonaCode                        *
///               Web:     https://jhonacode.com       *
///               Email:   jhonacode2020@gmail.com     *
///               Twitter: @jhonacode                  *
///               Facebook: @jhonacode                 *
///               Telegram: @jhonacode                 *
///               March 2023                           *
///                                                    *
///         Licensed under the MIT License             *
///                                                    *
/// ****************************************************


import 'dart:io';

import 'package:simple_rest/simple_rest.dart';

/// This class is responsible for reading data from the environment file.
/// We can define our .env file path or use the default one in the library.

class SEnviromentData{

  /// Just define your own path for .env file
  String path = '';

  /// call env value for use on your application
  dynamic eniValue({required String key}){
    return _loadEnvFile[key];
  }

  /// hidden function for return env map
  Map<String, String> get _loadEnvFile {

   String filePath = "../.env";
   final envMap = <String, String>{};
   try{
     
       File env = File( path.isEmpty ? filePath : path);

       if( !env.existsSync() ){
         filePath = ".env";
         env = File( path.isEmpty ? filePath : path);
       }

       String envContents = env.readAsStringSync();

       final envVars = envContents.split('\n');

       for (final envVar in envVars) {
         final keyValue = envVar.split('=');
         if (keyValue.length == 2) {
           envMap[keyValue[0].trim()] = keyValue[1].trim();
         }
       }

   }catch(e){
     Logs.error(title: "NO FILE", msm: "🔥 Error to calling file");
   }


    return envMap;
  }

}

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

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mime/mime.dart';

/// This class is for deserialization, any request to Map data.
/// Why, Well [Map] to any instance its easy if you make a name contructor [fromJson]
class SSerializer{

  static Future<Map> buildModel(HttpRequest request)async{
    var body = await utf8.decoder.bind(request).join();
    var jsonMap = jsonDecode(body);

    return await jsonMap;
  }



  static Future<Map<String, String>> buildFile(HttpRequest request,{required String pathToSaveFile, String? responseOnSaved, String? responseOnUnsaved})async{

    if (request.headers.contentType?.mimeType == 'multipart/form-data') {

      final parts = MimeMultipartTransformer(request.headers.contentType!.parameters['boundary']!).bind(request);

      await for (var part in parts) {

        final contentDisposition = part.headers['content-disposition'];

        final filename = RegExp(r'filename="(.*)"').firstMatch(contentDisposition!)![1];

        final saveFile = File('$pathToSaveFile/$filename');
        await saveFile.create(recursive: true);
        await part.pipe(saveFile.openWrite());

      }
      return {'response': responseOnSaved ??'File saved'};

    } else {

      return {'response': responseOnUnsaved ??'Error, file Not saved'};

    }

  }

}

//contentType?.mimeType == 'image/png' &&
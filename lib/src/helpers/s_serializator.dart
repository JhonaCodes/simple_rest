import 'dart:convert';
import 'dart:io';

/// This class is for deserialization, any request to Map data.
/// Why, Well [Map] to any instance its easy if you make a name contructor [fromJson]
class SSerializer{

  static Future<Map> build(HttpRequest request)async{
    var body = await utf8.decoder.bind(request).join();
    var jsonMap = jsonDecode(body);

    return await jsonMap;
  }

}
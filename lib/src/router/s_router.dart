import 'dart:io';

import 'package:simple_rest/src/utils/s_http_exception_handler.dart';

import '../controller/s_controller.dart';
import '../utils/s_logs.dart';

class SRouter{

  static SRouter? _router;
  final Map<String, Function> _routes = {};
  SRouter._();

  static SRouter get getInstanceSRouter{
    _router ??= SRouter._();
    return _router!;
  }

  Map<String, Function> getRoute() => _routes;

  /// Esta funcion es llamada exclusivamente desde el controller para que se llenen
  /// los endpoint registrados en el controller de nuestra api
  /// abstrallendo el proceso de registro desde la clase [SController]
  void setRouter(Map<String, Function> endPoint) {
    _routes.addAll(endPoint);
    Logs.info(title: "PATH ONLINE", msm: _routes.keys.join("\n"));
  }

  /// Verifica qcual es el llamado que hac el cliente y lo suscribe para ser mostrado
  /// esta verifiacion se hace hacia lo que tenemos almacenado en el callback
  /// llama la funcion desde la clave que contiene el endpoint y el path
  void route(HttpRequest request) async {

    var methodPath = '${request.method}:${request.uri.path}';

    Logs.debug(title: "REQUEST CLIENT",msm: request.method);
    Logs.debug(title: "PATH CLIENT",msm: request.uri.path);

    try{

      var callback = getRoute()[methodPath];

      if (callback != null) {

        await callback(request);

      } else {

        var response = request.response;

        await HttpExceptionHandler.exceptions(response: request).whenComplete(() async{
          await response.close();
          Logs.simpleDebug(title: "RESPONSE ACTION", msm: "Closing response");
        } );



      }

    }catch(e){
      request.response.headers.contentType = ContentType.json;
      request.response.write('{"response": "No operator matches the given name and argument types. You might need to add explicit type casts."}');
      await request.response.close();
      Logs.error(title: "Error", msm: e.toString());
    }


  }

}
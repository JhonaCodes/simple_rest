import 'dart:io';

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
    Logs.p("➡️PATH ONLINE ⬇️\n${_routes.keys.join("\n")}");
    Logs.p("--------------------------------------");
  }

  /// Verifica qcual es el llamado que hac el cliente y lo suscribe para ser mostrado
  /// esta verifiacion se hace hacia lo que tenemos almacenado en el callback
  /// llama la funcion desde la clave que contiene el endpoint y el path
  void route(HttpRequest request) async {

    print(request.uri.queryParameters['id']);

    var methodPath = '${request.method}:${request.uri.path}';

    Logs.debug(title: "REQUEST CLIENT",msm: request.method);
    Logs.debug(title: "PATH CLIENT",msm: request.uri.path);

    Logs.p("🟢REQUEST CLIENT: ${request.method}");
    Logs.p("🟠PATH CLIENT: ${request.uri.path}");

    try{

      var callback = getRoute()[methodPath];

      if (callback != null) {

        await callback(request);

      } else {

        var response = request.response;
        response.statusCode = HttpStatus.notFound;

        Logs.failure(title: "ERROR", msm: "Status code: ${response.statusCode}");
        Logs.failure(title: "CLOSE RESPONSE", msm: "Cerrando response");

        Logs.p("⚠️ ERROR:  ${response.statusCode}");

        await response.close();

      }

    }catch(e){
      Logs.p(e.toString());
      Logs.error(title: "Error", msm: e.toString());
    }


  }

}
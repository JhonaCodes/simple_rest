import 'dart:io';

import 'package:simple_rest/simple_rest.dart';

import '../router/s_router.dart';
import '../router/s_router_controller.dart';

/// Todas las clases de lalibreria vana contener la S en mayuscula para indicar que son parte de la libreria
/// Se debe crear una instacnia del singletton de controller para usarlo despues.
class SController{

  static final route = SRouter.getInstanceSRouter;
  static late HttpRequest _request;

  /// Esta funcion deberia ser singelston para que se registre en toda la aplicacion y nucna se peirda ele stado de la instancia
  /// Esta funcion se llama desde la funcion [started] de todas las clases controller que creemos
  static Future<void> registerEndpoints({required List<SRouterController> endPoints}) async{

    for (SRouterController endpoint in endPoints) {
      try{
        /// Se implementa la funcion [setRouter] desde router para guardar todos los metodos
        route.setRouter( _toRouterFormat(endpoint) );
        Logs.info(title: "Router", msm: "Routers added on globals routers");
      }catch(e){
        Logs.error(title: "ROUTER ERROR", msm: "Error when try to set router on global routers.");
      }


    }

  }

  /// Esta funcion abstrae nustros endpoint, patch y function
  /// para ser almacenados como clave valor y peudan ser llamados a solicitud del cliente
  static Map<String, Function> _toRouterFormat(SRouterController endPoint) => {
      '${endPoint.http}:/${ endPoint.literalPath ?? endPoint.pathList!.join("/")}': endPoint.function
    };

  static set request (HttpRequest request) => _request = request;

  static HttpRequest get request => _request;

  }

/// esta clase se usa al finalizar toda la aplicacion donde se pondran con un enum que debe ser.
/// Primero la palabra enum, luego el nombre de la clase, seigo de la palabra router.
/// [EnumUserRouter], cada clase en el controlador debe tener su propio enum que identifique sus endpoins

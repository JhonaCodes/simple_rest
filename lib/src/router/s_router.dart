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
import 'dart:io';

import 'package:simple_rest/src/utils/s_http_exception_handler.dart';

import '../controller/s_controller.dart';
import '../utils/s_logs.dart';

/// This class establishes the routes with the singleton pattern.
/// The routes can be obtained using [getRoute], but before that, it is necessary to -
/// instantiate [getInstanceSRouter] to obtain the singleton and use the routes throughout the application.
class SRouter{

  static SRouter? _router;
  final Map<String, Function> _routes = {};
  SRouter._();

  static SRouter get getInstanceSRouter{
    _router ??= SRouter._();
    return _router!;
  }


  Map<String, Function> get getRoute => _routes;

  /// This function is called exclusively from the controller to add the endpoints registered in the API's controller,
  /// abstracting the registration process from the [SController] class.
  void setRouter(Map<String, Function> endPoint) {
    _routes.addAll(endPoint);
  }

  /// Verifies which call the client makes and subscribes it to be displayed.
  /// This verification is made towards what we have stored in the callback.
  /// It calls the function from the key that contains the endpoint and the path.
  void route(HttpRequest request) async {

    var methodPath = '${request.method}:${request.uri.path}';

    if(request.uri.path != '/favicon.ico') Logs.debug(title: "REQUEST CLIENT",msm: methodPath);

    try{

      /// This callback function calls the function that contains the key-value pair [methodPath].
      var callback = getRoute[methodPath];

      /// It checks whether it is null or not to be executed later asynchronously.
      if (callback != null) {

        await callback();

      } else {

        /// In case it is null, the states are simply handled with a custom class [HttpExceptionHandler.exceptions].
        var response = request.response;

        await HttpExceptionHandler.exceptions(response: request).whenComplete(() async{
          await response.close();
          Logs.simpleDebug(title: "RESPONSE ACTION", msm: "Closing response");
        } );
      }

    }catch(e){
      /// In case the previous cases are not in the evaluation parameters, a default return message was established.
      request.response.headers.contentType = ContentType.json;
      request.response.write('{"response": "No operator matches the given name and argument types. You might need to add explicit type casts."}');
      await request.response.close();
      Logs.error(title: "Error", msm: e.toString());
    }

  }

}
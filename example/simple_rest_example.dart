import 'dart:convert';
import 'dart:io';

import '../bin/src/controller/s_controller.dart';
import '../bin/src/helpers/s_jwt_implementation.dart';
import '../bin/src/router/s_router_controller.dart';
import '../bin/src/server/s_server.dart';
import '../bin/src/utils/enviroment_data.dart';

import '../bin/src/services/s_http_methods.dart';

/// The [ClientRoute] mixin contains the literal paths for the client routes.
mixin ClientRoute {
  static const String base = 'client';
  static const String home = 'home';
  static const String fiesta = 'fiesta';
}

/// The [ClientController] class caontains the handlers for the client requests.
class ClientController {
  /// Handles the request for the 'casa' endpoint.
  static void handleCasa(HttpRequest request) async {
    var data = {'nombre': 'Mi Casa', 'direccion': '123 Calle Principal'};
    var jsonString = jsonEncode(data);
    var response = request.response;
    response.headers.contentType = ContentType.json;
    response.write(jsonString);
    await response.close();
  }

  /// Handles the request for the 'fiesta' endpoint.
  static void handleFiesta(HttpRequest request) async {
    var ridr = SServer.Srequest!.uri.queryParameters['id'];

    var data = {
      'nombre': 'Mi Casa',
      'direccion': '123 Calle Principal',
      'nommbre': 'Fernandinho',
      'idReques': ridr.toString()
    };
    var jsonString = jsonEncode(data);
    var response = request.response;
    response.headers.contentType = ContentType.json;
    response.write(jsonString);
    await response.close();
  }

  /// Initializes the client endpoints.
  static void init() {
    print(SEnviromentData.jwtSecretKey);

    SController.registerEndpoints(endPoints: [
      SRouterController(
        http: SHttpMethod.GET,
        literalPath: 'client/home/data',
        function: handleCasa,
      ),
      SRouterController(
        http: SHttpMethod.GET,
        literalPath: 'client/fiesta',
        function: handleFiesta,
      )
    ]);
  }
}

void main() async {

  /// Server config inicialization
  /// [SServer.envConfig], [SServer.customConfig], [SServer.defaultConfig]
  SServer server = SServer.envConfig();

  /// SImple example how to validate users with JWT
  if (SJwt.verifyUser(
      token: SJwt.generateJWT(
        mail: "JHonatan@gmail.com",
      ))['response']) {
    print("Usuario valido");
  }

  /// Example for stater server and endpoints
  await server.started([
    ClientController.init,
  ]);

}

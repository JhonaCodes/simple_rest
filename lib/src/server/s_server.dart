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

import 'package:simple_rest/src/controller/s_controller.dart';

import '../router/s_router.dart';
import '../utils/s_enviroment_data.dart';
import '../utils/s_logs.dart';

/// This class is responsible for initializing the server and registering the [init] functions of each [Controller] class.
/// This server takes data from 3 different sources: [envConfig], [customConfig], [defaultConfig].
/// To use [envConfig], you must create a file in the main root named [.env], notice that it must use the '.' before the name
/// as shown in the previous example.
class SServer{

  InternetAddress? ip;
  int? port;

  HttpServer? service;

  /// Imports the ENV configurations to start the server.
  SServer.envConfig(){
    ip = InternetAddress.tryParse(SEnviromentData.ipServer());
    port = SEnviromentData.portServer();
  }

  /// Uses the user's default settings.
  SServer.customConfig({required String ipServer, required int portServer}){
    ip   = InternetAddress.tryParse(ipServer);
    port = portServer;
  }

  SServer.defaultConfig(){
    ip   = InternetAddress.anyIPv4;
    port = int.parse(Platform.environment['PORT'] ?? '8080');
  }

  Future<void> started(List<Function> initialization) async {

    Logs.info(title: "ROUTES", msm: "Initializing Routes");

    /// Initialize our singleton so that we can read all the routes that are going to be implemented.
    var router = SRouter.getInstanceSRouter;

    /// Call all the functions that are in the server's init, which are usually [ClassController.init()]
    /// where all the routes will be registered in our singleton that is already initialized.
    for (var fun in initialization) {
      Logs.info(title: "SERVICES", msm: "Initializing Controllers");
      fun();
    }

    try {
      /// Instantiate our server with a default IP and port.
      service = await HttpServer.bind(ip, port!);

      /// Initialize our server by reading the requests from the clients. They will already have all our services registered.
      service!.listen((HttpRequest request) {
        SController.request = request;
        router.route(request);
      });

      Logs.debug(title: "SERVER STATUS", msm: "Server Started on ${service!.port}");

    } on SocketException catch (e) {
      Logs.error(title: "SERVER STATUS", msm: "SocketException occurred: $e");
    } on Exception catch (e) {
      Logs.error(title: "SERVER STATUS", msm: "Exception occurred: $e");
    } catch (e) {
      Logs.error(title: "SERVER STATUS", msm: "Unknown error occurred: $e");
    }
  }
}
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

import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_router/shelf_router.dart';

import 'package:simple_rest/src/router/s_router.dart';
import 'package:simple_rest/src/router/s_router_handler.dart';
import 'package:shelf/shelf.dart';
import 'dart:io';

class SServer {
  void start(
      {required int port,
      required bool isRouterControlActive,
      Object? ip,
      required Router app,
      required List<dynamic> controllerList,
      List<String>? allowRoutersList}) {
    /// Scan and register controllers
    SRouter.scanAndRegisterRoutesController(app, controllerList);

    /// This is Optionally for secure route
    SRouterHandler routerHandler = SRouterHandler();
    if (allowRoutersList != null) routerHandler.allowedPaths = allowRoutersList;

    /// Create a Shelf handler from the router
    final handler = const Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(routerHandler.allowedRequestsMiddleware)

        /// Add a midleware personalized
        .addMiddleware(corsHeaders())
        .addHandler(app);

    /// Simple way for server handler
    final handlerSimple =
        const Pipeline().addMiddleware(logRequests()).addHandler(app);

    /// Start the server
    shelf_io
        .serve(isRouterControlActive ? handler : handlerSimple,
            ip ?? InternetAddress.anyIPv4, port)
        .then((server) {
      print('Server running on ${server.address}:${server.port}');
    });
  }
}

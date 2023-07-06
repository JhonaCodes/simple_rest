import 'dart:io';

import 'package:shelf/shelf.dart';

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



/// This class is used to register permitted routes.
class SRouterHandler{

  List<String> allowedPaths = [];

  Handler allowedRequestsMiddleware(Handler innerHandler) {

    return (request) async {
      /// Verify if the route is on the list.
      if (!allowedPaths.contains(request.url.pathSegments[0])) {
        return Response(HttpStatus.forbidden, body: 'Access denied');
      }
      /// send the request to the next step for the canalization.
      return await innerHandler(request);
    };
  }
}
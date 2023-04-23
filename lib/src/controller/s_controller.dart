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

import 'package:simple_rest/simple_rest.dart';

/// From this [SController] controller, we call the [SRouter] singleton to add routes.
/// Routes are added using the [registerEndpoints] function.
/// The parameters that the [registerEndpoints] function receives is a list of type [SRouterController].
class SController{

  static final route = SRouter.getInstanceSRouter;
  static late HttpRequest _request;

  static Future<void> registerEndpoints({required List<SRouterController> endPoints}) async{

    /// We iterate through the endpoints present in the list of type [SRouterController].
    for (SRouterController endpoint in endPoints) {
      try{
        /// We call the function [setRouter] to add the routes to our singleton [SRouter].
        route.setRouter( _toRouterFormat(endpoint) );
        Logs.info(title: "Router", msm: "Routers added on globals routers");
      }catch(e){
        Logs.error(title: "ROUTER ERROR", msm: "Error when try to set router on global routers.");
      }


    }

  }


  /// We use this function to establish the format in which our endpoints [endPoint] will be saved.
  /// These endpoints serve as key value pairs to identify the function that we need to call.
  static Map<String, Function> _toRouterFormat(SRouterController endPoint) => {
      '${endPoint.http}:/${ endPoint.literalPath ?? endPoint.pathList!.join("/")}': endPoint.function
    };

  /// To be able to listen to the state of the [request], we need to create [get] and [set] methods.
  /// This helps to keep track of the status of our requests and generate a response based on our query.
  static set request (HttpRequest request) => _request = request;
  static HttpRequest get request => _request;

  }

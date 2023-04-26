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


import 'dart:convert';
import 'dart:io';

import 'package:simple_rest/simple_rest.dart';

/// From this [SController] controller, we call the [SRouter] singleton to add routes.
/// Routes are added using the [registerEndpoints] function.
/// The parameters that the [registerEndpoints] function receives is a list of type [SRouterController].
class SController{

  static final route = SRouter.getInstanceSRouter;
  static late HttpRequest request;

  static Future<void> subscribeData({List<Map<dynamic, dynamic>>? jsonDataList, Map<dynamic, dynamic>? jsonData}) async {
    var jsonString = jsonEncode(jsonDataList ?? jsonData);
    var response = request.response;
    response.headers.contentType = ContentType.json;
    response.write(jsonString);
    await response.close();
  }


  static Future<void> registerEndpoints({required List<SRouterController> endPoints}) async{

    /// We iterate through the endpoints present in the list of type [SRouterController].
    for (SRouterController endpoint in endPoints) {
      try{
        /// We call the function [setRouter] to add the routes to our singleton [SRouter].
        route.setRouter( _toRouterFormat(endpoint) );
      }catch(e){
        Logs.error(title: "ROUTER ERROR", msm: "Error when try to set router on global routers.");
      }


    }

    Logs.info(title: "ENDPOINTS", msm: route.getRoute.keys.join("\n"));
    Logs.info(title: "ENDPOINTS ON FUNCTIONS", msm: route.getRoute);

  }


  /// We use this function to establish the format in which our endpoints [endPoint] will be saved.
  /// These endpoints serve as key value pairs to identify the function that we need to call.
  static Map<String, Function> _toRouterFormat(SRouterController endPoint) => {
      '${endPoint.http}:/${ endPoint.literalPath ?? endPoint.pathList!.join("/")}': endPoint.function
    };


  }

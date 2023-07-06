import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';


import 'package:simple_rest/src/annotations/annotations.dart';
import 'package:simple_rest/src/router/s_router.dart';
import 'package:simple_rest/src/router/s_router_handler.dart';


@RestController('/school')
class SchoolController {

  Map<String, dynamic> printSchoolId() {
    return {'name': 'Jhonatan'};
  }

  @GetMapping(path: '/id/<number>', methodName: #printSchoolIdWithNumber)
  Map<String, dynamic> printSchoolIdWithNumber(@PathVariable('number') dynamic number) {
    return {'name': 'Jhonatan', 'number': number};
  }

  @GetMapping(path: '/apellido/<ape>', methodName: #printSchoolIdWithName2)
  Map<String, dynamic> printSchoolIdWithName2(@PathVariable('ape') dynamic name) {
    return {'address': 'J 23 Remuerandia', 'apellido': name};
  }

  @GetMapping(path: '/name/<name>', methodName: #printSchoolIdWithName)
  Map<String, dynamic> printSchoolIdWithName(@PathVariable('name') dynamic name) {
    return {'address': 'J 23 Remuerandia', 'school': name};
  }

  @PostMapping(path: '/')
  List<Map<String, dynamic>> saveSchool(@BodyAttribute('body') dynamic bodyData) {
    Map<String, dynamic> moreInfo = {
      "School": "sanjose"
    };

    var dataSchool = jsonDecode(bodyData );
    return [
      moreInfo,
      dataSchool
    ];
  }


  @DeleteMapping(path: '/id/<id>')
  Map<String, dynamic> deleteSchool(@PathVariable('id') String id){

    List<String> dates = ['jhon','juan','pedro'];
    dates.remove(id);

    return {
      "names": dates
    };
  }

  @PatchMapping(path: '/')
  Map<String, dynamic> updateSchool(@BodyAttribute('body') dynamic body){
    var dataSchool = jsonDecode(body );
    return dataSchool;
  }


  @PutMapping(path: '/')
  Map<String, dynamic> updateSchoolComplete(@BodyAttribute('body') dynamic body){
    var dataSchool = jsonDecode(body );
    return dataSchool;
  }



}


void main() {

  final app = Router();

  /// Scan and register controllers
  SRouter.scanAndRegisterRoutesController(app, [
    SchoolController,
  ]);

  /// This is Optionally for secure route
  SRouterHandler routerHandler = SRouterHandler();
  routerHandler.allowedPaths = ['school'];

  /// Create a Shelf handler from the router
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(routerHandler.allowedRequestsMiddleware)  /// Add a midleware personalized
      .addMiddleware(corsHeaders())
      .addHandler(app);


  /// Simple way for server handler
  final handlerSimple = const Pipeline().addMiddleware(logRequests()).addHandler(app);


  /// Start the server
  shelf_io.serve(handler, InternetAddress.anyIPv4, 8080).then((server) {
    print('Server running on ${server.address}:${server.port}');
  });


}



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

import 'dart:convert';
import 'dart:mirrors';
import 'package:shelf/shelf.dart';

import 'package:shelf_router/shelf_router.dart';

import 'package:simple_rest/src/annotations/annotations.dart';

/// This class establishes the routes for your API.
class SRouter {
  static void scanAndRegisterRoutesController(Router app, List controllers) {
    Map<String, String> header = {'content-type': 'application/json'};

    for (var controllerType in controllers) {
      var controllerMirror = reflectClass(controllerType);
      var controllerMetadata = controllerMirror.metadata.first.reflectee;

      var methods =
          controllerMirror.instanceMembers.values.whereType<MethodMirror>();
      for (var method in methods) {
        for (var metadata in method.metadata) {
          switch (metadata.reflectee.runtimeType) {
            case GetMapping:
              var methodMetadata = metadata.reflectee;
              var methodPath = methodMetadata.path;
              var methodName = method.simpleName;
              var fullPath = '${controllerMetadata.path}$methodPath';
              app.get(fullPath, (Request request) {
                var instanceMirror =
                    controllerMirror.newInstance(const Symbol(''), [request]);
                var arguments = _extractArguments(method, request);
                var result = instanceMirror.invoke(methodName, arguments);
                var jsonResponse = jsonEncode(result.reflectee);
                return Response.ok(jsonResponse, headers: header);
              });
              break;
            case PostMapping:
              var methodMetadata = metadata.reflectee;
              var methodPath = methodMetadata.path;
              var methodName = method.simpleName;
              var fullPath = '${controllerMetadata.path}$methodPath';
              app.post(fullPath, (Request request) async {
                var bodyData = await request.readAsString();
                var instanceMirror =
                    controllerMirror.newInstance(const Symbol(''), [request]);
                var arguments = [bodyData];
                var result = instanceMirror.invoke(methodName, arguments);
                var jsonResponse = jsonEncode(result.reflectee);
                return Response.ok(jsonResponse, headers: header);
              });
              break;
            case PutMapping:
              var methodMetadata = metadata.reflectee;
              var methodPath = methodMetadata.path;
              var methodName = method.simpleName;
              var fullPath = '${controllerMetadata.path}$methodPath';
              app.put(fullPath, (Request request) async {
                var bodyData = await request.readAsString();
                var instanceMirror =
                    controllerMirror.newInstance(const Symbol(''), [request]);
                var arguments = [bodyData];
                var result = instanceMirror.invoke(methodName, arguments);
                var jsonResponse = jsonEncode(result.reflectee);
                return Response.ok(jsonResponse, headers: header);
              });
              break;
            case PatchMapping:
              var methodMetadata = metadata.reflectee;
              var methodPath = methodMetadata.path;
              var methodName = method.simpleName;
              var fullPath = '${controllerMetadata.path}$methodPath';
              app.patch(fullPath, (Request request) async {
                var bodyData = await request.readAsString();
                var instanceMirror =
                    controllerMirror.newInstance(const Symbol(''), [request]);
                var arguments = [bodyData];
                var result = instanceMirror.invoke(methodName, arguments);
                var jsonResponse = jsonEncode(result.reflectee);
                return Response.ok(jsonResponse, headers: header);
              });
              break;
            case DeleteMapping:
              var methodMetadata = metadata.reflectee;
              var methodPath = methodMetadata.path;
              var methodName = method.simpleName;
              var fullPath = '${controllerMetadata.path}$methodPath';
              app.delete(fullPath, (Request request) {
                var instanceMirror =
                    controllerMirror.newInstance(const Symbol(''), [request]);
                var arguments = _extractArguments(method, request);
                var result = instanceMirror.invoke(methodName, arguments);
                var jsonResponse = jsonEncode(result.reflectee);
                return Response.ok(jsonResponse, headers: header);
              });
              break;
          }
        }
      }
    }
  }

  static List<dynamic> _extractArguments(MethodMirror method, Request request) {
    var arguments = <dynamic>[];

    for (var parameter in method.parameters) {
      if (parameter.metadata
          .any((metadata) => metadata.reflectee.runtimeType == PathVariable)) {
        var paramName = parameter.metadata
            .firstWhere(
                (metadata) => metadata.reflectee.runtimeType == PathVariable)
            .reflectee
            .name;
        var paramValue = _getPathParameter(request, paramName);
        arguments.add(paramValue);
      } else if (parameter.metadata
          .any((metadata) => metadata.reflectee.runtimeType == BodyAttribute)) {
        var paramName = parameter.metadata
            .firstWhere(
                (metadata) => metadata.reflectee.runtimeType == BodyAttribute)
            .reflectee
            .key;
        var paramValue = _getBodyParameter(request, paramName);
        arguments.add(paramValue);
      } else if (parameter.type.reflectedType == Request) {
        arguments.add(request);
      }
    }

    return arguments;
  }

  /// Take a parameter
  static dynamic _getPathParameter(Request request, dynamic paramName) {
    var segments = request.url.pathSegments;
    var value = segments.last;
    return value;
  }

  /// Take body parameters special for [POST] [PUT] [PATCH] methods.
  static dynamic _getBodyParameter(Request request, dynamic paramName) {
    var body = request.params;
    var parsedBody = jsonDecode(body.toString());
    return parsedBody[paramName];
  }
}

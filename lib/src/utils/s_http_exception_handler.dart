import 'dart:io';

import 'package:simple_rest/simple_rest.dart';

class HttpExceptionHandler{

  static String _textError = '';

  static Future<void> exceptions({required HttpRequest response})async {
    Map<int, Function> statusResponse = {
      HttpStatus.notFound: () => _logPrintError("Continue"),
      HttpStatus.continue_: () => _logPrint("Continue"),
      HttpStatus.switchingProtocols: () => _logPrint("Switching Protocols"),
      HttpStatus.processing: () => _logPrint("Processing"),
      HttpStatus.ok: () => _logPrintError("Possible error on request"),
      HttpStatus.created: () => _logPrint("Created"),
      HttpStatus.accepted: () => _logPrint("Accepted"),
      HttpStatus.noContent: () => _logPrintError("No Content"),
      HttpStatus.nonAuthoritativeInformation: () =>
          _logPrintError("Non-Authoritative Information"),
      HttpStatus.resetContent: () => _logPrintError("Reset Content"),
      HttpStatus.partialContent: () => _logPrintError("Partial Content"),
      HttpStatus.multiStatus: () => _logPrintError("Multi-Status"),
      HttpStatus.alreadyReported: () => _logPrintError("Already Reported"),
      HttpStatus.imUsed: () => _logPrintError("IM Used"),
      HttpStatus.multipleChoices: () => _logPrintError("Multiple Choices"),
      HttpStatus.movedPermanently: () => _logPrintError("Moved Permanently"),
      HttpStatus.found: () => _logPrintError("Found"),
      HttpStatus.seeOther: () => _logPrintError("See Other"),
      HttpStatus.notModified: () => _logPrintError("Not Modified"),
      HttpStatus.useProxy: () => _logPrintError("Use Proxy"),
      HttpStatus.temporaryRedirect: () => _logPrintError("Temporary Redirect"),
      HttpStatus.permanentRedirect: () => _logPrintError("Permanent Redirect"),
      HttpStatus.badRequest: () => _logPrintError("Bad Request"),
      HttpStatus.unauthorized: () => _logPrintError("Unauthorized"),
      HttpStatus.paymentRequired: () => _logPrintError("Payment Required"),
      HttpStatus.forbidden: () => _logPrintError("Forbidden"),
      HttpStatus.methodNotAllowed: () => _logPrintError("Method Not Allowed"),
      HttpStatus.notAcceptable: () => _logPrintError("Not Acceptable"),
      HttpStatus.requestTimeout: () => _logPrintError("Request Timeout"),
      HttpStatus.conflict: () => _logPrintError("Conflict"),
      HttpStatus.gone: () => _logPrintError("Gone"),
      HttpStatus.lengthRequired: () => _logPrintError("Length Required"),
      HttpStatus.preconditionFailed: () =>
          _logPrintError("Precondition Failed"),
      HttpStatus.requestEntityTooLarge: () =>
          _logPrintError("Request Entity TooLarge"),
      HttpStatus.requestUriTooLong: () => _logPrintError("Request Uri TooLong"),
      HttpStatus.unsupportedMediaType: () =>
          _logPrintError("Unsupported Media Type"),
      HttpStatus.requestedRangeNotSatisfiable: () =>
          _logPrintError("Requested Range Not Satisfiable"),
      HttpStatus.expectationFailed: () => _logPrintError("Expectation Failed"),
      HttpStatus.misdirectedRequest: () =>
          _logPrintError("Misdirected Request"),
      HttpStatus.unprocessableEntity: () =>
          _logPrintError("Unprocessable Entity"),
      HttpStatus.locked: () => _logPrintError("Locked"),
      HttpStatus.failedDependency: () => _logPrintError("Failed Dependency"),
      HttpStatus.upgradeRequired: () => _logPrintError("Upgrade Required"),
      HttpStatus.preconditionRequired: () =>
          _logPrintError("Precondition Required"),
      HttpStatus.tooManyRequests: () => _logPrintError("Too Many Requests"),
      HttpStatus.requestHeaderFieldsTooLarge: () =>
          _logPrintError("Request Header Fields TooLarge"),
      HttpStatus.unavailableForLegalReasons: () =>
          _logPrintError("Unavailable For Legal Reasons"),
      HttpStatus.internalServerError: () =>
          _logPrintError("Internal Server Error"),
      HttpStatus.notImplemented: () => _logPrintError("Not Implemented"),
      HttpStatus.badGateway: () => _logPrintError("Bad Gateway"),
      HttpStatus.serviceUnavailable: () =>
          _logPrintError("Service Unavailable"),
      HttpStatus.gatewayTimeout: () => _logPrintError("Gateway Timeout"),
      HttpStatus.httpVersionNotSupported: () =>
          _logPrintError("Http Version NotSupported"),
      HttpStatus.variantAlsoNegotiates: () =>
          _logPrintError("Variant Also Negotiates"),
      HttpStatus.insufficientStorage: () =>
          _logPrintError("Insufficient Storage"),
      HttpStatus.loopDetected: () => _logPrintError("Loop Detected"),
      HttpStatus.notExtended: () => _logPrintError("Not Extended"),
      HttpStatus.networkAuthenticationRequired: () =>
          _logPrintError("Network Authentication Required"),
    };

    try {
      response.headers.contentType = ContentType.json;


      Function? reportLog = statusResponse[response.response.statusCode];
      reportLog!();

      response.response.write('{"response": "$_textError"}');

    } catch (e) {
      if (e is FormatException || e is HttpException) {
        Logs.error(title: "HTTP Status", msm: "Invalid URL: ${e.toString()}");
        response.response.statusCode = HttpStatus.badRequest;
        response.response.write('{"response": "The url you are using is incorrect, please check immediately."}');
      } else {
        Logs.error(title: "HTTP Status", msm: "Unknown error: $e");
        response.response.write('{"response": "Unknown error"}');
      }
    }
  }

 static void _logPrintError(String error){
   _textError = error;
    Logs.failure(title: "HTTP Status", msm: error);
  }
  static void _logPrint(String error){
    _textError = error;
    Logs.info(title: "HTTP Status", msm: error);
  }
}
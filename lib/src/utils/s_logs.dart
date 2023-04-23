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

import 'package:logger/logger.dart';

/// This class divide log response on 3 sections.
/// [Full Attributes]     => failure, warning, error, debug, info, verbose
/// [Simple Attributes]   => simple-xxx
/// [Response Attributes] => response-xxx
class Logs {

  Logs();

  final _logger = Logger(
    output: ConsoleOutput(),
    filter: ProductionFilter(),
    printer: PrettyPrinter(

      printEmojis: true,
      printTime: false,
      colors: true,
      noBoxingByDefault: false,
    ),
  );

  final _loggerNoStack = Logger(
    filter: ProductionFilter(),
    printer: PrettyPrinter(methodCount: 0),
  );


  final _loggerResponse = Logger(
    filter: ProductionFilter(),
    printer: PrettyPrinter(
      methodCount: 0,
      printTime: true,
      colors: true,
    ),
  );


  Logs.failure({required String title, required dynamic msm, StackTrace? stackTrace}){_logger.wtf(msm,title,stackTrace);}
  Logs.warning({required String title, required dynamic msm, StackTrace? stackTrace}){_logger.w(msm,title,stackTrace);}
  Logs.verbose({required String title, required dynamic msm, StackTrace? stackTrace}){_logger.v(msm,title,stackTrace);}
  Logs.error(  {required String title, required dynamic msm, StackTrace? stackTrace}){_logger.e(msm,title,stackTrace);}
  Logs.debug(  {required String title, required dynamic msm, StackTrace? stackTrace}){_logger.d(msm,title,stackTrace);}
  Logs.info(   {required String title, required dynamic msm, StackTrace? stackTrace}){_logger.i(msm,title,stackTrace);}

  Logs.simpleFailure({required String title, required dynamic msm, StackTrace? stackTrace}){_loggerNoStack.wtf(msm,title,stackTrace);}
  Logs.simpleWarning({required String title, required dynamic msm, StackTrace? stackTrace}){_loggerNoStack.w(msm,title,stackTrace);}
  Logs.simpleVerbose({required String title, required dynamic msm, StackTrace? stackTrace}){_loggerNoStack.v(msm,title,stackTrace);}
  Logs.simpleError(  {required String title, required dynamic msm, StackTrace? stackTrace}){_loggerNoStack.e(msm,title,stackTrace);}
  Logs.simpleDebug(  {required String title, required dynamic msm, StackTrace? stackTrace}){_loggerNoStack.d(msm,title,stackTrace);}
  Logs.simpleInfo(   {required String title, required dynamic msm, StackTrace? stackTrace}){_loggerNoStack.i(msm,title,stackTrace);}

  Logs.responseFailure({required String title, required dynamic msm, StackTrace? stackTrace}){_loggerNoStack.wtf(msm,title,stackTrace);}
  Logs.responseError(  {required String title, required dynamic msm, StackTrace? stackTrace}){_loggerResponse.e(msm,title,stackTrace);}
  Logs.response(       {required String title, required dynamic msm, StackTrace? stackTrace}){_loggerResponse.i(msm,title,stackTrace);}
  Logs.serverOn(       {required String title, required dynamic msm, StackTrace? stackTrace}){_loggerResponse.d(msm,title,stackTrace);}



}
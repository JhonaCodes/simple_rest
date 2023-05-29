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



/// This class is used to register all the routes within our [init] function,
/// which must be present in all classes of type [controller].
class SRouterController{

  final String http;
  final List<String>? pathList;
  final String? literalPath;
  final Function function;

  /// The main purpose of this class is to establish the type of request with [http].
  /// These values must be used from the [SHttpMethod] mixin, and the list of string type [pathList]
  /// is responsible for defining the query routes that will be enabled in our API, such as [user, bank, login].
  /// In the end, an endpoint would look like [user/bank/login].
  /// If you do not want to use a path as a list, you can enter it in a customized way using the [literalPath] variable.
  /// Finally, the function containing the controller class must be established, which will be called using the combination of
  /// [http] and [pathList] or [literalPath] as a key-value pair. This way, each function would be assigned to a type of request [GET, POST, PUT, ETC].
  /// When this key-value is called, the specific function is called. This method is very efficient as it represents no more than a <key, value> type.
  const SRouterController({required this.http, this.pathList, this.literalPath,required this.function});
}
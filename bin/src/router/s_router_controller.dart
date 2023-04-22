class SRouterController{

  final String http;
  final List<String>? pathList;
  final String? literalPath;
  final Function function;

  const SRouterController({required this.http, this.pathList, this.literalPath,required this.function});
}
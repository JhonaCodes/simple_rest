import 'dart:io';

class SFileUploader {


  static void uploadFIle() async {
    var request = await HttpClient().postUrl(
        Uri.parse('http://example.com/upload'));
    var file = File('/Users/jhonatanortiz/Downloads/valores.txt');
    var fileContent = await file.readAsBytes();

    var boundary = '----${DateTime
        .now()
        .millisecondsSinceEpoch}';

    request.headers.contentType = ContentType(
        'multipart', 'form-data', parameters: {'boundary': boundary});

    request.write('--$boundary\r\n');
    request.write('Content-Disposition: form-data; name="file"; filename="example.txt"\r\n');
    request.write('Content-Type: text/plain\r\n');
    request.write('\r\n');
    request.add(fileContent);
    request.write('\r\n');
    request.write('--$boundary--\r\n');

    var response = await request.close();

    // Convierte un Stream<List<int>> en una lista de bytes
    Future<List<int>> streamBytes(Stream<List<int>> stream) async {
      var bytes = <int>[];
      await for (var chunk in stream) {
        bytes.addAll(chunk);
      }
      return bytes;
    }
  }











}



class SFileUploadException implements Exception {
  final String message;

  SFileUploadException(this.message);
}

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
import 'dart:math';
import 'dart:typed_data';

/// "This class helps to create a key or secret to handle our JWT.
/// This JWT key must go in our [.env] file 'OF THE LIBRARY NOT YOUR PROJECT.'
/// Example [JWT_SECRET_KEY=QvnVrZ1YOXNsiGrY6UMqKA==], without the '[]'.
/// To use this generator, simply call the [SSecretKey] class and invoke the [generate] method.
/// In the end, it would be something like [SSecretKey.generate()]."
class SSecretKey{

  static final _random = Random.secure();

  /// When using this function, a custom code is generated that must be used in the [.env] file.
  static void generate(){
    final values = List<int>.generate(32, (i) => _random.nextInt(256));

    final jwtKey = _hexToBytes(values);
    final Uint8List myByteList = Uint8List.fromList(jwtKey);
    final jwtKeyString = base64Url.encode(myByteList);
    print("###################");
    print("### SECRET KEY ####");
    print("###################");
    print(jwtKeyString.replaceAll("=", ""));
    print("###################");
  }

  static List<int> _hexToBytes(List<int> hex) {
    final bytes = <int>[];
    for (int i = 0; i < hex.length; i += 2) {
      final byte = int.parse('${hex[i].toRadixString(16)}${hex[i+1].toRadixString(16)}', radix: 16);
      bytes.add(byte);
    }
    return bytes;
  }


}

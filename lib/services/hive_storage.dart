// Flutter Packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

// (https://pub.dev/packages/flutter_secure_storage)
// A Flutter plugin to store data in secure storage:
// -Keychain is used for iOS
// -AES encryption is used for Android. AES secret key is encrypted with RSA and RSA key is stored in KeyStore

class HiveStorage {
  final hiveBox = Hive.lazyBox("dollars_box");

  Future<bool> save(String key, String value) async {
    try {
      await hiveBox.put(key, value);

      return true;
    } catch (error) {
      return false;
    }
  }

  Future<String?> read(String key) async {
    return await hiveBox.get(key);
  }

  void deleteKey(String key) async {
    hiveBox.delete(key);
  }
}

final hiveStorageProvider = Provider<HiveStorage>((ref) => HiveStorage());

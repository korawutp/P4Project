import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

Future<void> saveEncryptedRemoteID(String remoteID) async {
  final key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  final encrypted = encrypter.encrypt(remoteID, iv: iv);

  // ที่นี่เราใช้ 'encrypted.base64' เป็นข้อมูลที่จะบันทึก
  await FirebaseFirestore.instance.collection('devices').doc('device_id').set({
    'remoteID': encrypted.base64,
  });
}

Future<bool> verifyRemoteID(String documentID, String originalRemoteID) async {
  final key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  final docSnapshot = await FirebaseFirestore.instance.collection('devices').doc(documentID).get();
  if (docSnapshot.exists) {
    final encryptedRemoteID = docSnapshot.data()!['remoteID'];
    final decryptedRemoteID = encrypter.decrypt(encrypt.Encrypted.fromBase64(encryptedRemoteID), iv: iv);

    return decryptedRemoteID == originalRemoteID;
  }
  return false;
}

// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart' as fStorage;

// import 'package:image_picker/image_picker.dart';

// class MediaUploadHelper {
//   static Future<String> uploadProfileImage(XFile image) async {
//     String downloadUrlImage = '';
//     //1.upload image to storage
//     String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//     fStorage.Reference storageRef = fStorage.FirebaseStorage.instance
//         .ref()
//         .child("profile-picture")
//         .child(fileName);

//     fStorage.UploadTask uploadImageTask = storageRef.putFile(File(image.path));

//     fStorage.TaskSnapshot taskSnapshot =
//         await uploadImageTask.whenComplete(() {});

//     await taskSnapshot.ref.getDownloadURL().then((urlImage) {
//       downloadUrlImage = urlImage;
//     });
//     return downloadUrlImage;
//   }
// }

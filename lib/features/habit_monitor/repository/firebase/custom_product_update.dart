import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CustomProductService {
  static Future<String> uploadImage(String path, XFile image) async {
    try {
      final storageRef = FirebaseStorage.instance.ref(path).child(image.name);
      await storageRef.putFile(File(image.path));
      final url = await storageRef.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw '${e.message}';
    } on FormatException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw '${e.message}';
    }
  }

  static Future<void> updateDoc({
    required String id,
    required String? url,
    required String productName,
    required String servingSize,
    required String category,
    required double carb,
    required double protien,
    required double fat,
    required double kcal,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(id).update({
      'customProducts': {
        'imgUrl': url,
        'productName': productName,
        'servingSized': servingSize,
        'carbs': carb,
        'protien': protien,
        'fat': fat,
        'kcal': kcal,
        'category': category,
      }
    });
  }

  static Future<void> updateFoodList({
    required String id,
    required String? url,
    required String productName,
    required String servingSize,
    required String category,
    required double carb,
    required double protien,
    required double fat,
    required double kcal,
  }) async {
    await FirebaseFirestore.instance.collection('food_collection').add({
      'imgUrl': url,
      'productName': productName,
      'servingSized': servingSize,
      'carbs': carb,
      'protien': protien,
      'fat': fat,
      'kcal': kcal,
      'category': category,
    });
  }

  static Future<List<Map<String, dynamic>>> getProducts() async {
    final snap =
        await FirebaseFirestore.instance.collection('food_collection').get();
    final data = snap.docs.map((doc) => doc.data()).toList();
    return data;
  }
}

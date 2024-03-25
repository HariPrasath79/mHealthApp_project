import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_cdm/features/authentication/components/submit_button.dart';
import 'package:project_cdm/features/authentication/components/text_field.dart';

class NewProductPage extends StatefulWidget {
  const NewProductPage({super.key});

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final _productNameController = TextEditingController();
  final _servingSizeController = TextEditingController();
  final _protienController = TextEditingController();
  final _kcalController = TextEditingController();
  final _fatController = TextEditingController();
  final _carbController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  File? imageUrl;
  XFile? pickedFile;

  String? category;
  final items = ['General', 'To avoid', 'Healthy'];
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );

  Future pickImage() async {
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageUrl = File(pickedFile!.path);
      });
    }
  }

  Future<String> uploadImage(String path, XFile image) async {
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

  @override
  void dispose() {
    // TODO: implement dispose
    _carbController.dispose();
    _fatController.dispose();
    _kcalController.dispose();
    _productNameController.dispose();
    _protienController.dispose();
    _servingSizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(CupertinoIcons.xmark)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.height * 0.2,
                        child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            // child: Image(
                            //   image: NetworkImage(
                            //       'https://images.unsplash.com/photo-1536304993881-ff6e9eefa2a6?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                            //   fit: BoxFit.cover,
                            // ),
                            child: imageUrl != null
                                ? Image.file(
                                    imageUrl!,
                                    fit: BoxFit.cover,
                                  )
                                : const Image(
                                    image: NetworkImage(
                                        'https://cdn.iconscout.com/icon/premium/png-256-thumb/no-image-1753539-1493784.png'))),
                      ),
                      MaterialButton(
                        onPressed: pickImage,
                        color: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text("Choose from galery"),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                InputTextFieldComponent(
                  controller: _productNameController,
                  hint: 'Product Name',
                  labeltext: 'Product Name',
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Field Required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                InputTextFieldComponent(
                  controller: _servingSizeController,
                  hint: 'Per serving size (g)',
                  labeltext: 'Per serving size (g)',
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Field Required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text('Macro-nutrients per serving (g)'),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: InputTextFieldComponent(
                        inputType: TextInputType.number,
                        controller: _carbController,
                        hint: 'Carbs (g)',
                        labeltext: 'Carbs (g)',
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Field Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InputTextFieldComponent(
                        inputType: TextInputType.number,
                        controller: _fatController,
                        hint: 'Fat (g)',
                        labeltext: 'Fat (g)',
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Field Required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: InputTextFieldComponent(
                        inputType: TextInputType.number,
                        controller: _protienController,
                        hint: 'Protien (g)',
                        labeltext: 'Protien (g)',
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Field Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InputTextFieldComponent(
                        inputType: TextInputType.number,
                        controller: _kcalController,
                        hint: 'Calories (Kcal)',
                        labeltext: 'Calories (Kcal)',
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Field Required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black54)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        value: category,
                        items: items.map(buildMenuItem).toList(),
                        hint: const Text('Select category'),
                        isExpanded: true,
                        onChanged: (val) {
                          setState(() {
                            category = val;
                          });
                        }),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: double.maxFinite,
                    child: SubmitButtonComponent(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // final id = FirebaseAuth.instance.currentUser!.uid;
                          const String id = 'LEjG7hXqcDfK1eOjgqgL3gJ2ZX12';

                          if (pickedFile != null) {
                            final url = await uploadImage('', pickedFile!);
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(id)
                                .update({
                              'customProducts': {
                                'imgUrl': url,
                                'productName':
                                    _productNameController.text.trim(),
                                'servingSized':
                                    _servingSizeController.text.trim(),
                                'carbs': _carbController.text.trim(),
                                'protien': _protienController.text.trim(),
                                'fat': _fatController.text.trim(),
                                'kcal': _kcalController.text.trim(),
                                'category': category,
                              }
                            });
                          } else {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(id)
                                .update({
                              'customProducts': FieldValue.arrayUnion([
                                {
                                  'imgUrl': null,
                                  'productName':
                                      _productNameController.text.trim(),
                                  'servingSized':
                                      _servingSizeController.text.trim(),
                                  'carbs': _carbController.text.trim(),
                                  'protien': _protienController.text.trim(),
                                  'fat': _fatController.text.trim(),
                                  'kcal': _kcalController.text.trim(),
                                  'category': category,
                                }
                              ]),
                            });
                          }
                          _carbController.clear();
                          _fatController.clear();
                          _kcalController.clear();
                          _productNameController.clear();
                          _protienController.clear();
                          _servingSizeController.clear();
                        }
                      },
                    )),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

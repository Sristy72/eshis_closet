// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:eshis_closet/models/category.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as p;
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:uuid/uuid.dart';
//
// import '../data/categories.dart';
// import '../models/new_dress_model.dart';
//
//
// class AddNewDress extends StatefulWidget {
//   const AddNewDress({super.key, required this.category});
//
//   final Category category;
//
//   @override
//   State<AddNewDress> createState() => _AddNewDressState();
// }
//
// class _AddNewDressState extends State<AddNewDress> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _titleTEController = TextEditingController();
//   final TextEditingController _priceTEController = TextEditingController();
//   File? _pickedImage;
//   var _selectedCategory = Categories.khut_shari;
//   DateTime? _selectedDate;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Color(0xff5baf92),title: Text('Add New ${widget.category.title}')),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 GestureDetector(
//                   onTap: _pickImage,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(width: 1, color: Colors.black),
//                     ),
//                     height: 250,
//                     width: double.infinity,
//                     child: Center(
//                       child: _pickedImage != null
//                           ? Image.file(
//                         _pickedImage!,
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                         height: double.infinity,
//                       ) : Text('No image selected'),
//                     )
//                   ),
//                 ),
//
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: _titleTEController,
//                         decoration: InputDecoration(labelText: 'Enter title'),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter title';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//
//                     SizedBox(width: 15),
//
//                     Expanded(
//                       child: TextFormField(
//                         controller: _priceTEController,
//                         decoration: InputDecoration(labelText: 'Enter price'),
//
//                         validator: (value) {
//                           if (value == null ||
//                               value.isEmpty ||
//                               int.tryParse(value) == null ||
//                               int.tryParse(value)! <= 0) {
//                             return 'Please enter price';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 Row(
//                   children: [
//                     Expanded(child: Padding(
//                       padding: const EdgeInsets.only(top: 10),
//                       child: Column(
//                         children: [
//                           Text(_selectedDate == null
//                               ? 'No date selected'
//                               : formatter.format(_selectedDate!),),
//
//                           IconButton(onPressed: (){
//                             _presentDatePicker();
//                           }, icon: Icon(Icons.calendar_month))
//                         ],
//                       ),
//                     )),
//
//                     SizedBox(width: 15),
//
//                     Expanded(
//                       child: DropdownButtonFormField(
//                         value: _selectedCategory,
//                         items: [
//                           for (final category in Categories.values)
//                             DropdownMenuItem(
//                               value: category,
//                               child: Text(category.name),
//                             ),
//                         ],
//                         onChanged: (value) {
//                           setState(() {
//                             _selectedCategory = value!;
//                           });
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: 15),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     ElevatedButton(onPressed: () {}, child: Text('Reset')),
//
//                     SizedBox(width: 15),
//                     ElevatedButton(onPressed: () {_saveNewItem();}, child: Text('Save Item')),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
//   Future _pickImage() async {
//     final imagePicker = ImagePicker();
//     final pickedFile = await imagePicker.pickImage(
//       source: ImageSource.gallery,
//         //maxWidth: 600
//       //imageQuality: 75,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         _pickedImage = File(pickedFile.path);
//       });
//     }
//   }
//
//   _presentDatePicker() async {
//     final now = DateTime.now();
//     final firstDate = DateTime(now.year - 1, now.month, now.day);
//     final pickedDate = await showDatePicker(
//         context: context, firstDate: firstDate, lastDate: now);
//
//     setState(() {
//       _selectedDate = pickedDate;
//     });
//   }
//
//
//   Future<String> _uploadImageToSupabase(File image) async{
//     final bucket = Supabase.instance.client.storage.from('images');
//     final filename = '${const Uuid().v4()}${p.extension(image.path)}';
//     await bucket.upload(filename, image);
//     final publicUrl = bucket.getPublicUrl(filename);
//     return publicUrl;
//   }
//
//
//   Future _saveNewItem() async{
//     if (_formKey.currentState!.validate()) {
//       final title = _titleTEController.text;
//       final price = int.parse(_priceTEController.text);
//       final category = _selectedCategory;
//
//       if (_pickedImage == null || title.trim().isEmpty || price <= 0 || _selectedDate == null) {
//         return ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please fill all fields'))
//         );
//       }
//
//       try{
//         final imageUrl = await _uploadImageToSupabase(_pickedImage!);
//         await FirebaseFirestore.instance.collection('dresses').add(
//           {
//             'title': title,
//             'price': price,
//             'category': category.name,
//             'imageUrl': imageUrl,
//             'date': _selectedDate,
//             'createdAt': Timestamp.now(),
//           }
//         );
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Dress saved successfully'))
//         );
//         Navigator.pop(context);
//       }catch(e){
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: $e')),
//         );
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _titleTEController.dispose();
//     _priceTEController.dispose();
//   }
// }

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshis_closet/models/category.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../models/new_dress_model.dart';

class AddNewDress extends StatefulWidget {
  const AddNewDress({super.key, required this.category});

  final Category category;

  @override
  State<AddNewDress> createState() => _AddNewDressState();
}

class _AddNewDressState extends State<AddNewDress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  File? _pickedImage;
  DateTime? _selectedDate;
  bool _isSending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5baf92),
        title: Text('Add New ${widget.category.title}'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                    height: 250,
                    width: double.infinity,
                    child: Center(
                      child:
                          _pickedImage != null
                              ? Image.file(
                                _pickedImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              )
                              : Text('No image selected'),
                    ),
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _titleTEController,
                        decoration: InputDecoration(labelText: 'Enter title'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter title';
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(width: 15),

                    Expanded(
                      child: TextFormField(
                        controller: _priceTEController,
                        decoration: InputDecoration(labelText: 'Enter price'),

                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return 'Please enter price';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date selected'
                                  : formatter.format(_selectedDate!),
                            ),

                            IconButton(
                              onPressed: () {
                                _presentDatePicker();
                              },
                              icon: Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(width: 15),

                    Expanded(
                      child: Container(
                        child: Text('Category: ${widget.category.title}'),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _isSending ? null : () {
                        _reset();
                      },
                      child: Text('Reset'),
                    ),
                    ElevatedButton(
                      onPressed: _isSending ? null : () {
                        _saveNewItem();
                      },
                      child: _isSending ? SizedBox(height:16, width: 16, child: CircularProgressIndicator()) : Text('Add item'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      //maxWidth: 600
      //imageQuality: 75,
    );
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  _uploadImageToSupabase(File image) async {
    final bucket = Supabase.instance.client.storage.from('images');
    final filename = '${const Uuid().v4()}${p.extension(image.path)}';
    await bucket.upload(filename, image);
    final publicUrl = bucket.getPublicUrl(filename);
    return publicUrl;
  }

  Future _saveNewItem() async {
    if (_formKey.currentState!.validate()) {
      final title = _titleTEController.text;
      final price = int.parse(_priceTEController.text);
      final category = widget.category.title;

      setState(() {
        _isSending = true;
      });

      if (_pickedImage == null ||
          title.trim().isEmpty ||
          price <= 0 ||
          _selectedDate == null) {
        return ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Please fill all fields')));
      }

      try {
        final imageUrl = await _uploadImageToSupabase(_pickedImage!);
        await FirebaseFirestore.instance.collection('dresses').add({
          'title': title,
          'price': price,
          'category': category,
          'imageUrl': imageUrl,
          'date': _selectedDate,
          'createdAt': Timestamp.now(),
        });
        setState(() {
          _isSending = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Dress saved successfully')));
          Navigator.pop(context);
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  _reset(){
    _formKey.currentState?.reset();
    setState(() {

    });
    _pickedImage = null;
    _selectedDate = null;
    _titleTEController.clear();
    _priceTEController.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleTEController.dispose();
    _priceTEController.dispose();
  }
}

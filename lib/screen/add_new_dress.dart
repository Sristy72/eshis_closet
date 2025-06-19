import 'dart:io';

import 'package:eshis_closet/models/category.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../data/categories.dart';

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
  var _selectedCategory = availableCategories[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New ${widget.category.title}')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _titleTEController,
                      decoration: InputDecoration(
                        labelText: 'Enter title',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                    ),
                  ),

                  SizedBox(width: 15,),

                  Expanded(
                    child: TextFormField(
                      controller: _priceTEController,
                      decoration: InputDecoration(
                        labelText: 'Enter price',
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty || int.tryParse(
                            value) == null ||
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
                  Expanded(child: Column(
                    children: [
                      _pickedImage != null ? Image.file(_pickedImage!, height: 150,) : Text('No image selected'),

                      TextButton.icon(onPressed: () {},
                          icon: Icon(Icons.image),
                          label: Text('Pick Image')),
                    ],
                  )),

                  SizedBox(width: 15,),

                  Expanded(
                    child: DropdownButtonFormField(
                        value: _selectedCategory, items: [
                      for(final category in availableCategories)
                        DropdownMenuItem(value: category, child: Text(category
                            .title))
                    ], onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    }),
                  )
                ],
              ),


              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(onPressed: () {}, child: Text('Reset')),

                  SizedBox(width: 15,),
                  ElevatedButton(onPressed: () {}, child: Text('Save Item'))
                ],
              )

            ],
          ),
        ),

      ),
    );
  }

  _saveNewItem() {
    if(_formKey.currentState!.validate()){
      final title = _titleTEController.text;
      final price = int.parse(_priceTEController.text);
      final category = _selectedCategory;

      if(_pickedImage == null || title.trim().isEmpty || price <=0){
        return;
      }


    }
  }


  Future _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    if(pickedFile != null){
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
  }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleTEController.dispose();
    _priceTEController.dispose();
  }
}

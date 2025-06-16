import 'package:eshis_closet/models/category.dart';
import 'package:flutter/material.dart';

class AddNewDress extends StatefulWidget {
  const AddNewDress({super.key, required this.category});
  final Category category;

  @override
  State<AddNewDress> createState() => _AddNewDressState();
}

class _AddNewDressState extends State<AddNewDress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New ${widget.category.title}')),
      body: Center(child: Text('Add New Dress')),
    );
  }
}

import 'package:eshis_closet/screen/add_new_dress.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';

class KhutSaree extends StatefulWidget {
  const KhutSaree({super.key, required this.category});

  final Category category;

  @override
  State<KhutSaree> createState() => _KhutSareeState();
}

class _KhutSareeState extends State<KhutSaree> {
  _addNewDress(Category category) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => AddNewDress(category: category)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5baf92),
        title: Text(widget.category.title),
        actions: [
          IconButton(
            onPressed: () {
              _addNewDress(widget.category);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Center(child: Text('Short Kurti')),
    );
  }
}

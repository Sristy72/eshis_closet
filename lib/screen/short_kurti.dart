import 'package:eshis_closet/widget/fetch_dress_from_firebase.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';
import 'add_new_dress.dart';

class ShortKurti extends StatefulWidget {
  const ShortKurti({super.key, required this.category});
  final Category category;

  @override
  State<ShortKurti> createState() => _ShortKurtiState();
}

class _ShortKurtiState extends State<ShortKurti> {
  _addNewDress(Category category){
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => AddNewDress(category: category,)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff5baf92),title: Text(widget.category.title), actions: [
        IconButton(onPressed: (){_addNewDress(widget.category);}, icon: Icon(Icons.add))
      ],),
      body: fetch_dress_from_firebase(category: widget.category)
    );
  }
}




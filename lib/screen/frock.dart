import 'package:flutter/material.dart';
import '../models/category.dart';
import '../widget/fetch_dress_from_firebase.dart';
import 'add_new_dress.dart';

class Frock extends StatefulWidget {
  const Frock({super.key, required this.category});
  final Category category;

  @override
  State<Frock> createState() => _FrockState();
}

class _FrockState extends State<Frock> {
  _addNewDress(Category category){
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => AddNewDress(category: category)));
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

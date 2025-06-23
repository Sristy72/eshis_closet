// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:eshis_closet/screen/add_new_dress.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
// import '../models/category.dart';
//
// class KhutSaree extends StatefulWidget {
//   const KhutSaree({super.key, required this.category});
//
//   final Category category;
//
//   @override
//   State<KhutSaree> createState() => _KhutSareeState();
// }
//
// class _KhutSareeState extends State<KhutSaree> {
//   _addNewDress(Category category) {
//     Navigator.of(context).push(
//       MaterialPageRoute(builder: (ctx) => AddNewDress(category: category)),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xff5baf92),
//         title: Text(widget.category.title),
//         actions: [
//           IconButton(
//             onPressed: () {
//               _addNewDress(widget.category);
//             },
//             icon: Icon(Icons.add),
//           ),
//         ],
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('dresses')
//             .where('category', isEqualTo: widget.category) // Fix here
//             .orderBy('createdAt', descending: true)
//             .snapshots(),
//         builder: (ctx, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No dresses found in this category.'));
//           }
//
//           final dresses = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: dresses.length,
//             itemBuilder: (ctx, index) {
//               final dressInfo = dresses[index].data();
//               return ListTile(
//                 leading: Image.network(
//                   dressInfo['imageUrl'],
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.cover,
//                 ),
//                 title: Text(dressInfo['title']),
//                 subtitle: Text('${dressInfo['price']}'),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshis_closet/screen/add_new_dress.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';
import '../widget/dress_from_firebase.dart';
import '../widget/fetch_dress_from_firebase.dart';

class KhutSaree extends StatefulWidget {
  const KhutSaree({super.key, required this.category});

  final Category category;

  @override
  State<KhutSaree> createState() => _KhutSareeState();
}

class _KhutSareeState extends State<KhutSaree> {
  void _addNewDress(Category category) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => AddNewDress(category: category)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff5baf92),
        title: Text(widget.category.title),
        actions: [
          IconButton(
            onPressed: () => _addNewDress(widget.category),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: fetch_dress_from_firebase(category: widget.category,),
    );
  }
}





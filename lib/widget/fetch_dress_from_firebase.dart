import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshis_closet/models/category.dart';
import 'package:flutter/material.dart';
import 'dress_from_firebase.dart';

class fetch_dress_from_firebase extends StatelessWidget {
  const fetch_dress_from_firebase({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
              .collection('dresses')
              .where('category', isEqualTo: category.title)
              .orderBy('createdAt', descending: true)
              .snapshots(),

      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No dresses found in this category.'),
          );
        }

        final dresses = snapshot.data!.docs;

        return dress_from_firebase(dresses: dresses);
      },
    );
  }
}

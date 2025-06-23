import 'package:eshis_closet/models/category.dart';
import 'package:eshis_closet/screen/frock.dart';
import 'package:eshis_closet/screen/jeans.dart';
import 'package:eshis_closet/screen/short_kurti.dart';
import 'package:flutter/material.dart';

import '../data/categories.dart';
import 'khut_saree.dart';
import 'long_kurti.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  _moveToSpecificCategory(String title) {
    if(title == 'khut Shari'){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => KhutSaree(category: categories[Categories.khut_shari]!)));//access map element using key first use map name categories then its key [Categories.khut_shari]
    }
    else if(title == 'Short Kurti'){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ShortKurti(category: categories[Categories.Short_Kurti]!)));
    }
    else if(title == 'Long Kurti'){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => LongKurti(category: categories[Categories.Long_Kurti]!)));
    }
    else if(title == 'Round Frock'){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Frock(category: categories[Categories.Round_Frock]!)));
    }
    else{
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Jeans(category: categories[Categories.Jeans]!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Categories')),

      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),

        children: [
          for (final category in categories.entries)
            GestureDetector(
              onTap: () {
                _moveToSpecificCategory(category.value.title);
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                  child: Stack(
                    children: [
                      Image.asset(category.value.categoryImage, fit: BoxFit.cover, height: 200, width: 200,),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.black54,
                          child: Text(
                            category.value.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

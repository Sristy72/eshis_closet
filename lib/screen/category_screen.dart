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
    if(title == 'খুঁত এর শাড়ি'){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => KhutSaree(category: availableCategories[0],)));
    }
    else if(title == 'Short kurti'){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ShortKurti(category: availableCategories[1])));
    }
    else if(title == 'Long Kurti'){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => LongKurti(category: availableCategories[2],)));
    }
    else if(title == 'Round Frock'){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Frock(category: availableCategories[3],)));
    }
    else{
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Jeans(category: availableCategories[4],)));
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
          for (final category in availableCategories)
            GestureDetector(
              onTap: () {
                _moveToSpecificCategory(category.title);
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                  child: Stack(
                    children: [
                      Image.asset(category.Image, fit: BoxFit.cover, height: 200, width: 200,),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.black54,
                          child: Text(
                            category.title,
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DressDetailScreen extends StatelessWidget {
  const DressDetailScreen({super.key, required this.dressTitle, required this.dressPrice, required this.dressDate, required this.dressImage});

  final String dressTitle;
  final dynamic dressPrice;
  final String dressDate;
  final String dressImage;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff6a4866),
        title: Text(dressTitle, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(CupertinoIcons.arrow_left, color: Colors.white,))
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
              child: SizedBox(
                height: 325,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(dressImage),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 30,
                            color: Colors.grey.withOpacity(0.9),
                            spreadRadius: 5,
                            offset: Offset(0, 15)
                        )
                      ]
                  ),
                ),
              ),
            ),

            SizedBox(height: 14,),

            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Dress Price: ', style: TextStyle(color: Colors.black,  fontSize: 17),),
                      Text(dressPrice.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Date: ', style: TextStyle(color: Colors.black, fontSize: 17),),
                      Text(dressDate, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 14,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
                  child: Center(child: Text('Details', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),)),
                )
              ],
            )
          ],
        ),
      )
    );
  }
}

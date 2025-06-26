import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshis_closet/screen/dress_detail_screen.dart';
import 'package:flutter/material.dart';

class dress_from_firebase extends StatefulWidget {
   dress_from_firebase({super.key, required this.dresses});

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> dresses;

  @override
  State<dress_from_firebase> createState() => _dress_from_firebaseState();
}

class _dress_from_firebaseState extends State<dress_from_firebase> {
  @override
  Widget build(BuildContext context) {

    detailsScreen(dressInfo) {
      final String title = dressInfo['title'] ?? 'No Title';
      final price = dressInfo['price'] ?? 0;
      final imageUrl = dressInfo['imageUrl'] ?? '';
      final Timestamp? date = dressInfo['date'];
      final String formattedDate = date != null
          ? '${date.toDate().day}/${date.toDate().month}/${date.toDate().year}'
          : 'No Date';

      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (ctx) => DressDetailScreen(
            dressTitle: title,
            dressPrice: price,
            dressDate: formattedDate,
            dressImage: imageUrl,
          ),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.dresses.length,
            itemBuilder: (ctx, index) {
              final dressInfo = widget.dresses[index].data();
              final Timestamp? dateTimestamp = dressInfo['date'];
              final String formattedDate = dateTimestamp != null
                  ? '${dateTimestamp.toDate().day}/${dateTimestamp.toDate().month}/${dateTimestamp.toDate().year}'
                  : 'No Date';

              return Padding(
                padding: const EdgeInsets.only(top: 8, left: 5, right: 5),
                child: SizedBox(
                  height: 150,
                  child: Dismissible(
                    key: ValueKey(widget.dresses[index].id),

                    direction: DismissDirection.endToStart,

                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),

                    confirmDismiss: (direction) async {
                      return await _confirmDismissDeleteDress(context);
                    },
                    onDismissed: (direction) async {
                      _onDismissDeleteDress(index);
                    },
                    child: Card(
                      elevation: 3,
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                detailsScreen(dressInfo);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                                child: Image.network(
                                  dressInfo['imageUrl'],
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Name: ${dressInfo['title']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text('Price: ${dressInfo['price']}'),
                                const SizedBox(height: 8),
                                Text('Date: $formattedDate'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: IconButton(
                              onPressed: () {_deleteDress(context, index);},
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            'Total Price: ${_totalPrice()}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ),
      ],
    );
  }



  _totalPrice(){
    double totalPrice = 0;
    for (var dressInfo in widget.dresses) {
      totalPrice += dressInfo['price'];
    }
    return totalPrice;
  }

  _deleteDress(context, index){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Do you want to delete this dress?'),
          actions: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      await FirebaseFirestore.instance
                          .collection('dresses')
                          .doc(widget.dresses[index].id)
                          .delete();

                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Dress deleted successfully')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to delete: $e')),
                      );
                    }
                  },
                  child: Text('Delete'),
                ),
              ],
            )
          ],
        );
      },
    );
  }


  _confirmDismissDeleteDress(BuildContext context) {
       return showDialog(
         context: context,
         builder: (ctx) => AlertDialog(
           title: const Text('Do you want to delete this dress?'),
           actions: [
             TextButton(
               onPressed: () => Navigator.of(ctx).pop(false),
               child: const Text('Cancel'),
             ),
             TextButton(
               onPressed: () => Navigator.of(ctx).pop(true),
               child: const Text('Delete'),
             ),
           ],
         ),
       );
     }

   _onDismissDeleteDress(index) async{
     try {
       final docId = widget.dresses[index].id;
       setState(() {
         widget.dresses.removeAt(index);
       });
       await FirebaseFirestore.instance.collection('dresses').doc(docId).delete();

       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Dress deleted successfully')),
       );
     } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Failed to delete: $e')),
       );
     }
   }
}


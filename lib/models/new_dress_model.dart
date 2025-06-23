import 'package:intl/intl.dart';

import 'category.dart';

final formatter = DateFormat.yMd();

class NewDress {
  final String dressImage;
  final String dressName;
  final String dressPrice;
  final Categories categories;
  final DateTime buyingDate;

  String get formattedDate {
    return formatter.format(buyingDate);
  }


  NewDress({required this.dressImage, required this.dressName, required this.dressPrice, required this.categories, required this.buyingDate});
}
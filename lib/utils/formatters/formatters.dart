
import 'package:intl/intl.dart';

class MainFormatter{

  static String formatDate(DateTime date){
    date ??= DateTime.now();
    return DateFormat("dd MMM yyyy").format(date);
  }
}
import 'package:intl/intl.dart';

String convertDate(String date){
  // Parse the input date string into a DateTime object
  DateTime inputDate = DateTime.parse(date);

  // Format the DateTime object into the desired output format
  String outputDateStr = DateFormat('d MMM y').format(inputDate);
  return outputDateStr;
}


String dateDifference(String date){
  DateTime inputDate = DateTime.parse(date);

  DateTime now = DateTime.now();

  Duration difference = inputDate.difference(now);
  return difference.inDays.toString();
}
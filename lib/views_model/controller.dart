import 'package:get/get.dart';

import '../model/record.dart';
import '../screen/graphics.dart';

class Controller extends GetxController {
  static int selectedvalue = 53;
  List<Month> data = [
    Month('Yan', selectedvalue.toDouble()),
    Month('Fev', 28),
    Month('Mar', 34),
    Month('Apr', 32),
    Month('May', 40),
    Month('Iyun', 40),
    Month('Iyul', 40),
    Month('Avq', 40),
    Month('Sent', 40),
    Month('Okt', 40),
    Month('Noy', 40),
    Month('Dek', 40),
  ];

  var records = <Record>[].obs;

  void addRecord() {
    records.add(Record(weight: 90, dateTime: DateTime.now(), note: "xxxx"));
  }

  void deleteRecord(Record record) {
    records.remove(record);
  }

  void saveValue(int savedValue){
    savedValue = selectedvalue;
    update();
  }
}

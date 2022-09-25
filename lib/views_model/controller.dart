import 'package:get/get.dart';

import '../model/record.dart';
import '../screen/graphics.dart';

class Controller extends GetxController {
static int selectedvalue = 55;



  var records = <Record>[].obs;

  void addRecord() {
    records.add(Record(weight: 90, dateTime: DateTime.now(), note: "xxxx"));
  }

  void deleteRecord(Record record) {
    records.remove(record);
  }

  // void saveValue(int savedValue){
  //   savedValue = selectedvalue;
  // }
}

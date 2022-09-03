import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getx/screen/graphics.dart';
import 'package:getx/screen/history.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

import '../views_model/controller.dart';

class AddRecord extends StatefulWidget {
  const AddRecord({Key? key}) : super(key: key);

  @override
  State<AddRecord> createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {

  DateTime _selecteddate = DateTime.now();
  TextEditingController note = TextEditingController();
  String _note = "qeyd əlavə et";

  void datePicker(BuildContext context)async{
      var initialDate = DateTime.now();
             _selecteddate = await showDatePicker(context: context, 
              initialDate: initialDate, 
              firstDate: initialDate.subtract(Duration(days: 365)), 
              lastDate: initialDate.add(Duration(days: 30)),
              builder: (context, child){
                return Theme(data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme(
                    brightness: Brightness.light,
                   primary: Colors.black,
                    onPrimary: Colors.white, 
                    secondary: Colors.yellow,
                     onSecondary: Colors.yellowAccent, 
                     error: Colors.red,
                      onError: Colors.orange, 
                     background: Colors.blueAccent, 
                     onBackground: Colors.blueGrey, 
                     surface: Colors.blue, 
                     onSurface: Colors.black26,)

                ), child: child??Text(""));
              }
              
              )?? _selecteddate;
             
          setState(() {
            
          });
  }
  final Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Əlavə et"),
        centerTitle: true,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(FontAwesomeIcons.weightScale, size: 40,),
                GetBuilder<Controller>(
                  init: Controller(),
                  builder: (valueInt) {
                    return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [NumberPicker(
                          itemCount: 3,
                          itemWidth: 80,
                          itemHeight: 50,
                          step: 1,
                          axis: Axis.horizontal,
                          minValue: 40, 
                          maxValue: 130, 
                          value: Controller.selectedvalue,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey)
                            ),
                          onChanged: (value){
                            setState(() {
                  
                           Controller.selectedvalue = value;
                            });
                            print(value);
                          }),
                          Icon(FontAwesomeIcons.chevronUp,size: 16,)
                        ]
                      );
                  }
                )
               
                 
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: ((){
          datePicker(context);
              
            }),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(FontAwesomeIcons.calendar,
                    size: 40,),
                    Expanded(
                      child: Text(
                       DateFormat('EEE, MMM d').format(_selecteddate),
                       textAlign: TextAlign.center,
                    
                    
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (() {
              setState(() {
                showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title:  Text("Qeyd  əlavə et"),
      content: TextField(
        controller: note,
      ),
      actions: <Widget>[
         TextButton(
          child: new Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
               _note = note.text;
            });
           
          },
        ),
      ],
    );
  },
);
              });
            }),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(FontAwesomeIcons.noteSticky, size: 40,),
                    Expanded(child: Text(_note, textAlign: TextAlign.center,))
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(onPressed: (){
            setState(() {
                         controller.saveValue(Controller.selectedvalue)
;
            });

          }, child: Text("yadda saxla"),
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),)
        ],
      ),
    );
  }
}
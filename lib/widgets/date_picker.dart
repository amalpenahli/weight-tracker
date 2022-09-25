// import 'package:flutter/material.dart';
// DateTime _selecteddate = DateTime.now();
//   var initialDate;
// void datePicker(BuildContext context) async {
//     initialDate = DateTime.now();
//     _selecteddate = await showDatePicker(
//             context: context,
//             initialDate: initialDate,
//             firstDate: initialDate.subtract(Duration(days: 365)),
//             lastDate: initialDate.add(Duration(days: 30)),
//             builder: (context, child) {
//               return Theme(
//                   data: ThemeData.light().copyWith(
//                       colorScheme: const ColorScheme(
//                     brightness: Brightness.light,
//                     primary: Colors.black,
//                     onPrimary: Colors.white,
//                     secondary: Colors.yellow,
//                     onSecondary: Colors.yellowAccent,
//                     error: Colors.red,
//                     onError: Colors.orange,
//                     background: Colors.blueAccent,
//                     onBackground: Colors.blueGrey,
//                     surface: Colors.blue,
//                     onSurface: Colors.black26,
//                   )),
//                   child: child ?? const Text(""));
//             }) ??
//         _selecteddate;

  
//   }
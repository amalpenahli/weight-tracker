import 'package:flutter/material.dart';

class Constants{
  static OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25.0),
                                  ),
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 1.0));
}

class GradientColor{
 static Decoration decoration=const  BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.green],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topLeft,
                        ),
                      );
}



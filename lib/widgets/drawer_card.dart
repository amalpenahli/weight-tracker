import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getx/constants/constants.dart';

class ContainerDrawer extends StatelessWidget {
  final String title;
  final String subtitle;
  final Decoration decoration;
  
  const ContainerDrawer(
      {Key? key,
      required this.title,
      required this.subtitle, 
      required this.decoration,
     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: decoration,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/10.3,
     
        
        
        
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        
    );
    
  }
}

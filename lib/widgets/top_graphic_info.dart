import 'package:flutter/material.dart';

class TopGraphicInfo extends StatelessWidget {
  final Color color;
  final String text;

  const TopGraphicInfo({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60.0),
      child: Row(
        
        children: [
          Container(
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(10)),
            width: 10,
            height: 10,
          ),
          const SizedBox(width: 10),
          Row(
            children:  [
              Text(text),
            ],
          )
        ],
      ),
    );
  }
}

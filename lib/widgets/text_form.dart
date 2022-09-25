import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../utils/styles.dart';

class TextFieldContainer extends StatefulWidget {
  final String text;
  TextEditingController controller = TextEditingController();
  IconData icon;
  bool eye = true;
  TextFieldContainer({
    Key? key,
    required this.text,
    required this.controller,
    required this.icon,
  }) : super(key: key);

  @override
  State<TextFieldContainer> createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 5,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.text == "Password" ? widget.eye : false,
        
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
              child: Icon(widget.icon, size: 20, color: Styles.appColor),
            ),
            suffixIcon: widget.text == "Password"
                ? GestureDetector(
                    onTap: (() {
                      setState(() {
                        widget.eye = !widget.eye;
                      });
                    }),
                    child: Icon(
                      widget.eye ? Icons.visibility_off : Icons.visibility,
                      color: Styles.appColor,
                    ))
                : null,
            fillColor: Colors.white,
            filled: true,
            hintText: widget.text,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
            enabledBorder: Constants.outlineInputBorder,
            focusedBorder: Constants.outlineInputBorder),
      ),
    );
  }
}

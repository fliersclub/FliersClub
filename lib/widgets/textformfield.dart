import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextFormField1 extends StatelessWidget {
  TextFormField1(
      {this.validator,
      this.type,
      this.hintText,
      this.ontap,
      this.controller,
      this.readonly,
      this.label});
  String? hintText;
  Function()? ontap;
  final String? Function(String?)? validator;
  TextEditingController? controller;
  TextInputType? type;
  bool? readonly;
  String? label;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        width: double.infinity,
        child: TextFormField(
          keyboardType: type,
          validator: validator,
          readOnly: readonly == null ? false : true,
          controller: controller,
          onTap: ontap,
          decoration: InputDecoration(
            labelText: label,
            hintText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
              borderRadius: BorderRadius.all(
                Radius.circular(32),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
          ),
        ));
  }
}

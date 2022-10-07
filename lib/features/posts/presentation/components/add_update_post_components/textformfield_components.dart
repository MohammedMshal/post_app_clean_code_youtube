import 'package:flutter/material.dart';

class TextFormFieldComponents extends StatelessWidget {
  const TextFormFieldComponents({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.emptyText,
    required this.maxLine,
    required this.minLine,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final String emptyText;
  final bool maxLine;
  final bool minLine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controller,
        validator: (val) => val!.isEmpty ? emptyText : null,
        decoration: InputDecoration(hintText: hintText),
        maxLines: maxLine ? 6 : 1,
        minLines: minLine ? 6 : 1,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyTextFiled extends StatefulWidget {
  const MyTextFiled({
    super.key,
    required this.label,
    required this.maxLines,
    required this.controller,
  });
  final String label;
  final int maxLines;
  final TextEditingController? controller;
  @override
  State<MyTextFiled> createState() => _MyTextFiledState();
}

class _MyTextFiledState extends State<MyTextFiled> {
  late TextEditingController textController;
  @override
  void initState() {
    super.initState();
    textController = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      textController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        hintText: widget.label,
      ),
    );
  }
}

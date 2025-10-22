import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const OptionTile({Key? key, required this.text, required this.selected, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: selected
          ? const Icon(Icons.check_circle, color: Colors.green)
          : const Icon(Icons.radio_button_unchecked),
      title: Text(text),
    );
  }
}

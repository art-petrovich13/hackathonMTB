import 'package:flutter/material.dart';
import '../models/question.dart';
import 'option_tile.dart';

typedef OnAnswer = void Function(List<int> selected);

class QuestionWidget extends StatefulWidget {
  final QuizQuestion question;
  final OnAnswer onAnswer;

  const QuestionWidget({Key? key, required this.question, required this.onAnswer}) : super(key: key);

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  final Set<int> _selected = {};

  void _toggle(int idx) {
    setState(() {
      if (widget.question.multiple) {
        if (_selected.contains(idx)) _selected.remove(idx);
        else _selected.add(idx);
      } else {
        _selected.clear();
        _selected.add(idx);
      }
      widget.onAnswer(_selected.toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.question.text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...List.generate(widget.question.options.length, (i) {
          return OptionTile(
            text: widget.question.options[i],
            selected: _selected.contains(i),
            onTap: () => _toggle(i),
          );
        }),
      ],
    );
  }
}

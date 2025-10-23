import 'package:flutter/material.dart';
import 'interview_controller.dart';

class InterviewInput extends StatelessWidget {
  final InterviewController controller;

  const InterviewInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.textController,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Напишите ответ...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              onSubmitted: (_) => controller.sendAnswer(),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: controller.sendAnswer,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12)),
            child: const Icon(Icons.send, color: Colors.white),
          )
        ],
      ),
    );
  }
}

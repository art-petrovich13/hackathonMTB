import 'package:flutter/material.dart';
import 'interview_controller.dart';

class InterviewChat extends StatelessWidget {
  final InterviewController controller;

  const InterviewChat({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView.builder(
          reverse: true,
          itemCount: controller.messages.length + (controller.interviewerTyping ? 1 : 0),
          itemBuilder: (context, index) {
            if (controller.interviewerTyping && index == 0) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
                    child: const SizedBox(width: 50, height: 12, child: Center(child: Text('...'))),
                  ),
                ),
              );
            }

            final msg = controller.messages[controller.messages.length - 1 - (index - (controller.interviewerTyping ? 1 : 0))];
            return Align(
              alignment: msg.isInterviewer ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: msg.isInterviewer ? Colors.grey[200] : Colors.orange[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(msg.text),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

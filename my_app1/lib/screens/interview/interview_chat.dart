import 'package:flutter/material.dart';
import 'interview_controller.dart';

class InterviewChat extends StatelessWidget {
  final InterviewController controller;

  const InterviewChat({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF0D47A1);
    final interviewerBubbleColor = Colors.blue.shade50;

    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      itemCount: controller.messages.length + (controller.interviewerTyping ? 1 : 0),
      itemBuilder: (context, index) {
        if (controller.interviewerTyping && index == 0) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: interviewerBubbleColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: const Text("...", style: TextStyle(color: Colors.black54)),
            ),
          );
        }

        final reversedIndex = controller.messages.length - 1 - (index - (controller.interviewerTyping ? 1 : 0));
        final msg = controller.messages[reversedIndex];
        final isUserMessage = !msg.isInterviewer;

        return Align(
          alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              color: isUserMessage ? primaryColor : interviewerBubbleColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: isUserMessage ? const Radius.circular(16) : const Radius.circular(0),
                bottomRight: isUserMessage ? const Radius.circular(0) : const Radius.circular(16),
              ),
            ),
            child: Text(
              msg.text,
              style: TextStyle(
                color: isUserMessage ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}

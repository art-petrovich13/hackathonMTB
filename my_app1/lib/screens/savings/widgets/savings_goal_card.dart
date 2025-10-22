import 'package:flutter/material.dart';
import '../models/savings_goal.dart';

class SavingsGoalCard extends StatelessWidget {
  final SavingsGoal goal;
  final VoidCallback onAddMoney;
  const SavingsGoalCard({super.key, required this.goal, required this.onAddMoney});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0,2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(goal.title, style: const TextStyle(fontSize: 16, color: Colors.black54)),
                    const SizedBox(height: 8),
                    Text(goal.currentAmount.toStringAsFixed(0), style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              IconButton(
                onPressed: onAddMoney,
                icon: Icon(Icons.person_outline, color: Colors.deepPurpleAccent, size: 48),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: goal.progress,
              minHeight: 12,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
            ),
          ),
          const SizedBox(height: 6),
          Text('${(goal.progress * 100).toStringAsFixed(2)}% (Осталось: ${(goal.targetAmount - goal.currentAmount).toStringAsFixed(0)})', style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }
}

// moved from lib/features/savings/models/savings_goal.dart
import 'dart:convert';

class SavingsGoal {
  final String id;
  final String title;
  final double targetAmount;
  double currentAmount;

  SavingsGoal({
    required this.id,
    required this.title,
    required this.targetAmount,
    this.currentAmount = 0.0,
  });

  double get progress => targetAmount == 0 ? 0 : (currentAmount / targetAmount).clamp(0.0, 1.0);

  void add(double amount) {
    currentAmount += amount;
    if (currentAmount > targetAmount) currentAmount = targetAmount;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'targetAmount': targetAmount,
        'currentAmount': currentAmount,
      };

  factory SavingsGoal.fromJson(Map<String, dynamic> json) => SavingsGoal(
        id: json['id'] as String,
        title: json['title'] as String,
        targetAmount: (json['targetAmount'] as num).toDouble(),
        currentAmount: (json['currentAmount'] as num).toDouble(),
      );

  static List<SavingsGoal> listFromJson(String jsonStr) {
    final List<dynamic> arr = json.decode(jsonStr) as List<dynamic>;
    return arr.map((e) => SavingsGoal.fromJson(e as Map<String, dynamic>)).toList();
  }

  static String listToJson(List<SavingsGoal> list) => json.encode(list.map((e) => e.toJson()).toList());
}

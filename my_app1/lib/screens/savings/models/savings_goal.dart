// moved from lib/features/savings/models/savings_goal.dart
import 'dart:convert';

class GoalTransaction {
  final String id;
  final String type; // 'in' or 'out'
  final double amount;
  final DateTime time;

  GoalTransaction({required this.id, required this.type, required this.amount, required this.time});

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'amount': amount,
        'time': time.toIso8601String(),
      };

  factory GoalTransaction.fromJson(Map<String, dynamic> json) => GoalTransaction(
        id: json['id'] as String,
        type: json['type'] as String,
        amount: (json['amount'] as num).toDouble(),
        time: DateTime.parse(json['time'] as String),
      );
}

class SavingsGoal {
  final String id;
  final String title;
  final double targetAmount;
  double currentAmount;
  final List<GoalTransaction> transactions;
  final String? sticker;

  SavingsGoal({
    required this.id,
    required this.title,
    required this.targetAmount,
    this.currentAmount = 0.0,
    List<GoalTransaction>? transactions,
    this.sticker,
  }) : transactions = transactions ?? [];

  double get progress => targetAmount == 0 ? 0 : (currentAmount / targetAmount).clamp(0.0, 1.0);

  void add(double amount) {
    currentAmount += amount;
    if (currentAmount > targetAmount) currentAmount = targetAmount;
    transactions.insert(0, GoalTransaction(id: DateTime.now().millisecondsSinceEpoch.toString(), type: 'in', amount: amount, time: DateTime.now()));
  }

  void withdraw(double amount) {
    currentAmount -= amount;
    if (currentAmount < 0) currentAmount = 0;
    transactions.insert(0, GoalTransaction(id: DateTime.now().millisecondsSinceEpoch.toString(), type: 'out', amount: amount, time: DateTime.now()));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'targetAmount': targetAmount,
        'currentAmount': currentAmount,
    'transactions': transactions.map((t) => t.toJson()).toList(),
    'sticker': sticker,
      };

  factory SavingsGoal.fromJson(Map<String, dynamic> json) => SavingsGoal(
        id: json['id'] as String,
        title: json['title'] as String,
        targetAmount: (json['targetAmount'] as num).toDouble(),
  currentAmount: (json['currentAmount'] as num).toDouble(),
  transactions: (json['transactions'] as List<dynamic>?)
    ?.map((e) => GoalTransaction.fromJson(e as Map<String, dynamic>))
    .toList() ?? [],
  sticker: json['sticker'] as String?,
      );

  static List<SavingsGoal> listFromJson(String jsonStr) {
    final List<dynamic> arr = json.decode(jsonStr) as List<dynamic>;
    return arr.map((e) => SavingsGoal.fromJson(e as Map<String, dynamic>)).toList();
  }

  static String listToJson(List<SavingsGoal> list) => json.encode(list.map((e) => e.toJson()).toList());
}

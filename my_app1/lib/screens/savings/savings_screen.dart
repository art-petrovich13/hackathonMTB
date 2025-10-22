import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/savings_goal.dart';
import 'widgets/savings_header.dart';
import 'widgets/savings_goal_card.dart';
import 'widgets/add_goal_dialog.dart';
import 'goal_detail_screen.dart';

class SavingsScreen extends StatefulWidget {
  const SavingsScreen({super.key});

  @override
  State<SavingsScreen> createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen> {
  final List<SavingsGoal> _goals = [];

  static const _prefsKey = 'savings_goals_v1';

  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  Future<void> _loadGoals() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw != null && raw.isNotEmpty) {
      setState(() {
        _goals.clear();
        _goals.addAll(SavingsGoal.listFromJson(raw));
      });
    }
  }

  Future<void> _saveGoals() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, SavingsGoal.listToJson(_goals));
  }

  void _addGoal() async {
    final result = await showDialog<Map<String, dynamic>?>(context: context, builder: (context) => const AddGoalDialog());

    if (result != null) {
      setState(() {
        _goals.add(SavingsGoal(id: DateTime.now().millisecondsSinceEpoch.toString(), title: result['title'], targetAmount: result['amount']));
        _saveGoals();
      });
    }
  }

  void _addMoney(SavingsGoal goal) async {
    final amountCtrl = TextEditingController();
    final res = await showDialog<double?>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('\u041f\u043e\u043b\u043e\u0436\u0438\u0442\u044c \u0434\u0435\u043d\u044c\u0433\u0438'),
        content: TextField(controller: amountCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: '\u0421\u0443\u043c\u043c\u0430')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, null), child: const Text('\u041e\u0442\u043c\u0435\u043d\u0430')),
          ElevatedButton(
            onPressed: () {
              final v = double.tryParse(amountCtrl.text.replaceAll(',', '.')) ?? 0.0;
              Navigator.pop(context, v > 0 ? v : null);
            },
            child: const Text('\u0414\u043e\u0431\u0430\u0432\u0438\u0442\u044c'),
          ),
        ],
      ),
    );

    if (res != null) {
      setState(() {
        goal.add(res);
        _saveGoals();
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SavingsHeader(totalBalance: _goals.fold<double>(0, (p, e) => p + e.currentAmount)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: _goals.isEmpty
                  ? Center(child: Text('Целей пока нет. Нажмите + чтобы добавить.', style: Theme.of(context).textTheme.bodyLarge))
                  : ListView.builder(
                      itemCount: _goals.length,
                      itemBuilder: (context, index) {
                        final g = _goals[index];
                        return GestureDetector(
                          onTap: () async {
                            final updated = await Navigator.push<SavingsGoal>(context, MaterialPageRoute(builder: (_) => GoalDetailScreen(goal: g)));
                            if (updated != null) {
                              setState(() {
                                final idx = _goals.indexWhere((el) => el.id == updated.id);
                                if (idx != -1) {
                                  _goals[idx] = updated;
                                  _saveGoals();
                                }
                              });
                            }
                          },
                          child: SavingsGoalCard(goal: g, onAddMoney: () => _addMoney(g)),
                        );
                      },
                    ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addGoal,
        child: const Icon(Icons.add),
      ),
    );
  }
}

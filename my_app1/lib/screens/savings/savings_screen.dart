import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/savings_goal.dart';

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
    final result = await showDialog<Map<String, dynamic>?>(
      context: context,
      builder: (context) {
        final titleCtrl = TextEditingController();
        final amountCtrl = TextEditingController();
        return AlertDialog(
          title: const Text('Новая цель'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Название')),
              TextField(controller: amountCtrl, decoration: const InputDecoration(labelText: 'Сумма'), keyboardType: TextInputType.number),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, null), child: const Text('Отмена')),
            ElevatedButton(
              onPressed: () {
                final title = titleCtrl.text.trim();
                final amount = double.tryParse(amountCtrl.text.replaceAll(',', '.')) ?? 0.0;
                if (title.isNotEmpty && amount > 0) {
                  Navigator.pop(context, {'title': title, 'amount': amount});
                }
              },
              child: const Text('Создать'),
            ),
          ],
        );
      },
    );

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
        title: const Text('Положить деньги'),
        content: TextField(controller: amountCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Сумма')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, null), child: const Text('Отмена')),
          ElevatedButton(
            onPressed: () {
              final v = double.tryParse(amountCtrl.text.replaceAll(',', '.')) ?? 0.0;
              Navigator.pop(context, v > 0 ? v : null);
            },
            child: const Text('Добавить'),
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
      appBar: AppBar(title: const Text('Копилка'), backgroundColor: Colors.teal),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _goals.isEmpty
            ? Center(child: Text('Целей пока нет. Нажмите кнопку + чтобы добавить.', style: Theme.of(context).textTheme.bodyLarge))
            : ListView.builder(
                itemCount: _goals.length,
                itemBuilder: (context, index) {
                  final g = _goals[index];
                  return Card(
                    child: ListTile(
                      title: Text(g.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          LinearProgressIndicator(value: g.progress, minHeight: 8, backgroundColor: Colors.grey[200]),
                          const SizedBox(height: 6),
                          Text('${g.currentAmount.toStringAsFixed(0)} / ${g.targetAmount.toStringAsFixed(0)}'),
                        ],
                      ),
                      trailing: IconButton(icon: const Icon(Icons.add), onPressed: () => _addMoney(g)),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addGoal,
        child: const Icon(Icons.add),
      ),
    );
  }
}

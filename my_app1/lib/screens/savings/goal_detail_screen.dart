import 'package:flutter/material.dart';
import 'models/savings_goal.dart';

class GoalDetailScreen extends StatefulWidget {
  final SavingsGoal goal;
  const GoalDetailScreen({super.key, required this.goal});

  @override
  State<GoalDetailScreen> createState() => _GoalDetailScreenState();
}

class _GoalDetailScreenState extends State<GoalDetailScreen> {
  late SavingsGoal _goal;

  @override
  void initState() {
    super.initState();
    _goal = widget.goal;
  }

  Future<void> _changeAmount(bool add) async {
    final ctrl = TextEditingController();
    final res = await showDialog<double?>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(add ? 'Пополнить' : 'Снять'),
        content: TextField(controller: ctrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Сумма')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, null), child: const Text('Отмена')),
          ElevatedButton(
            onPressed: () {
              final v = double.tryParse(ctrl.text.replaceAll(',', '.')) ?? 0.0;
              Navigator.pop(context, v > 0 ? v : null);
            },
            child: const Text('Подтвердить'),
          )
        ],
      ),
    );

    if (res != null) {
      setState(() {
        if (add) {
          _goal.add(res);
        } else {
          _goal.withdraw(res);
        }
      });
      // return updated goal when popping
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(children: [ if (_goal.sticker != null) Text(_goal.sticker! + ' ', style: const TextStyle(fontSize: 20)), Text(_goal.title) ]), backgroundColor: const Color(0xFF0D47A1)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(14)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Текущий баланс', style: TextStyle(color: Colors.black54)),
                const SizedBox(height: 6),
                Row(children: [
                  Expanded(child: Text(_goal.currentAmount.toStringAsFixed(0), style: const TextStyle(fontSize: 38, fontWeight: FontWeight.bold))),
                  if (_goal.sticker != null) Container(margin: const EdgeInsets.only(left: 8), padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)), child: Text(_goal.sticker!, style: const TextStyle(fontSize: 24))),
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(child: ElevatedButton(onPressed: () => _changeAmount(true), style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300], foregroundColor: Colors.deepPurpleAccent), child: const Padding(padding: EdgeInsets.symmetric(vertical: 12.0), child: Text('ПОПОЛНИТЬ')))),
                  const SizedBox(width: 12),
                  Expanded(child: ElevatedButton(onPressed: () => _changeAmount(false), style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300], foregroundColor: Colors.deepPurpleAccent), child: const Padding(padding: EdgeInsets.symmetric(vertical: 12.0), child: Text('ВЫВЕСТИ')))),
                ])
              ]),
            ),
            const SizedBox(height: 18),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Прогресс', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('ЦЕЛЬ: ${_goal.targetAmount.toStringAsFixed(0)}', style: const TextStyle(color: Colors.black54))
            ]),
            const SizedBox(height: 12),
            ClipRRect(borderRadius: BorderRadius.circular(12), child: LinearProgressIndicator(value: _goal.progress, minHeight: 14, backgroundColor: Colors.grey[200], valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent))),
            const SizedBox(height: 12),
            Text('${(_goal.progress * 100).toStringAsFixed(2)}% (Осталось: ${(_goal.targetAmount - _goal.currentAmount).toStringAsFixed(0)})', style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 18),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Транзакции', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: const Text('Посмотреть все', style: TextStyle(color: Colors.deepPurpleAccent)))
            ]),
            const SizedBox(height: 12),
            ..._goal.transactions.map((t) => ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.grey[200], child: Icon(t.type == 'in' ? Icons.arrow_upward : Icons.arrow_downward, color: Colors.deepPurpleAccent)),
                  title: Text('${t.time.day} ${_monthName(t.time.month)} ${t.time.year} г. ${t.time.hour}:${t.time.minute.toString().padLeft(2, '0')}', style: const TextStyle(fontSize: 16)),
                  trailing: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.deepPurpleAccent.withOpacity(0.12), borderRadius: BorderRadius.circular(20)), child: Text('${t.type == 'in' ? '+' : '-'}${t.amount.toStringAsFixed(0)}', style: const TextStyle(color: Colors.deepPurpleAccent))),
                ))
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, _goal);
          },
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D47A1)),
          child: const Padding(padding: EdgeInsets.symmetric(vertical: 14.0), child: Text('Сохранить и вернуться')),
        ),
      ),
    );
  }

  String _monthName(int m) {
    const months = ['января','февраля','марта','апреля','мая','июня','июля','августа','сентября','октября','ноября','декабря'];
    return months[m-1];
  }
}

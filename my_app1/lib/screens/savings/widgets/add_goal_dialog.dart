import 'package:flutter/material.dart';

class AddGoalDialog extends StatefulWidget {
  const AddGoalDialog({super.key});

  @override
  State<AddGoalDialog> createState() => _AddGoalDialogState();
}

class _AddGoalDialogState extends State<AddGoalDialog> {
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  String? _selectedSticker;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('СОЗДАТЬ КОПИЛКУ', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const Text('Название', style: TextStyle(color: Colors.black54)),
              const SizedBox(height: 8),
              TextField(controller: _titleCtrl, decoration: InputDecoration(filled: true, fillColor: Colors.grey[200], border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
              const SizedBox(height: 12),
              const Text('Стикер', style: TextStyle(color: Colors.black54)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (final s in ['📦', '🚗', '📱', '🏠', '🎮', '✈️', '🍽️', '🎓', '🛒', '💼'])
                    GestureDetector(
                      onTap: () => setState(() => _selectedSticker = s),
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: _selectedSticker == s ? Colors.deepPurpleAccent.withOpacity(0.12) : Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: _selectedSticker == s ? Colors.deepPurpleAccent : Colors.transparent),
                        ),
                        alignment: Alignment.center,
                        child: Text(s, style: const TextStyle(fontSize: 32)),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              const Text('Сумма', style: TextStyle(color: Colors.black54)),
              const SizedBox(height: 8),
              TextField(controller: _amountCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(filled: true, fillColor: Colors.grey[200], border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
                    onPressed: () {
                      final title = _titleCtrl.text.trim();
                      final amount = double.tryParse(_amountCtrl.text.replaceAll(',', '.')) ?? 0.0;
                      if (title.isNotEmpty && amount > 0) {
                        Navigator.pop(context, {'title': title, 'amount': amount, 'sticker': _selectedSticker});
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 12),
                      child: Text('СОХРАНИТЬ', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

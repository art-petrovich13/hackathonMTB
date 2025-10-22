import 'package:flutter/material.dart';

class CardResultScreen extends StatelessWidget {
  const CardResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final fio = args?['fio'] ?? 'Клиент';
    final cardNumber = args?['cardNumber'] ?? '1234 5678 9012 3456';
    final account = args?['account'] ?? 'BY00 0000 0000 0000 0000';

    return Scaffold(
      appBar: AppBar(title: const Text('Готово')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: Colors.indigo[700],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(fio, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(cardNumber, style: const TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 2)),
                    Text(account, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Счёт и карточка созданы', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text('Вы можете увидеть созданную карточку и счёт в разделе карточек и счетов.'),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                  arguments: {'showProducts': true},
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0),
                child: Text('Вернуться на главную', style: TextStyle(fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

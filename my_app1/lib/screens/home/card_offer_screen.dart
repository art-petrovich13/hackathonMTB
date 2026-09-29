import 'package:flutter/material.dart';

class CardOfferScreen extends StatelessWidget {
  const CardOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Оформить карточку')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Simple bank card mock
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.indigo[700],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('BANK', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('••••  ••••  ••••  1234', style: TextStyle(color: Colors.white, fontSize: 22, letterSpacing: 2)),
                    Text('VIKTORIA IV', style: TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Преимущества карточки', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text('• Бесплатное обслуживание в первый год\n• Кэшбек 1% на все покупки\n• Мгновенные переводы', style: TextStyle(fontSize: 14)),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/card_application'),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0),
                child: Text('Оформить зарплатную карточку', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

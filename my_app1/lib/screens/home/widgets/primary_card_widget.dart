import 'package:flutter/material.dart';
import '../card/card_screen.dart';

class PrimaryCardWidget extends StatelessWidget {
  const PrimaryCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CardScreen())),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 9, 9, 9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Kopym',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                const Icon(Icons.visibility_off, size: 18, color: Colors.black54),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              '00.00 BYN',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Chip(label: Text('4•5783')),
                SizedBox(width: 8),
                Icon(Icons.credit_card, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AccountsSection extends StatelessWidget {
  const AccountsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Счета', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Container(width: 48, height: 36, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(8))),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text('Текущий счёт', style: TextStyle(color: Colors.black54)),
                SizedBox(height: 6),
                Text('1000.00 BYN', style: TextStyle(fontWeight: FontWeight.bold))
              ])
            ],
          ),
        )
      ],
    );
  }
}

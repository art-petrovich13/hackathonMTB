import 'package:flutter/material.dart';

class PrimaryCardWidget2 extends StatelessWidget {
  const PrimaryCardWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                decoration: BoxDecoration(color: Colors.orangeAccent, borderRadius: BorderRadius.circular(6)),
              ),
              const SizedBox(width: 12),
              const Text('ХАЛВА', style: TextStyle(fontWeight: FontWeight.w600)),
              const Spacer(),
              const Icon(Icons.visibility_off, size: 18, color: Colors.black54),
            ],
          ),
          const SizedBox(height: 12),
          const Text('1000.00 BYN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: const [
              Chip(label: Text('4•5783')),
              SizedBox(width: 8),
              Icon(Icons.credit_card, size: 20),
            ],
          )
        ],
      ),
    );
  }
}

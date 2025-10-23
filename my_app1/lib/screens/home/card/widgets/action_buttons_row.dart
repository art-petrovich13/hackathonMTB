import 'package:flutter/material.dart';

class ActionButtonsRow extends StatelessWidget {
  final void Function()? onPointsTap;
  const ActionButtonsRow({super.key, this.onPointsTap});

  Widget _button(IconData icon, String label, {void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0,2))],
            ),
            child: Icon(icon, color: const Color(0xFF0D47A1)),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.black87)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _button(Icons.download, 'Пополнить'),
          _button(Icons.sync_alt, 'Перевести'),
          _button(Icons.credit_card, 'Оплатить'),
          _button(Icons.card_giftcard, 'Баллы', onTap: onPointsTap),
        ],
      ),
    );
  }
}

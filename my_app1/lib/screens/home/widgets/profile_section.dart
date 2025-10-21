import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white24,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.person, color: Colors.white, size: 30),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Виктория', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 4),
            Text('Default state', style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.notifications, color: Colors.white, size: 18),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card visual - use whitecard.png as background and keep text overlays
          Container(
            height: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('lib/assets/whitecard.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // If the card image is light, use dark text; adjust color as needed
                  const Text('КАКТУС BYN', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  const Text('97.27 BYN', style: TextStyle(color: Colors.black87, fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Text('5*0042 • 09/28', style: TextStyle(color: Colors.black54)),
                      Spacer(),
                      Text('0.00 баллов', style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

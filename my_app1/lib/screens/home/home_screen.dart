import 'package:flutter/material.dart';
import 'widgets/profile_section.dart';
import 'widgets/primary_card_widget.dart';
import 'widgets/accounts_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: size.height * 0.40,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFF1DA1FF), Color(0xFF2A9DF4)]),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(22), bottomRight: Radius.circular(22)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProfileSection(),
                  const SizedBox(height: 18),
                  const Text('10000', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 14),
                  // Action buttons row
                  Row(
                    children: [
                      _actionButton(Icons.account_balance_wallet, 'Пополнить'),
                      const SizedBox(width: 12),
                      _actionButton(Icons.send, 'Перевести'),
                      const SizedBox(width: 12),
                      _actionButton(Icons.payment, 'Оплатить'),
                    ],
                  ),
                ],
              ),
            ),

            // Content below
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text('Карточки', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 12),
                      const PrimaryCardWidget(),
                      const SizedBox(height: 18),
                      const AccountsSection(),
                      const SizedBox(height: 24),
                      // Bottom navigation mimic
                      Container(
                        height: 72,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: const [
                          _BottomNavItem(label: 'Главная', icon: Icons.home),
                          _BottomNavItem(label: 'Продукты', icon: Icons.list_alt),
                          _BottomNavItem(label: 'Чат', icon: Icons.chat_bubble_outline),
                          _BottomNavItem(label: 'Ещё', icon: Icons.more_horiz),
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _actionButton(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(icon, color: Colors.white), const SizedBox(height: 6), Text(label, style: const TextStyle(color: Colors.white, fontSize: 12))],
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  const _BottomNavItem({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, color: Colors.black54),
      const SizedBox(height: 6),
      Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54))
    ]);
  }
}


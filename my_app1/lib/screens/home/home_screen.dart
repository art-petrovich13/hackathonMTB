import 'package:flutter/material.dart';
import 'widgets/profile_section.dart';
import 'widgets/primary_card_widget.dart';
import 'widgets/accounts_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const primaryColor = Color(0xFF1DA1FF);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: Column(
        children: [
          Container(
            height: size.height * 0.43,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF1DA1FF), Color(0xFF2A9DF4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(22),
                  bottomRight: Radius.circular(22)),
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ProfileSection(),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text('Default card',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                        const SizedBox(width: 8),
                        Text('4*5783',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14)),
                        const SizedBox(width: 4),
                        Icon(Icons.info_outline,
                            color: Colors.white.withOpacity(0.8), size: 18),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        Text('1000.00 BYN',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold)),
                        Spacer(),
                        Icon(Icons.visibility_off_outlined,
                            color: Colors.white, size: 24),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // Action buttons row
                    Row(
                      children: [
                        _actionButton(Icons.download, 'Пополнить', primaryColor),
                        const SizedBox(width: 12),
                        _actionButton(Icons.sync_alt, 'Перевести', primaryColor),
                        const SizedBox(width: 12),
                        _actionButton(Icons.credit_card, 'Оплатить', primaryColor),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Temporary navigation buttons to other screens (CareerHub & Savings)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/career'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
                              child: const Center(child: Text('Go to Career', style: TextStyle(color: Colors.white))),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/savings'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
                              child: const Center(child: Text('Go to Savings', style: TextStyle(color: Colors.white))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content below
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Currency exchange button
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xFF1DA1FF), Color(0xFF2A9DF4)]),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Обмен валюты по выгодному курсу',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.currency_exchange,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text('Карточки',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    const PrimaryCardWidget(),
                    const SizedBox(height: 24),
                    const Text('Счета',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                     const SizedBox(height: 12),
                    const AccountsSection(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12, width: 1.0))
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _BottomNavItem(
              label: 'Главная',
              icon: Icons.ac_unit, // Placeholder for custom M icon
              isActive: true),
          const _BottomNavItem(
              label: 'Продукты', icon: Icons.inventory_2_outlined),
          const _BottomNavItem(
              label: 'Чат', icon: Icons.chat_bubble_outline),
          const _BottomNavItem(label: 'Ещё', icon: Icons.more_horiz),
        ]),
      ),
    );
  }

  Widget _actionButton(IconData icon, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: color, fontSize: 13))
          ],
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  const _BottomNavItem(
      {required this.label, required this.icon, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    final color = isActive ? const Color(0xFF1DA1FF) : Colors.black54;
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(icon, color: color, size: 28),
      const SizedBox(height: 6),
      Text(label, style: TextStyle(fontSize: 12, color: color))
    ]);
  }
}

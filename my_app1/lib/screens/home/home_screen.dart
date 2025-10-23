import 'package:flutter/material.dart';
import 'widgets/profile_section.dart';
import 'widgets/primary_card_widget.dart';
import 'widgets/primary_card_widget2.dart';
import 'widgets/accounts_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showProducts = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['showProducts'] == true) {
      if (!_showProducts) {
        setState(() {
          _showProducts = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const primaryColor = Color(0xFF0D47A1);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: size.height * 0.43,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(22),
                    bottomRight: Radius.circular(22),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ProfileSection(),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const SizedBox(width: 4),
                            Icon(
                              Icons.info_outline,
                              color: Colors.white.withOpacity(0.8),
                              size: 18,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: const [
                            Text(
                              '00.00 BYN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.white,
                              size: 24,
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        // Action buttons row
                        Row(
                          children: [
                            _actionButton(
                              Icons.download,
                              'Пополнить',
                              primaryColor,
                            ),
                            const SizedBox(width: 12),
                            _actionButton(
                              Icons.sync_alt,
                              'Перевести',
                              primaryColor,
                            ),
                            const SizedBox(width: 12),
                            _actionButton(
                              Icons.credit_card,
                              'Оплатить',
                              primaryColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Temporary navigation buttons to other screens (CareerHub & Savings)
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/career'),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Go to Career',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/savings'),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Go to Savings',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/quiz'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'Go to Quiz',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
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
                        const SizedBox(height: 20),
                        if (!_showProducts)
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/card_offer'),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 24,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: const Column(
                                children: [
                                  Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.blueAccent,
                                    size: 48,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'У вас нет пока продуктов, давайте добавим',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.currency_exchange,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(width: 16),
                                Text(
                                  'Обмен валюты',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.chevron_right, color: Colors.grey),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Карточки',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const PrimaryCardWidget(),
                          const SizedBox(height: 12),
                          const PrimaryCardWidget2(),
                          const SizedBox(height: 24),
                          const Text(
                            'Счета',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const AccountsSection(),
                          const SizedBox(height: 8),
                          const AccountsSection(),
                          const SizedBox(height: 24),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Positioned.fill(
            child: IgnorePointer(ignoring: true, child: HalloweenOverlay()),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12, width: 1.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const _BottomNavItem(
              label: 'Главная',
              icon: Icons.ac_unit,
              isActive: true,
            ),
            const _BottomNavItem(
              label: 'Продукты',
              icon: Icons.inventory_2_outlined,
            ),
            const _BottomNavItem(label: 'Чат', icon: Icons.chat_bubble_outline),
            const _BottomNavItem(label: 'Ещё', icon: Icons.more_horiz),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(IconData icon, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: color, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

// Simple Halloween overlay: falling pumpkins and leaves using emoji (no assets)
class HalloweenOverlay extends StatefulWidget {
  const HalloweenOverlay({super.key});

  @override
  State<HalloweenOverlay> createState() => _HalloweenOverlayState();
}

class _HalloweenOverlayState extends State<HalloweenOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  // Falling leaves only (no pumpkins) — light seasonal decoration
  final List<_FallingItem> items = [
    _FallingItem('🎃', 0.1, 1.0, 28),
    _FallingItem('🍂', 0.3, 0.8, 22),
    _FallingItem('🍁', 0.6, 1.2, 24),
    _FallingItem('🎃', 0.8, 0.9, 26),
    _FallingItem('🍂', 0.45, 1.1, 20),
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final h = constraints.maxHeight;
            final w = constraints.maxWidth;
            return Stack(
              children: items.map((it) {
                final progress = (_ctrl.value * it.speed + it.offset) % 1.0;
                final top =
                    progress * (h + 50) - 30; // start above and go below
                final left =
                    (it.x * w +
                        (20 * (0.5 - (progress - progress.floorToDouble())))) %
                    w;
                final rotate = (progress * 2 * 3.1415 * 0.2);
                return Positioned(
                  top: top,
                  left: left,
                  child: Transform.rotate(
                    angle: rotate,
                    child: Opacity(
                      opacity: (1.0 - (progress.clamp(0.0, 1.0))).clamp(
                        0.2,
                        1.0,
                      ),
                      child: Text(
                        it.emoji,
                        style: TextStyle(fontSize: it.size),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}

class _FallingItem {
  final String emoji;
  final double x; // 0..1 horizontal fraction
  final double speed; // multiplier
  final double size;
  final double offset;

  _FallingItem(this.emoji, this.x, this.speed, this.size, [double? offset])
    : offset = offset ?? (x % 1.0);
}

class _BottomNavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  const _BottomNavItem({
    required this.label,
    required this.icon,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? const Color(0xFF0D47A1) : Colors.black54;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(fontSize: 12, color: color)),
      ],
    );
  }
}

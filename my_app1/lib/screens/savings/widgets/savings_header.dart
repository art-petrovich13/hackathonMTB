import 'package:flutter/material.dart';

class SavingsHeader extends StatelessWidget {
  final double totalBalance;
  const SavingsHeader({super.key, required this.totalBalance});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.20,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left: title column with back arrow aligned to title baseline
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Row containing back button and title
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Back arrow slightly raised by center alignment
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.maybePop(context),
                          tooltip: 'Назад',
                        ),
                        const SizedBox(width: 6),
                        // Title
                        Expanded(
                          child: Text(
                            'Виртуальная карта Kopym',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Общий баланс карты Kopym',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${totalBalance.toStringAsFixed(0)} BYN',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Right: wallet icon, shifted down to sit between title and balance
              Transform.translate(
                offset: const Offset(0, 30),
                child: Container(
                  width: 64,
                  height: 40,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white70,
                    size: 36,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

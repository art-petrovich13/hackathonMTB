import 'package:flutter/material.dart';

class TabsSection extends StatefulWidget {
  const TabsSection({super.key});

  @override
  State<TabsSection> createState() => _TabsSectionState();
}

class _TabsSectionState extends State<TabsSection> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final titles = ['Настройки', 'История', 'Информация'];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: List.generate(titles.length, (i) {
                final active = i == _index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _index = i),
                    child: Column(
                      children: [
                        Text(titles[i], style: TextStyle(color: active ? Colors.black87 : Colors.black45, fontWeight: active ? FontWeight.w600 : FontWeight.normal)),
                        const SizedBox(height: 6),
                        Container(height: 2, color: active ? Colors.redAccent : Colors.transparent)
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          const Divider(height: 1),
          // content
          if (_index == 0) _settingsList(),
          if (_index == 1) _historyPlaceholder(),
          if (_index == 2) _infoPlaceholder(),
        ],
      ),
    );
  }

  Widget _settingsList() {
    final items = [
      'Настройка опций',
      'Лимиты',
      'Сменить ПИН-код',
      'Заблокировать',
      'SMS-уведомления',
      'Перевыпустить',
      'Использовать для зачислений по номеру телефона',
    ];
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, idx) {
        final title = items[idx];
        return ListTile(
          title: Text(title),
          trailing: idx == 3 || idx == 4
              ? Switch(value: false, onChanged: (_) {})
              : const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () {},
        );
      },
    );
  }

  Widget _historyPlaceholder() => const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('История транзакций пока пуста'),
      );

  Widget _infoPlaceholder() => const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Информация о карте'),
      );
}

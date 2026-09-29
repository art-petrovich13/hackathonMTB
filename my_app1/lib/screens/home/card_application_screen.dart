import 'package:flutter/material.dart';

class CardApplicationScreen extends StatefulWidget {
  const CardApplicationScreen({super.key});

  @override
  State<CardApplicationScreen> createState() => _CardApplicationScreenState();
}

class _CardApplicationScreenState extends State<CardApplicationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fioController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passportController = TextEditingController();

  @override
  void dispose() {
    _fioController.dispose();
    _phoneController.dispose();
    _passportController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // For now just navigate to result and pass some mock data
      Navigator.pushReplacementNamed(context, '/card_result', arguments: {
        'fio': _fioController.text,
        'cardNumber': '1234 5678 9012 3456',
        'account': 'BY00 1234 5678 9012 3456 0000'
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Заявка на карточку')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _fioController,
                decoration: const InputDecoration(labelText: 'ФИО'),
                validator: (v) => (v == null || v.isEmpty) ? 'Введите ФИО' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Номер телефона'),
                keyboardType: TextInputType.phone,
                validator: (v) => (v == null || v.isEmpty) ? 'Введите номер' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passportController,
                decoration: const InputDecoration(labelText: 'Номер паспорта'),
                validator: (v) => (v == null || v.isEmpty) ? 'Введите паспорт' : null,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _submit,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
                  child: Text('Подтвердить заявку', style: TextStyle(fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

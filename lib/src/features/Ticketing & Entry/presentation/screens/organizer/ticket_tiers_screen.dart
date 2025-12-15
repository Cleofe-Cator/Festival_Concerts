import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class TicketTiersScreen extends StatefulWidget {
  const TicketTiersScreen({super.key});

  @override
  State<TicketTiersScreen> createState() => _TicketTiersScreenState();
}

class _TicketTiersScreenState extends State<TicketTiersScreen> {
  final _fbKey = GlobalKey<FormBuilderState>();
  final List<Map<String, dynamic>> _tiers = [];

  void _addTier() {
    final fb = _fbKey.currentState;
    if (fb != null && fb.saveAndValidate()) {
      final values = fb.value;
      setState(() {
        _tiers.add({'name': values['name'], 'price': double.tryParse(values['price'] ?? '0') ?? 0.0, 'capacity': values['capacity']});
      });
      fb.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ticket Tiers')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            FormBuilder(
              key: _fbKey,
              child: Column(
                children: [
                  FormBuilderTextField(name: 'name', decoration: const InputDecoration(labelText: 'Tier name'), validator: FormBuilderValidators.required()),
                  FormBuilderTextField(name: 'price', decoration: const InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
                  FormBuilderTextField(name: 'capacity', decoration: const InputDecoration(labelText: 'Capacity'), keyboardType: TextInputType.number),
                  const SizedBox(height: 10),
                  ElevatedButton(onPressed: _addTier, child: const Text('Add Tier')),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _tiers.length,
                itemBuilder: (context, i) {
                  final t = _tiers[i];
                  return ListTile(
                    title: Text(t['name'] ?? ''),
                    subtitle: Text('Price: ${t['price']} · Capacity: ${t['capacity']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

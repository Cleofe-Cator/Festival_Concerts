import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import '../../../../ticketing & entry/presentation/notifier/ticketing_state.dart';
import '../../../../ticketing & entry/presentation/providers/ticketing_providers.dart'; // notifier provider

class BuyTicketScreen extends ConsumerStatefulWidget {
  final String eventId;
  const BuyTicketScreen({super.key, required this.eventId});

  @override
  ConsumerState<BuyTicketScreen> createState() => _BuyTicketScreenState();
}

class _BuyTicketScreenState extends ConsumerState<BuyTicketScreen> {
  final _fbKey = GlobalKey<FormBuilderState>();
  final List<String> _ticketTypes = ['GA', 'VIP']; // example tiers

  Future<void> _checkoutAndStore(FormBuilderState fb, WidgetRef ref) async {
    final values = fb.value;
    final ticketType = values['ticketType'] as String;
    final qty = int.tryParse((values['quantity'] ?? '1').toString()) ?? 1;

    // placeholder "checkout"
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Checkout'),
        content: Text('Purchasing $qty x $ticketType for event ${widget.eventId} (placeholder)'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
      ),
    );

    // create dummy tickets and store in notifier
    final notifier = ref.read(ticketingNotifierProvider.notifier);
    for (var i = 0; i < qty; i++) {
      final ticket = Ticket(
        id: '${widget.eventId}_${DateTime.now().millisecondsSinceEpoch}_$i',
        eventId: widget.eventId,
        holderName: 'You',
        issuedAt: DateTime.now(),
        validated: false,
        // meta can include ticketType for display
      );
      await notifier.create(ticket);
    }

    // navigate to wallet
    if (mounted) context.go('/wallet');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buy Ticket')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _fbKey,
          child: Column(
            children: [
              FormBuilderDropdown<String>(
                name: 'ticketType',
                decoration: const InputDecoration(labelText: 'Ticket Type'),
                items: _ticketTypes.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                initialValue: _ticketTypes.first,
              ),
              const SizedBox(height: 12),
              FormBuilderTextField(
                name: 'quantity',
                decoration: const InputDecoration(labelText: 'Quantity'),
                initialValue: '1',
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.min(1),
                ]),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final fb = _fbKey.currentState;
                  if (fb != null && fb.saveAndValidate()) {
                    _checkoutAndStore(fb, ref);
                  }
                },
                child: const Text('Proceed to Checkout'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

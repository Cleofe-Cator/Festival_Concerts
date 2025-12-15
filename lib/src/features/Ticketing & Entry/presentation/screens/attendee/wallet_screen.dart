import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../ticketing & entry/presentation/providers/ticketing_providers.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ticketingNotifierProvider);
    final tickets = state.tickets;
    return Scaffold(
      appBar: AppBar(title: const Text('My Wallet')),
      body: tickets.isEmpty
          ? const Center(child: Text('No tickets yet'))
          : ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, i) {
                final t = tickets[i];
                return ListTile(
                  leading: const Icon(Icons.qr_code),
                  title: Text('Ticket ${t.id.split('_').last}'),
                  subtitle: Text('${t.eventId} · ${t.holderName}'),
                  trailing: t.validated ? const Icon(Icons.check, color: Colors.green) : null,
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Ticket QR'),
                      content: SizedBox(
                        height: 180,
                        child: Center(child: Text('QR/Barcode for ${t.id}\n\n(placeholder)')),
                      ),
                      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

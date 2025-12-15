import 'package:fc_app/src/features/Event%20Discovery%20Information/presentation/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/event_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventListProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFE6F0FA), // light blue background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Upcoming Events',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: Icon(MdiIcons.menu, color: Colors.black), // 📋 MDI menu icon
            onPressed: () {
              context.push('/menu'); // ✅ still routes to menu
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, i) {
            final e = events[i];
            return InkWell(
              onTap: () => context.push('/event/${e.id}'), // ✅ view event info
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('${e.venue} · ${e.dateTime.toLocal()}',
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
  backgroundColor: const Color(0xFFD0E3F0),
  selectedItemColor: Colors.black,
  unselectedItemColor: Colors.black54,
  selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
  items: [
    BottomNavigationBarItem(
      icon: Icon(MdiIcons.wallet), // 👛 wallet icon
      label: 'My Wallet',
    ),
    BottomNavigationBarItem(
      icon: Icon(MdiIcons.cart), // 🛒 shopping cart icon
      label: 'Buy Tickets',
    ),
    BottomNavigationBarItem(
      icon: Icon(MdiIcons.calendar), // 📅 calendar icon
      label: 'Event List',
    ),
  ],
  onTap: (index) {
    switch (index) {
      case 0:
        // ✅ matches GoRoute(path: '/wallet')
        context.push('/wallet');
        break;

      case 1:
        // ✅ matches GoRoute(path: '/events/:id/buy')
        final events = ref.read(eventListProvider).value ?? [];
        if (events.isNotEmpty) {
          final firstEventId = events.first.id.toString();
          context.pushNamed(
            'buyTicket',
            pathParameters: {'id': firstEventId},
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No events available to buy tickets')),
          );
        }
        break;

      case 2:
        // ✅ matches GoRoute(path: '/events')
        context.push('/events');
        break;
    }
  },
),
    );
  }
}

extension on List<Event> {
  get value => null;
}

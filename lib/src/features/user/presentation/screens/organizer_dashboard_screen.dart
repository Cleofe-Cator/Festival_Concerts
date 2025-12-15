import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrganizerDashboardScreen extends StatelessWidget {
  const OrganizerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      {"label": "Upcoming Events", "value": "3"},
      {"label": "Attendees Registered", "value": "120"},
      {"label": "Pending Requests", "value": "5"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Organizer Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Welcome, Organizer!",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Stats cards
            Row(
              children: stats.map((stat) {
                return Expanded(
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            stat["value"]!,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            stat["label"]!,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Create Event button → uses route name from router
            ElevatedButton.icon(
              onPressed: () => context.pushNamed('organizerCreate'),
              icon: const Icon(Icons.add),
              label: const Text("Create New Event"),
            ),

            const SizedBox(height: 12),

            // Announcements button → make sure this route exists in router
            ElevatedButton.icon(
              onPressed: () => context.pushNamed('organizerAnnouncements'),
              icon: const Icon(Icons.campaign),
              label: const Text("Create Announcements"),
            ),
          ],
        ),
      ),
    );
  }
}

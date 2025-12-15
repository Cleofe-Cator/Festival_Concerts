import 'package:flutter/material.dart';

class EventDiscoveryScreen extends StatelessWidget {
  const EventDiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample event data
    final events = [
      {"title": "Tech Conference 2025", "date": "Dec 20, 2025", "location": "Manila"},
      {"title": "Music Festival", "date": "Jan 5, 2026", "location": "Cebu"},
      {"title": "Startup Pitch Night", "date": "Jan 12, 2026", "location": "Tacloban"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Event Discovery')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(event["title"]!),
              subtitle: Text("${event["date"]} • ${event["location"]}"),
              leading: const Icon(Icons.event, color: Colors.blue),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("You tapped ${event["title"]}!")),
                  );
                },
                child: const Text("Join"),
              ),
            ),
          );
        },
      ),
    );
  }
}

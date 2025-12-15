import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../providers/event_provider.dart';
import '../../providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class CreateEventScreen extends ConsumerStatefulWidget {
  const CreateEventScreen({super.key});

  @override
  ConsumerState<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final organizerId = auth.user?.id ?? 'u_org';

    return Scaffold(
      appBar: AppBar(title: const Text('Create Event')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: ListView(
            children: [
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(labelText: 'Event Name'),
                validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
              ),
              const SizedBox(height: 12),
              FormBuilderDateTimePicker(
                name: 'dateTime',
                inputType: InputType.both,
                decoration: const InputDecoration(labelText: 'Date & Time'),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 12),
              FormBuilderTextField(
                name: 'venue',
                decoration: const InputDecoration(labelText: 'Venue'),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 12),
              FormBuilderTextField(
                name: 'tickets',
                decoration: const InputDecoration(labelText: 'Tickets Available'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.integer(),
                  FormBuilderValidators.min(0),
                ]),
              ),
              const SizedBox(height: 12),
              FormBuilderTextField(
                name: 'schedule',
                decoration: const InputDecoration(labelText: 'Schedule Overview'),
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Publish Event'),
                onPressed: () {
                  final ok = _formKey.currentState?.saveAndValidate() ?? false;
                  if (!ok) return;
                  final vals = _formKey.currentState!.value;
                  ref.read(eventListProvider.notifier).createEvent(
                        name: vals['name'] as String,
                        dateTime: vals['dateTime'] as DateTime,
                        venue: vals['venue'] as String,
                        tickets: int.parse(vals['tickets'].toString()),
                        scheduleOverview: (vals['schedule'] as String?) ?? '',
                        organizerId: organizerId,
                      );
                  // after creating, go back to organizer dashboard or home
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event_model.dart';
import 'event_remote_data_source.dart';

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final FirebaseFirestore firestore;

  EventRemoteDataSourceImpl(this.firestore);

  CollectionReference get _events => firestore.collection('events');

  @override
  Future<EventModel> createEvent(EventModel event) async {
    final docRef = await _events.add(event.toMap());
    await docRef.update({'id': docRef.id});
    final snapshot = await docRef.get();
    return EventModel.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  @override
  Future<List<EventModel>> getEvents() async {
    final querySnapshot = await _events.get();
    return querySnapshot.docs
        .map((doc) => EventModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<EventModel> getEventById(String eventId) async {
    final doc = await _events.doc(eventId).get();
    if (!doc.exists) throw Exception('Event not found');
    return EventModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  @override
  Future<EventModel> updateEvent(EventModel event) async {
    await _events.doc(event.id).update(event.toMap());
    final updated = await _events.doc(event.id).get();
    return EventModel.fromMap(updated.data() as Map<String, dynamic>);
  }

  @override
  Future<void> deleteEvent(String eventId) async {
    await _events.doc(eventId).delete();
  }

  @override
  Future<EventModel> publishEvent(String eventId, bool publish) async {
    await _events.doc(eventId).update({'isPublished': publish});
    final updated = await _events.doc(eventId).get();
    return EventModel.fromMap(updated.data() as Map<String, dynamic>);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c16_mon/models/event_dm.dart';

class EventsDatabase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference<EventDm> getCollectionReference() {
    return firestore
        .collection("events")
        .withConverter(
          fromFirestore: EventDm.fromFirestore,
          toFirestore: (event, options) => event.toFirestore(),
        );
  }

  Future<void> createEvent(EventDm event) async {
    var collectionReference = getCollectionReference();
    var doc = collectionReference.doc();
    event.id = doc.id;
    await doc.set(event);
  }
}

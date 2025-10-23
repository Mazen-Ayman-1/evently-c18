import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c16_mon/core/utils/date_extention.dart';
import 'package:evently_c16_mon/models/category_dm.dart';
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

  Future<List<EventDm>> getEventsList(CategoryDm category) async {
    var collectionReference = getCollectionReference();
    var date = DateTime.now().dateOnly.millisecondsSinceEpoch;
    QuerySnapshot<EventDm> data;
    if (category.id == -1) {
      data = await collectionReference.where("date", isEqualTo: date).get();
    } else {
      data =
          await collectionReference
              .where("date", isEqualTo: date)
              .where("categoryId", isEqualTo: category.id)
              .get();
    }
    var events = data.docs.map((element) => element.data()).toList();
    return events;
  }

  Stream<QuerySnapshot<EventDm>> getEventsListStream(CategoryDm category) {
    var collectionReference = getCollectionReference();
    var date = DateTime.now().dateOnly.millisecondsSinceEpoch;
    Stream<QuerySnapshot<EventDm>> data;
    if (category.id == -1) {
      data = collectionReference.where("date", isEqualTo: date).snapshots();
    } else {
      data =
          collectionReference
              .where("date", isEqualTo: date)
              .where("categoryId", isEqualTo: category.id)
              .snapshots();
    }
    return data;
  }

  Future<void> updateEventLike(String uid, EventDm event) async {
    if (event.favoriteUsers.contains(uid)) {
      event.favoriteUsers.remove(uid);
    } else {
      event.favoriteUsers.add(uid);
    }

    var collectionReference = getCollectionReference();
    var doc = collectionReference.doc(event.id);
    await doc.update(event.toFirestore());
  }

  Stream<QuerySnapshot<EventDm>> getFavoriteStream(String uid) {
    var collectionReference = getCollectionReference();
    Stream<QuerySnapshot<EventDm>> data =
        collectionReference
            .where("favoriteUsers", arrayContains: uid)
            .snapshots();
    return data;
  }
}

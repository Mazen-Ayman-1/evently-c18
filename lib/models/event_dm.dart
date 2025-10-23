import 'package:cloud_firestore/cloud_firestore.dart';

class EventDm {
  String id;
  String title;
  String description;
  int date;
  int time;
  int categoryId;

  EventDm({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.categoryId,
  });

  factory EventDm.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() ?? <String, dynamic>{};
    return EventDm(
      id: data["id"],
      title: data["title"],
      description: data["description"],
      date: data["date"],
      time: data["time"],
      categoryId: data["categoryId"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "time": time,
      "categoryId": categoryId,
    };
  }
}

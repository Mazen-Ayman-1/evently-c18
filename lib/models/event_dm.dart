import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c16_mon/models/category_dm.dart';

class EventDm {
  String id;
  String title;
  String description;
  int date;
  int time;
  CategoryDm category;
  List<String> favoriteUsers;

  EventDm({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.category,
    this.favoriteUsers = const [],
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
      favoriteUsers:
          ((data["favoriteUsers"] ?? []) as List<dynamic>)
              .map((e) => e.toString())
              .toList(),
      category: categoriesList.firstWhere((e) => e.id == data["categoryId"]),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "time": time,
      "categoryId": category.id,
      "favoriteUsers": favoriteUsers,
    };
  }
}

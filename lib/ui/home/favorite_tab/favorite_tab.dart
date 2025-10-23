import 'package:evently_c16_mon/firebase/events_database.dart';
import 'package:evently_c16_mon/firebase/firebase_auth_service.dart';
import 'package:evently_c16_mon/ui/home/home_tab/widgets/even_card.dart';
import 'package:flutter/material.dart';

class FavoriteTab extends StatelessWidget {
  FavoriteTab({super.key});

  EventsDatabase database = EventsDatabase();
  FirebaseAuthService authService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search Favorites",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          StreamBuilder(
            stream: database.getFavoriteStream(
              authService.getUserData()?.uid ?? "",
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Expanded(
                  child: Center(
                    child: Text("Error loading events ${snapshot.error}"),
                  ),
                );
              } else if (snapshot.hasData) {
                var events =
                    snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                return Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(16),
                    separatorBuilder: (_, __) => SizedBox(height: 16),
                    itemBuilder:
                        (_, index) => EventCard(eventDm: events[index]),
                    itemCount: events.length,
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}

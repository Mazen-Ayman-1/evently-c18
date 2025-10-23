import 'package:evently_c16_mon/core/utils/date_extention.dart';
import 'package:evently_c16_mon/firebase/events_database.dart';
import 'package:evently_c16_mon/firebase/firebase_auth_service.dart';
import 'package:evently_c16_mon/models/event_dm.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final EventDm eventDm;

  const EventCard({required this.eventDm, super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 361 / 203,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(eventDm.category.imagePath)),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                eventDm.date.formatedDate,
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(child: Text(eventDm.title)),
                  InkWell(
                    onTap: onFavoritePress,
                    child: Icon(
                      eventDm.favoriteUsers.contains(
                            FirebaseAuthService().getUserData()?.uid,
                          )
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onFavoritePress() async {
    var database = EventsDatabase();
    var authService = FirebaseAuthService();
    await database.updateEventLike(
      authService.getUserData()?.uid ?? "",
      eventDm,
    );
  }
}

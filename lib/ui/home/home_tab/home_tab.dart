import 'package:evently_c16_mon/firebase/events_database.dart';
import 'package:evently_c16_mon/models/category_dm.dart';
import 'package:evently_c16_mon/ui/home/home_tab/widgets/even_card.dart';
import 'package:evently_c16_mon/ui/home/home_tab/widgets/home_header.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<CategoryDm> categories = [];
  late CategoryDm selectedCategory;

  EventsDatabase database = EventsDatabase();

  @override
  void initState() {
    super.initState();
    categories.add(CategoryDm("All", "الكل", -1, "", Icons.explore));
    categories.addAll(categoriesList);
    selectedCategory = categories.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HomeHeader(
          categoriesList: categories,
          selectedCategory: selectedCategory,
          changeSelectedCategory: changeSelectedCategory,
        ),
        // FutureBuilder(
        //   future: database.getEventsList(selectedCategory),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Expanded(
        //         child: Center(child: CircularProgressIndicator()),
        //       );
        //     } else if (snapshot.hasError) {
        //       return Expanded(
        //         child: Center(
        //           child: Text("Error loading events ${snapshot.error}"),
        //         ),
        //       );
        //     } else if (snapshot.hasData) {
        //       var events = snapshot.data ?? [];
        //       return Expanded(
        //         child: ListView.separated(
        //           padding: EdgeInsets.all(16),
        //           separatorBuilder: (_, __) => SizedBox(height: 16),
        //           itemBuilder: (_, index) => EventCard(eventDm: events[index]),
        //           itemCount: events.length,
        //         ),
        //       );
        //     } else {
        //       return SizedBox();
        //     }
        //   },
        // ),
        StreamBuilder(
          stream: database.getEventsListStream(selectedCategory),
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
                  itemBuilder: (_, index) => EventCard(eventDm: events[index]),
                  itemCount: events.length,
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }

  changeSelectedCategory(category) {
    setState(() {
      selectedCategory = category;
    });
  }
}

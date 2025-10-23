import 'package:evently_c16_mon/core/providers/app_config_provider.dart';
import 'package:evently_c16_mon/core/utils/app_dialogs_utils.dart';
import 'package:evently_c16_mon/core/utils/data_validator.dart';
import 'package:evently_c16_mon/firebase/events_database.dart';
import 'package:evently_c16_mon/models/category_dm.dart';
import 'package:evently_c16_mon/models/event_dm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ManageEventsScreen extends StatefulWidget {
  static const String routeName = "/ManageEventsScree";

  const ManageEventsScreen({super.key});

  @override
  State<ManageEventsScreen> createState() => _ManageEventsScreenState();
}

class _ManageEventsScreenState extends State<ManageEventsScreen> {
  CategoryDm selectedCategory = categoriesList.first;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Create Event")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          AspectRatio(
            aspectRatio: 361 / 203,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(selectedCategory.imagePath),
            ),
          ),
          SizedBox(height: 16),
          DefaultTabController(
            length: categoriesList.length,

            child: TabBar(
              isScrollable: true,
              indicator: null,
              indicatorColor: Colors.transparent,
              dividerHeight: 0,
              labelPadding: EdgeInsets.symmetric(horizontal: 4.0),
              indicatorPadding: EdgeInsets.zero,
              tabAlignment: TabAlignment.start,
              indicatorWeight: 1,
              onTap: (index) {
                setState(() {
                  selectedCategory = categoriesList[index];
                });
              },
              tabs:
                  categoriesList
                      .map(
                        (category) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                category.id == selectedCategory.id
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(1000),
                            border: Border.all(
                              width: 1,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                category.icon,
                                color:
                                    category.id == selectedCategory.id
                                        ? Theme.of(context).colorScheme.surface
                                        : Theme.of(context).colorScheme.primary,
                              ),
                              SizedBox(width: 8),
                              Text(
                                provider.isEn()
                                    ? category.nameEn
                                    : category.nameAr,
                                style: TextStyle(
                                  color:
                                      category.id == selectedCategory.id
                                          ? Theme.of(
                                            context,
                                          ).colorScheme.surface
                                          : Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
          SizedBox(height: 16),
          Text("Title"),
          SizedBox(height: 8),
          TextFormField(
            controller: titleController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (input) {
              return DataValidator.titleValidation(input);
            },
            decoration: InputDecoration(
              hintText: "Title",
              prefixIcon: Icon(Icons.edit),
            ),
          ),
          SizedBox(height: 16),
          Text("Description"),
          SizedBox(height: 8),
          TextFormField(
            controller: descriptionController,
            maxLines: 5,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (input) {
              return DataValidator.descriptionValidation(input);
            },
            decoration: InputDecoration(hintText: "Description"),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.date_range),
              SizedBox(width: 8),
              Text('Date'),
              Spacer(),
              InkWell(
                onTap: () {
                  getEventDate(context);
                },
                child: Text(
                  selectedDate == null
                      ? 'Choose Date'
                      : DateFormat("dd-MM-yyyy").format(selectedDate!),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.access_time),
              SizedBox(width: 8),
              Text('Time'),
              Spacer(),
              InkWell(
                onTap: () {
                  selectTime(context);
                },
                child: Text(
                  selectedTime == null
                      ? 'Choose Time'
                      : DateFormat().add_jm().format(
                        DateTime(
                          0,
                          0,
                          0,
                          selectedTime!.hour,
                          selectedTime!.minute,
                        ),
                      ),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          FilledButton(
            onPressed: () async {
              String errorMessage = "";
              if (selectedTime == null) {
                errorMessage += "\n- Select Event Time";
              }
              if (selectedDate == null) {
                errorMessage += "\n- Select Event Date";
              }
              if (titleController.text.isEmpty) {
                errorMessage += "\n- Enter Event Title";
              }
              if (descriptionController.text.isEmpty) {
                errorMessage += "\n- Enter Event Description";
              }

              if (errorMessage.isNotEmpty) {
                AppDialogsUtils.showActionDialog(
                  context: context,
                  title: "Invalid Data",
                  content: errorMessage,
                  posActionTitle: "Try Again",
                );
                return;
              }
              AppDialogsUtils.showLoadingDialog(
                context: context,
                loadingMessage: "Creating Event...",
                dismissible: false,
              );
              try {
                EventsDatabase eventsDataBase = EventsDatabase();
                await eventsDataBase.createEvent(
                  EventDm(
                    id: "",
                    title: titleController.text,
                    description: descriptionController.text,
                    date: selectedDate!.millisecondsSinceEpoch,
                    time:
                        DateTime(
                          0,
                          0,
                          0,
                          selectedTime!.hour,
                          selectedTime!.minute,
                        ).millisecondsSinceEpoch,
                    categoryId: selectedCategory.id,
                  ),
                );
                Navigator.pop(context);
                AppDialogsUtils.showActionDialog(
                  context: context,
                  title: "Success",
                  content: "Event Created Successfully",
                  posActionTitle: "Ok",
                  posAction: () {
                    Navigator.pop(context);
                  },
                );
              } catch (e) {
                Navigator.pop(context);
                AppDialogsUtils.showActionDialog(
                  context: context,
                  title: "Error",
                  content: e.toString(),
                  posActionTitle: "tryAgain",
                );
              }
            },
            child: Text("Add Event"),
          ),
        ],
      ),
    );
  }

  Future<void> selectTime(BuildContext context) async {
    var time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  Future<void> getEventDate(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: selectedDate,
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }
}

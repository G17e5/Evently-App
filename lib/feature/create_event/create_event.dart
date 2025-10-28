import 'package:event_app/UI_Utiles/Ui_Utiles.dart';
import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/core/route_manager/route_manager.dart';
import 'package:event_app/core/widgets/custom_button.dart';
import 'package:event_app/core/widgets/custom_tab_bar.dart';
import 'package:event_app/core/widgets/custom_text_button.dart';
import 'package:event_app/core/widgets/custom_text_field.dart';
import 'package:event_app/firebase_services/firebase_services.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/models/category_model.dart';
import 'package:event_app/models/event_model.dart';
import 'package:event_app/models/user_model.dart';
import 'package:event_app/providers/pick_location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  final EventModel? event;

  const CreateEvent({super.key, required this.event});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  late final TextEditingController _tileController;
  late final TextEditingController _descriptionController;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  late CategoryModel selectedCategory = CategoryModel.getCategories(context)[0];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tileController = TextEditingController();
    _descriptionController = TextEditingController();
    if (widget.event != null) {
      initEventData(widget.event!);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tileController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PickLocationProvider pickLocationProvider =
        Provider.of<PickLocationProvider>(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.event == null ? appLocalizations.create_account : "Edit Event",
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.asset(selectedCategory.imagePath),
              ),
              SizedBox(height: 16.h),
              CustomTapBar(
                onCategoryItemClicked: (category) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
                categories: CategoryModel.getCategories(context),
                selectedTaBbgColors: ColorsManager.blue,
                selectedTaFgColors: ColorsManager.whiteBlue,
                unselectedTaBbgColors: Colors.transparent,
                unselectedTaFgColors: ColorsManager.blue,
              ),
              SizedBox(height: 16.h),
              Text(
                appLocalizations.title,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                hint: appLocalizations.event_title,
                validator: (input) {},
                controller: _tileController,
                prefixIcon: Icons.edit,
              ),
              SizedBox(height: 16.h),
              Text(
                appLocalizations.description,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                hint: appLocalizations.event_description,
                validator: (input) {},
                controller: _descriptionController,
                lines: 4,
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Icon(Icons.date_range),
                  SizedBox(width: 4.w),
                  Text(
                    selectedDate.toString().substring(0, 10),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Spacer(),
                  CustomTextButton(
                    text: appLocalizations.choose_date,
                    onTap: _selectEventDate,
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              Row(
                children: [
                  Icon(Icons.access_time),
                  SizedBox(width: 4.w),
                  Text(
                    selectedTime.format(context),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Spacer(),
                  CustomTextButton(
                    text: appLocalizations.choose_time,
                    onTap: _selectEventTime,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                appLocalizations.locations,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(height: 8.h),

              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: ColorsManager.blue, width: 3.w),
                  padding: REdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, RouteManager.pickLocation);
                },
                child: Row(
                  children: [
                    Card(
                      color: ColorsManager.blue,
                      child: Padding(
                        padding: REdgeInsets.all(8),
                        child: Icon(
                          Icons.gps_fixed_outlined,
                          color: ColorsManager.whiteBlue,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        pickLocationProvider.eventLocation == null
                            ? appLocalizations.choose_event_location
                            : 'Location: ${pickLocationProvider.eventLocation?.latitude.floor()}, ${pickLocationProvider.eventLocation?.longitude.floor()}',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorsManager.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              CustomButton(
                title: widget.event == null
                    ? appLocalizations.add_event
                    : 'Updated Event',
                onPress: _createEvent,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  void _selectEventDate() async {
    selectedDate =
        await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        ) ??
        selectedDate;
    selectedDate = selectedDate.copyWith(
      hour: selectedTime.hour,
      minute: selectedDate.minute,
    );
    setState(() {});
  }

  void _createEvent() async {
    PickLocationProvider pickLocationProvider =
    Provider.of<PickLocationProvider>(context, listen: false);

    EventModel event = EventModel(
      eventId: widget.event?.eventId ?? "", // keep same ID when updating
      category: selectedCategory,
      userId: UserModel.currentUser!.id,
      title: _tileController.text,
      description: _descriptionController.text,
      dateTime: selectedDate,
      lat: pickLocationProvider.eventLocation?.latitude ?? 0,
      long: pickLocationProvider.eventLocation?.longitude ?? 0,
    );

    UIUtils.showLoading(context);

    if (widget.event == null) {
      // ✅ Create new event
      await FirebaseServices.addEventToFireStore(event, context);
      UIUtils.hideDialog(context);
      UIUtils.ShowToastMessage("Event Created Successfully", Colors.green);
    } else {
      // ✅ Update existing event
      await FirebaseServices.updatedEvent(event, context);
      UIUtils.hideDialog(context);
      UIUtils.ShowToastMessage("Event Updated Successfully", Colors.green);
    }

    // ✅ Close the page after success
    Navigator.pushNamed(context,RouteManager.mainLayout);
  }


  void _selectEventTime() async {
    selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now()) ??
        selectedTime;
    selectedDate = selectedDate.copyWith(
      hour: selectedTime.hour,
      minute: selectedTime.minute,
    );
    setState(() {});
  }
  LatLng? eventLocation;

  void initEventData(EventModel event) {
    _tileController.text = event.title;
    _descriptionController.text = event.description;
    selectedDate = event.dateTime;
    selectedTime = TimeOfDay.fromDateTime(event.dateTime);
    selectedCategory = event.category;
    eventLocation = LatLng(event.lat, event.long);

    // Update provider location for UI
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pickLocationProvider =
      Provider.of<PickLocationProvider>(context, listen: false);
      pickLocationProvider.setEventLocation(eventLocation!);
    });

    setState(() {});
  }

}

import 'package:event_app/core/resource/colors_manager/colors_manager.dart';
import 'package:event_app/core/resource/images_manager/image_manager.dart';
import 'package:event_app/core/widgets/custom_button.dart';
import 'package:event_app/core/widgets/custom_tab_bar.dart';
import 'package:event_app/core/widgets/custom_text_button.dart';
import 'package:event_app/core/widgets/custom_text_field.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  late final TextEditingController _tileController;
  late final TextEditingController _decriptionController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tileController = TextEditingController();
    _decriptionController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tileController.dispose();
    _decriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.create_account)),
      body: Padding(
        padding:  REdgeInsets.symmetric(horizontal: 8.0 , vertical: 16),
        child: SingleChildScrollView(
          child: Column(
          
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.asset(ImageAssets.birthdayLight),
              ),
              SizedBox(height: 16.h),
              CustomTapBar(
                categories: CategoryModel.getCategories(context),
                selectedTaBbgColors: ColorsManager.blue,
                selectedTaFgColors: ColorsManager.whiteBlue,
                unselectedTaBbgColors: Colors.transparent,
                unselectedTaFgColors: ColorsManager.blue,
              ),
              SizedBox(height: 16.h),
              Text(appLocalizations.title, style: Theme.of(context).textTheme.labelSmall),
              SizedBox(height: 8.h),
              CustomTextField(
                hint:appLocalizations.event_title,
                validator: (input) {},
                controller: _tileController,
                prefixIcon: Icons.edit,
              ),
              SizedBox(height: 16.h),
              Text(appLocalizations.description, style: Theme.of(context).textTheme.labelSmall),
              SizedBox(height: 8.h),
              CustomTextField(
                hint:appLocalizations.event_description,
                validator: (input) {},
                controller: _decriptionController,
                lines: 4,
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Icon(Icons.date_range),
                  SizedBox(width: 4.w,),
                  Text(appLocalizations.event_date ,style: Theme.of(context).textTheme.labelSmall,),
                  Spacer(),
                  CustomTextButton(text: appLocalizations.choose_date, onTap: (){
                    showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(2060));
                  }),
                ],
              ),
              SizedBox(height: 18.h,),
              Row(
                children: [
                  Icon(Icons.access_time),
                  SizedBox(width: 4.w,),
                  Text(appLocalizations.event_time ,style: Theme.of(context).textTheme.labelSmall,),
                  Spacer(),
                  CustomTextButton(text:appLocalizations.choose_time, onTap: (){
                    showTimePicker(context: context,initialTime: TimeOfDay.now());
                  }),
                ],
              ),
              SizedBox(height: 16.h,),
              Text(appLocalizations.locations,style: Theme.of(context).textTheme.labelSmall,),
              SizedBox(height: 8.h,),

              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: ColorsManager.blue , width: 3.w)
                    ,padding: REdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    )
                  ),
                  onPressed: (){}, child: Row(
                children: [
                  Card(
                    color: ColorsManager.blue,
                    child: Padding(
                        padding: REdgeInsets.all(8),
                            child:Icon(Icons.location_searching ,color: ColorsManager.whiteBlue,)
                    )),
                  SizedBox(width: 8.w,),
                  Text(appLocalizations.choose_event_location ,style: GoogleFonts.inter(fontSize: 16.sp ,fontWeight: FontWeight.w500,color: ColorsManager.blue),)
                ],
              )),
              SizedBox(height: 16.h,),
              CustomButton(title: appLocalizations.add_event, onPress: (){}),
              SizedBox(height: 16.h,),

          
          
          
            ],
          ),
        ),
      ),
    );
  }
}

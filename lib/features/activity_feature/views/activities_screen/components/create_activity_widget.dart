import 'package:bored_no_more/fileExport.dart';

import '../../../../../common/widgets/app_button.dart';
import '../../../../../common/widgets/regular_text_field.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../auth_feature/domain/services/auth_cubit.dart';
import '../../../domain/services/activities_cubit.dart';

class CreateActivityWidget extends StatelessWidget {
  const CreateActivityWidget({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activity = context.watch<ActivitiesCubit>();
    final auth = context.watch<AuthCubit>();

    return   Container(
      margin: EdgeInsets.only(left: 39.w, right: 39.w, top: 87.h),
      padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 20.h,bottom: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white1,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Text("Create Activity",style: Theme.of(context).textTheme.displayMedium,),
          SizedBox(height: 20.h),
          RegularTextField(
            label: "Activity name",
            controller: activity.activityNameTextController,
          ),
          SizedBox(height: 10.h),
          RegularTextField(
            label: "Time for execution",
            controller: activity.timeForExecution,
            readOnly: true,
            onTap:()async{
              await activity. showDateTimePicker(context: context).then((value) {
                Logger().w(value);
              });
            } ,
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Text("Save Activity Encrypted",style: Theme.of(context).textTheme.displayMedium,),
              Checkbox(
                value: activity.saveActivityEncrypted,
                checkColor: AppColors.white2,
                fillColor:
                MaterialStateProperty.all(Colors.black),
                onChanged: (value) {
                 activity.changeSaveEncrypted();
                },
              ),
            ],
          ),
          AppButton(
            label: "Save",
            color: AppColors.deepOrange,
            borderColor: AppColors.deepOrange,
            onTap:(){
              if (auth.plannedActivities.isEmpty) {
                activity.addPlanedActivity();
              }else{
                activity.updatePlanedActivity(auth.plannedActivities);
              }
            } ,
            width: ScreenUtil().screenWidth/2,
          ),
        ],
      ),
    );
  }
}

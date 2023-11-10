import 'package:bored_no_more/features/activity_feature/views/my_planned_activities/components/liked_activity_widget.dart';
import 'package:bored_no_more/features/auth_feature/domain/services/auth_cubit.dart';
import 'package:bored_no_more/fileExport.dart';

import '../../../../core/constants/app_colors.dart';
import 'components/planned_activity.dart';

class MyPlannedActivitiesScreen extends StatefulWidget {
  const MyPlannedActivitiesScreen({Key? key}) : super(key: key);
  static const route = "MyPlannedActivitiesScreen";

  @override
  _MyPlannedActivitiesScreenState createState() =>
      _MyPlannedActivitiesScreenState();
}

class _MyPlannedActivitiesScreenState extends State<MyPlannedActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("All Activities",
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(color: AppColors.white1)),
        elevation: 3,
        backgroundColor: AppColors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Liked Activities",style: Theme.of(context).textTheme.displayLarge,),
            SizedBox(
              height: ScreenUtil().screenHeight/2,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                return LikedActivityWidget(name: authCubit.activities[index].activity!, price: authCubit.activities[index].price!, accessibility: authCubit.activities[index].activity!, type: authCubit.activities[index].type!);
              }, separatorBuilder: (context, index) => SizedBox(height: 10.h), itemCount: authCubit.activities.length),
            ),
            const Divider(),
            Text("Planned Activities",style: Theme.of(context).textTheme.displayLarge,),
            SizedBox(
              height: ScreenUtil().screenHeight/2,
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return PlannedActivityWidget(name: authCubit.plannedActivities[index].activityName!, date:authCubit.plannedActivities[index].activityDate! ,encrypted:authCubit.plannedActivities[index].saveActivityEncrypted! ,);
                  }, separatorBuilder: (context, index) => SizedBox(height: 10.h), itemCount: authCubit.plannedActivities.length),
            ),
          ],
        ),
      ),
    );
  }
}

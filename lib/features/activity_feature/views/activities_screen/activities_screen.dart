import 'package:bored_no_more/common/widgets/app_button.dart';
import 'package:bored_no_more/common/widgets/flush_bar.dart';
import 'package:bored_no_more/common/widgets/loading_widget.dart';
import 'package:bored_no_more/core/constants/app_colors.dart';
import 'package:bored_no_more/features/activity_feature/domain/services/activities_cubit.dart';
import 'package:bored_no_more/features/activity_feature/views/my_planned_activities/my_planned_activities_screen.dart';
import 'package:bored_no_more/features/auth_feature/domain/services/auth_cubit.dart';
import 'package:bored_no_more/fileExport.dart';

import 'components/create_activity_widget.dart';
import 'components/fetched_activity_widget.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);
  static const route = "/ActivitiesScreen";

  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    context
        .read<ActivitiesCubit>()
        .getActivity(context.read<AuthCubit>().userModel!.activity!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final activity = context.watch<ActivitiesCubit>();
    final auth = context.watch<AuthCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Activities",
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
            BlocConsumer<ActivitiesCubit, ActivitiesState>(
              listener: (context, state) async{
                if (state is ActivitiesAdded) {
                  notifySuccess(context,title: "Activity Created ",message: "Activity Created successfully");
                  auth.activities.add(activity.activityModel!);
                await  context
                      .read<ActivitiesCubit>()
                      .getActivity(context.read<AuthCubit>().userModel!.activity!);
                  await auth.updateUserData("LikedActivity");
                }else if (state is ActivitiesUpdated) {
                  notifySuccess(context,title: "Activity Created ",message: "Activity Created successfully");
                  auth.activities.add(activity.activityModel!);
                  await  context
                      .read<ActivitiesCubit>()
                      .getActivity(context.read<AuthCubit>().userModel!.activity!);
                }else if (state is ActivitiesPlannedAdded) {
                  auth.plannedActivities.add(activity.plannedActivity!);
                  notifySuccess(context,title: "Activity Created ",message: "Activity Created successfully");
                  await auth.updateUserData("PlannedActivities");
                  activity.resetCreateActivity();
                }else if (state is ActivitiesPlannedUpdated) {
                  notifySuccess(context,title: "Activity Created ",message: "Activity Created successfully");
                  auth.plannedActivities.add(activity.plannedActivity!);
                  activity.resetCreateActivity();
                }
              },
              builder: (context, state) {
                if (state is ActivitiesLoading) {
                  return const LoadingWidget();
                }
                return Column(
                  children: [
                    FetchedActivityWidget(),
                    SizedBox(height: 20.h),
                    AppButton(
                      label: "My Planned Activities",
                      color: AppColors.orange3,
                      borderColor:AppColors.orange3 ,
                      onTap:(){
                        GoRouter.of(context).pushNamed(MyPlannedActivitiesScreen.route);
                      },
                    ),
                    CreateActivityWidget(),
                    SizedBox(height: 30.h),
                  ],
                );
              },
            ),

          ],
        ),
      ),
    );
  }

}

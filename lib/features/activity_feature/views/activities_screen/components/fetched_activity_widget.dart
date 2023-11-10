
import '../../../../../common/widgets/app_button.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../fileExport.dart';
import '../../../../auth_feature/domain/services/auth_cubit.dart';
import '../../../domain/services/activities_cubit.dart';

class FetchedActivityWidget extends StatelessWidget {
  const FetchedActivityWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activity = context.watch<ActivitiesCubit>();
    final auth = context.watch<AuthCubit>();

    return  Container(
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
          Table(
            textBaseline: TextBaseline.alphabetic,
            border: TableBorder.all(color: Colors.transparent),
            columnWidths: const {
              0: FlexColumnWidth(2.4),
              1: FlexColumnWidth(3),
            },
            children: [
              ///numberOf shares
              TableRow(children: [
                Text(
                  "activity :\n",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),

                Text(
                  activity.activityModel!.activity!,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.gery),
                ),
                // SizedBox(height: 14.h,),
              ]),
              TableRow(children: [
                Text(
                  "price :\n",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  " ${activity.activityModel?.price}",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.gery),
                ),
                // SizedBox(height: 14.h,),
              ]),

              TableRow(children: [
                Text(
                  "accessibility:\n",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  "${activity.activityModel?.accessibility}\n",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.gery),
                ),

                // SizedBox(height: 14.h,),
              ]),
              TableRow(children: [
                Text(
                  "type",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  "${activity.activityModel!.type}",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.gery),
                ),

                // SizedBox(height: 14.h,),
              ]),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              AppButton(
                label: "Like",
                color: AppColors.deepOrange,
                borderColor: AppColors.deepOrange,
                onTap:(){
                  if (auth.activities.isEmpty) {
                    activity.addLikedActivities(context.read<AuthCubit>().activities);
                  }else{
                    activity.updateLikedActivities(context.read<AuthCubit>().activities);
                  }
                } ,
                width: ScreenUtil().screenWidth/3.3,
              ),
              Spacer(),
              AppButton(
                label: "Dislike",
                color: AppColors.gery,
                borderColor:AppColors.gery ,
                onTap:(){
                  context
                      .read<ActivitiesCubit>()
                      .getActivity(context.read<AuthCubit>().userModel!.activity!);
                } ,
                width: ScreenUtil().screenWidth/3.3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

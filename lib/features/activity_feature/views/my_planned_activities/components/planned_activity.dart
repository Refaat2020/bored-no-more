
import 'package:bored_no_more/common/widgets/app_button.dart';
import 'package:bored_no_more/common/widgets/flush_bar.dart';
import 'package:bored_no_more/features/activity_feature/domain/services/activities_cubit.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../fileExport.dart';

class PlannedActivityWidget extends StatelessWidget {
  final String name;
  final String date;
   final bool encrypted;



   PlannedActivityWidget({required this.name,required this.date,required this.encrypted});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(left: 39.w, right: 39.w, top: 10.h),
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
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.gery),
                ),
                // SizedBox(height: 14.h,),
              ]),
              TableRow(children: [
                Text(
                  "Date :\n",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),

                Text(
                  date,
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
          if (encrypted)
            AppButton(
              label: "Decrypt",
               width: ScreenUtil().screenWidth/3,
              onTap: (){
                notifyInfo(title: Text(context.read<ActivitiesCubit>().decryptActivity(name),style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.white1),));
              },
            ),
          SizedBox(height: 10.h),

        ],
      ),
    );
  }
}

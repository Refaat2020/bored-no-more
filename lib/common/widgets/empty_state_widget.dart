

import 'package:lottie/lottie.dart';

import '../../fileExport.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({Key ?key,required this.title,this.subtitle}) : super(key: key);
  final String title;
  final Widget ?subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Lottie.asset(
              'assets/animations/empty.json',
              height: ScreenUtil().screenHeight/2.5
            )),
        SizedBox(height: 20.h,),
        Text(title,textAlign: TextAlign.center,style: Theme.of(context).textTheme.displayMedium!.copyWith(color:Colors.black,fontWeight: FontWeight.w600)),
        SizedBox(height: 15.h,),
        if (subtitle != null)
          subtitle!
      ],
    );
  }
}

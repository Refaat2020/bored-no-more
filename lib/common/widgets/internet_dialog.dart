import 'package:bored_no_more/core/constants/app_assets_roots.dart';
import 'package:lottie/lottie.dart';

import '../../fileExport.dart';

class InternetDialog extends StatelessWidget {
  const InternetDialog(
      {Key? key, required this.popUpKey, required this.connectionRestored})
      : super(key: key);
  final Key popUpKey;
  final bool connectionRestored;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: popUpKey,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      titlePadding: EdgeInsets.zero,
      title: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.clear,
                  )),
              // Text("Delete Account",style: Theme.of(context).textTheme.bodyText1,),
              const Spacer(),
            ],
          ),
          Center(
              child: Lottie.asset(
            AppImages.noInternetAnimation,
                height: ScreenUtil().screenHeight/4
          )),
          SizedBox(
            height: 30.h,
          ),
          Text(
            "No internet connection\nPlease check your internet",
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w700,fontSize: 17.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}

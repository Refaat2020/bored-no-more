import 'package:lottie/lottie.dart';

import '../../fileExport.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({Key? key, required this.title, this.subtitle})
      : super(key: key);
  final String title;
  final Widget? subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Lottie.asset(
          'assets/animations/error.json',
        )),
        SizedBox(
          height: 15.h,
        ),
        Text(title,textAlign: TextAlign.center,style: Theme.of(context).textTheme.displayMedium),
        SizedBox(
          height: 15.h,
        ),
        if (subtitle != null) subtitle!
      ],
    );
  }
}

import 'package:bored_no_more/core/constants/app_assets_roots.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset(
          AppImages.loadingAnimation,
        ));
  }
}

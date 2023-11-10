import 'package:bored_no_more/core/constants/app_assets_roots.dart';
import 'package:bored_no_more/core/constants/app_colors.dart';
import 'package:bored_no_more/features/activity_feature/views/activities_screen/activities_screen.dart';
import 'package:bored_no_more/features/auth_feature/domain/services/auth_cubit.dart';
import 'package:bored_no_more/features/auth_feature/views/registration_screen/registration_screen.dart';
import 'package:bored_no_more/fileExport.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/services/locator_services.dart';
import '../../../../core/services/notification_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const route = "/SplashScreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final NotificationServices _notificationServices = locator<NotificationServices>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notificationServices.initListener();
    Future.delayed(
      const Duration(milliseconds: 3000),
      () => context.read<AuthCubit>().getUserData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthNoUserFound) {
            GoRouter.of(context).goNamed(RegistrationScreen.route);
          } else if (state is AuthUserFound) {
            if (state .loginWithBio == true) {
              context.read<AuthCubit>().loginWithFingerprint().then((value) {
                if (value == true) {
                  GoRouter.of(context).goNamed(ActivitiesScreen.route);
                }else{
                  GoRouter.of(context).goNamed(RegistrationScreen.route);
                }
              });
            }else{
              GoRouter.of(context).goNamed(ActivitiesScreen.route);
            }
          }
          // TODO: implement listener
        },
        child: Column(
          children: [
            Lottie.asset(AppImages.splashAnimation),
            SizedBox(height: 40.h),
            Text(
              "No More Bored",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: AppColors.orange0),
            )
          ],
        ),
      ),
    );
  }
}

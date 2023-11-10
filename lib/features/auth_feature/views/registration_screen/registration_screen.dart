import 'package:bored_no_more/features/activity_feature/views/activities_screen/activities_screen.dart';
import 'package:bored_no_more/fileExport.dart';

import '../../../../common/widgets/app_button.dart';
import '../../../../common/widgets/drop_down_search.dart';
import '../../../../common/widgets/regular_text_field.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/services/auth_cubit.dart';
import 'components/registration_form_widget.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key ?key}) : super(key: key);
  static const route = "/RegistrationScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60.h),


            ///for username and password and login button
            Container(
              margin: EdgeInsets.only(left: 39.w, right: 39.w,top: 87.h),
              padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 47.h),
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
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthDone) {
                    context.read<AuthCubit>().getUserData().then((value) =>   GoRouter.of(context).goNamed(ActivitiesScreen.route));
                  }

                },
                builder: (context, state) {
                  /// show RegistrationFormWidget
                  return RegistrationFormWidget();
                },
              ),
            ),
            SizedBox(height: 25.h),


          ],
        ),
      ),
    );
  }
}

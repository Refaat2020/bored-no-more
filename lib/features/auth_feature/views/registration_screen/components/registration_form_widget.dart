import 'package:bored_no_more/fileExport.dart';

import '../../../../../common/widgets/app_button.dart';
import '../../../../../common/widgets/drop_down_search.dart';
import '../../../../../common/widgets/regular_text_field.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../domain/services/auth_cubit.dart';

class RegistrationFormWidget extends StatelessWidget {
  const RegistrationFormWidget({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();

    return Form(
      key: authCubit.formKey,
      child: Column(
        children: [
          Text("Registration", style: Theme.of(context).textTheme.displayLarge),
          SizedBox(height: 40.h),
          RegularTextField(
            keyboardType: TextInputType.name,
            hintText: "User Name",
            controller: authCubit.userNameController,
            styleController: Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColors.black1),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Enter a valid user name';
              }
              return null;
            },

          ),
          RegularTextField(
            keyboardType: TextInputType.number,
            hintText: "Age",
            controller: authCubit.ageController,

            styleController: Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColors.black1),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Enter a valid age';
              }
              return null;
            },

          ),
          SelectionBottomSheet(
            selectedItem: authCubit.selectedActivity,
            items: authCubit.listOfActivities,
            onChange: (value) {
              authCubit.selectedActivity = value;
            },
            searchHintText: "Search",
            hintText: "interests",
            enabled: true,
            itemAsString: (value) => value,
            notFound: "noResultFound",
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'You have to select one';
              }
              return null;
            },
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Login with Biometric",style: Theme.of(context).textTheme.displayMedium),
              Switch.adaptive(
                value: authCubit.loginWithBiometric,
                onChanged: (value) => authCubit.updateLoginWithBiometric(),
                activeColor: AppColors.deepOrange,
              ),
            ],
          ),
          SizedBox(height: 30.h),
          AppButton(
            width: 128.w,
            height: 60.h,
            label: "Submit",
            onTap: () {
              if (authCubit.formKey.currentState!.validate()) {
                authCubit.saveUser();
              }


            },
            color: AppColors.deepOrange,
            borderColor: AppColors.deepOrange,
            disabled:authCubit.state is AuthLoading ? true :false,
            loading: authCubit.state is AuthLoading ? true :false,
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }
}

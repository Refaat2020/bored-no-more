import 'package:bloc/bloc.dart';
import 'package:bored_no_more/core/extensions/task_excuter.dart';
import 'package:bored_no_more/features/activity_feature/data/models/activities_model/planned_activity.dart';
import 'package:bored_no_more/features/auth_feature/data/models/registration_model/registration_model.dart';
import 'package:bored_no_more/features/auth_feature/data/models/user_model/user_model.dart';
import 'package:bored_no_more/features/auth_feature/data/repo/auth_repo.dart';
import 'package:bored_no_more/fileExport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';

import '../../../../core/services/device_data.dart';
import '../../../../core/services/locator_services.dart';
import '../../../activity_feature/data/models/activities_model/activity_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final formKey = GlobalKey<FormState>();

  String?selectedActivity;
  bool loginWithBiometric = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  List<String>listOfActivities = ["education", "recreational",
    "social", "diy", "charity", "cooking", "relaxation", "music", "busywork"];
  AuthRepo authRepo = locator<AuthRepo>();
  RegistrationModel?registrationModel;
  UserModel?userModel;
  List<ActivityModel> activities= [];
  List<PlannedActivity> plannedActivities= [];
  final localAuth = LocalAuthentication();

  void updateLoginWithBiometric(){
    loginWithBiometric = !loginWithBiometric;
    emit(AuthInitial());
  }

  Future<void>saveUser()async{
    emit(AuthLoading());
    registrationModel = RegistrationModel(
     activity: selectedActivity,
      age: int.parse(ageController.text),
      loginWithBio: loginWithBiometric,
      userName: userNameController.text,
      deviceId: await DeviceData.saveDeviceInfo()
    );
    var response = authRepo.saveUserDate(registrationModel!.toMap());
    await response.excute(
      onFailed: (failed) {
        emit(AuthError(error: failed.message));
      },
      onSuccess: (value) {
        emit(AuthDone());
      },
    );
  }

  Future<void>getUserData()async{
    String? deviceId = await DeviceData.saveDeviceInfo();
    var response =   authRepo.getUserData(deviceId!);
    await response.excute(
      onFailed: (failed){
        Logger().t(failed.message);
        emit(AuthError(error: failed.message));
      },
      onSuccess: (value) async{
        if (value is Map) {
          emit(AuthNoUserFound());
          return;
        }
        userModel = value;
        if (userModel?.likedActivities != null) {
          activities =  await authRepo.getLikedActivity(userModel!.likedActivities!);
        }
        if (userModel?.plannedActivities != null) {
          plannedActivities =  await authRepo.getPlannedActivity(userModel!.plannedActivities!);
        }
        emit(AuthUserFound(userModel!.loginWithBio!));
      },
    );
  }

  Future<void>updateUserData(String collectionName)async{
    String? deviceId = await DeviceData.saveDeviceInfo();
    DocumentReference reference = FirebaseFirestore.instance.collection(collectionName).doc(deviceId);

    var response =  authRepo.updateUserData(deviceId!,{
      collectionName:reference
    });
    await response.excute(
      onFailed: (failed){
        Logger().t(failed.message);
        emit(AuthError(error: failed.message));
      },
      onSuccess: (value) async{
       Logger().i("userUpdated");
      },
    );
  }

  Future<bool> loginWithFingerprint()async{
    final isSupport = await localAuth.isDeviceSupported();
    if (isSupport == false) {
      return false;
    }
    return await localAuth.authenticate(
      localizedReason: "Scan fingerprint to login",
      options: const AuthenticationOptions(biometricOnly: false,useErrorDialogs: true,),

    );

  }

}

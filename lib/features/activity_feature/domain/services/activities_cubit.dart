import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bored_no_more/core/extensions/task_excuter.dart';
import 'package:bored_no_more/core/services/date_helper.dart';
import 'package:bored_no_more/features/activity_feature/data/models/activities_model/planned_activity.dart';
import 'package:bored_no_more/fileExport.dart';
import 'package:meta/meta.dart';
import 'package:pointycastle/export.dart';


import '../../../../core/services/device_data.dart';
import '../../../../core/services/locator_services.dart';
import '../../../../core/services/notification_services.dart';
import '../../data/models/activities_model/activity_model.dart';
import '../../data/repo/activity_repo.dart';

part 'activities_state.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  ActivitiesCubit() : super(ActivitiesInitial());

  final ActivityRepo _activityRepo = locator<ActivityRepo>();
  TextEditingController activityNameTextController = TextEditingController();
  TextEditingController timeForExecution = TextEditingController();
  DateTime?selectedTimeForExecution;
  ActivityModel?activityModel;
  PlannedActivity?plannedActivity;
  final NotificationServices _notificationServices = locator<NotificationServices>();
  bool saveActivityEncrypted = false;
  Future<void>getActivity(String activity)async{
    emit(ActivitiesLoading());
    var response =  _activityRepo.getActivities(activity);
    await response.excute(
      onFailed: (failed)=>emit(ActivitiesError(error: failed.message!)),
      onSuccess: (value) async{
        activityModel= value;
        emit(ActivitiesDone());
      },
    );
  }

  Future<void>addLikedActivities(List<ActivityModel> listOfLikedActivities)async{
    // emit(ActivitiesLoading());
    String? deviceId = await DeviceData.saveDeviceInfo();

    var response =  _activityRepo.saveLikeOrDisLikeActivity(deviceId!,
        {
          "LikedActivities":[
            activityModel!.toMap()
          ]
        },
        "LikedActivity"
        );
    await response.excute(
      onFailed: (failed){
        Logger().i(failed.message);
        emit(ActivitiesError(error: failed.message!));
      },
      onSuccess: (value) async{

        emit(ActivitiesAdded());
      },
    );
  }
  Future<void>updateLikedActivities(List<ActivityModel> listOfLikedActivities)async{
    // emit(ActivitiesLoading());
    String? deviceId = await DeviceData.saveDeviceInfo();
    if (activityModel != null) {
      listOfLikedActivities.add(activityModel!);
    }
    var response =  _activityRepo.updateLikeOrDisLikeActivity(deviceId!,
    {
      "LikedActivities":listOfLikedActivities.map<Map>((e)=> e.toMap()).toList()
    });
    await response.excute(
      onFailed: (failed){
        Logger().i(failed.message);
        emit(ActivitiesError(error: failed.message!));
      },
      onSuccess: (value) async{

        emit(ActivitiesUpdated());
      },
    );
  }

  Future<void>addPlanedActivity()async{
    String? deviceId = await DeviceData.saveDeviceInfo();
    plannedActivity = PlannedActivity(activityName:saveActivityEncrypted == false? activityNameTextController.text:encryptActivity(activityNameTextController.text),activityDate: selectedTimeForExecution.toString(),saveActivityEncrypted: saveActivityEncrypted);
    var response =  _activityRepo.saveLikeOrDisLikeActivity(deviceId!,
        {
          "plannedActivities":[
            plannedActivity!.toMap()
          ]
        },
        "PlannedActivities"
    );
    await response.excute(
      onFailed: (failed){
        Logger().i(failed.message);
        emit(ActivitiesError(error: failed.message!));
      },
      onSuccess: (value) async{
        _notificationServices.sendScheduleNotification("it's time to execute your activity", "${plannedActivity?.activityName}",selectedTimeForExecution!);

        emit(ActivitiesPlannedAdded());
      },
    );
  }
  Future<void>updatePlanedActivity(List<PlannedActivity> listOfPlannedActivities)async{
    String? deviceId = await DeviceData.saveDeviceInfo();
    plannedActivity = PlannedActivity(activityName:saveActivityEncrypted == false? activityNameTextController.text:encryptActivity(activityNameTextController.text),activityDate: selectedTimeForExecution.toString(),saveActivityEncrypted: saveActivityEncrypted);

    if (plannedActivity != null) {
      listOfPlannedActivities.add(plannedActivity!);
    }
    var response =  _activityRepo.updatePlannedActivity(deviceId!,
        {
          "plannedActivities":listOfPlannedActivities.map<Map>((e)=> e.toMap()).toList()
        });
    await response.excute(
      onFailed: (failed){
        Logger().i(failed.message);
        emit(ActivitiesError(error: failed.message!));
      },
      onSuccess: (value) async{
        _notificationServices.sendScheduleNotification("it's time to execute your activity", "${plannedActivity?.activityName}",selectedTimeForExecution!);
        emit(ActivitiesPlannedUpdated());
      },
    );
  }

  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate = DateTime.now();
    firstDate ??= DateTime.now();
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;


    final TimeOfDay? selectedTime = await showTimePicker(
      initialTime:   selectedDate.year == DateTime.now().year &&
          selectedDate.month == DateTime.now().month &&
          selectedDate.day == DateTime.now().day
     ? TimeOfDay.fromDateTime(selectedDate.copyWith(hour: DateTime.now().hour,minute: DateTime.now().minute ))
      :TimeOfDay.fromDateTime(selectedDate),
      context: context,
    );
    if (selectedTime != null) {
      selectedTimeForExecution = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      timeForExecution.text = DateHelper().formatDateStringWithDash(selectedTimeForExecution!);
    }
    return selectedTime == null
        ? selectedDate
        : DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }

  void resetCreateActivity(){
    activityNameTextController.clear();
    timeForExecution.clear();
    selectedTimeForExecution = null;
    emit(ActivitiesInitial());
  }

  void changeSaveEncrypted(){
    saveActivityEncrypted = ! saveActivityEncrypted;
    emit(ActivitiesInitial());
  }
  String encryptActivity(String activityName){
    var encryptedMessage = encryptMessage(Uint8List.fromList(activityName.codeUnits),);
    return base64Encode(encryptedMessage);
  }

 String decryptActivity(String encryptedActivityName){
    var encryptedMessage = base64Decode(encryptedActivityName);
   var decryptedMessage = decryptMessage(encryptedMessage,);
   return String.fromCharCodes(decryptedMessage);
  }

  Uint8List generateRandomKey() {
    final key = SecureRandom('AES/CTR/AUTO-SEED-PRNG');
    final seedSource = Random.secure();
    final seeds = <int>[];
    for (var i = 0; i < 32; i++) {
      seeds.add(seedSource.nextInt(255));
    }
    key.seed(KeyParameter(Uint8List.fromList(seeds)));
    final keyBytes = <int>[];
    for (var i = 0; i < 16; i++) {
      keyBytes.add(key.nextUint8());
    }
    return Uint8List.fromList(keyBytes);
  }

  Uint8List encryptMessage(Uint8List message, ) {
    final iv = Uint8List(16)..setAll(0, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
    final encrypter = StreamCipher('AES/CTR')
      ..init(true, ParametersWithIV(KeyParameter(Uint8List.fromList([212, 193, 235, 172, 178, 159, 152, 231, 222, 22, 32, 84, 130, 86, 194, 236])), iv));
    final encryptedMessage = encrypter.process(message);
     return encryptedMessage;
  }

  Uint8List decryptMessage(Uint8List message,) {
    final iv = Uint8List(16)..setAll(0, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
    final decrypter = StreamCipher('AES/CTR')
      ..init(false, ParametersWithIV(KeyParameter(Uint8List.fromList([212, 193, 235, 172, 178, 159, 152, 231, 222, 22, 32, 84, 130, 86, 194, 236])), iv));
    return decrypter.process(message);
  }




}

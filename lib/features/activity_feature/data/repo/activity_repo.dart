import 'package:bored_no_more/core/services/dio_services.dart';

import '../../../../common/model/failure_model.dart';
import '../../../../core/constants/app_urls.dart';
import '../../../../core/services/device_data.dart';
import '../../../../core/services/firestore_db.dart';
import '../../../../core/services/locator_services.dart';
import '../models/activities_model/activity_model.dart';

class ActivityRepo{
  final DioServices _dioServices = locator<DioServices>();
  FireStoreDb dp = locator<FireStoreDb>();


  Future getActivities(String selectedActivity)async{
    try{
      var response  = await _dioServices.getRequest(AppUrl.getActivity(selectedActivity),);
      var activityModel = ActivityModel.fromMap(response);
      return activityModel;
    }on FailureModel{
      rethrow;
    }
    catch(e){
      throw FailureModel(state: 0, message: e.toString(), data: e.toString());
    }
  }

  Future saveLikeOrDisLikeActivity(String deviceId,Map<String,dynamic>activity,String collectionName)async{
    try{
      String? deviceId = await DeviceData.saveDeviceInfo();
      var response = await  dp.createCollection(collectionName: collectionName,data:activity ,docName: deviceId!);
      return response;
    }on FailureModel {
      rethrow;
    }catch(e){
      throw FailureModel(state: 0, message: e.toString(), data: e.toString());
    }
  }

  Future updateLikeOrDisLikeActivity(String deviceId,Map<String,dynamic>activity)async{
    try{
      String? deviceId = await DeviceData.saveDeviceInfo();
      var response = await  dp.updateDocument(collectionName: "LikedActivity",data:activity ,docName: deviceId!);
      return response;
    }on FailureModel {
      rethrow;
    }catch(e){
      throw FailureModel(state: 0, message: e.toString(), data: e.toString());
    }
  }

  Future updatePlannedActivity(String deviceId,Map<String,dynamic>activity)async{
    try{
      String? deviceId = await DeviceData.saveDeviceInfo();
      var response = await  dp.updateDocument(collectionName: "PlannedActivities",data:activity ,docName: deviceId!);
      return response;
    }on FailureModel {
      rethrow;
    }catch(e){
      throw FailureModel(state: 0, message: e.toString(), data: e.toString());
    }
  }

}
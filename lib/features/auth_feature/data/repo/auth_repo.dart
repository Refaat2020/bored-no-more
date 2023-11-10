
import 'package:bored_no_more/core/services/firestore_db.dart';
import 'package:bored_no_more/features/activity_feature/data/models/activities_model/activity_model.dart';
import 'package:bored_no_more/features/activity_feature/data/models/activities_model/planned_activity.dart';
import 'package:bored_no_more/features/auth_feature/data/models/user_model/user_model.dart';
import 'package:bored_no_more/fileExport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../common/model/failure_model.dart';
import '../../../../core/services/device_data.dart';
import '../../../../core/services/locator_services.dart';

class AuthRepo{

  FireStoreDb repo = locator<FireStoreDb>();

  Future saveUserDate(Map<String,dynamic>userModel)async{
    try{
      var response = await  repo.createCollection(collectionName: "users",data: userModel,docName: userModel["deviceId"]);
    return response;
    }on FailureModel {
      rethrow;
    }catch(e){
      throw FailureModel(state: 0, message: e.toString(), data: e.toString());
    }
  }
  Future getUserData(String deviceId)async{
    try{
      var response = await  repo.getData(collectionName: "users",docName: deviceId);
      if (response.isEmpty) {
        return {};
      }
      var userModel = UserModel.fromMap(response);
      return userModel;
    }on FailureModel {
      rethrow;
    }catch(e){
      throw FailureModel(state: 0, message: e.toString(), data: e.toString());
    }

  }

  Future getLikedActivity(DocumentReference<Map<String, dynamic>> dc)async{

    try{
      var response = await  repo.getDocument(dc: dc);
      var list =   List<ActivityModel>.from(
          response["LikedActivities"].map((x) => ActivityModel.fromMap(x)));
      return list;
    }on FailureModel {
      rethrow;
    }catch(e){
      throw FailureModel(state: 0, message: e.toString(), data: e.toString());
    }

  }
  Future getPlannedActivity(DocumentReference<Map<String, dynamic>> dc)async{

    try{
      var response = await  repo.getDocument(dc: dc);
      Logger().t(response);
      var list =   List<PlannedActivity>.from(
          response["plannedActivities"].map((x) => PlannedActivity.fromMap(x)));
      return list;
    }on FailureModel {
      rethrow;
    }catch(e){
      throw FailureModel(state: 0, message: e.toString(), data: e.toString());
    }

  }


  Future updateUserData(String deviceId,Map<String,dynamic>userData)async{
    try{
      var response = await  repo.updateDocument(collectionName: "users",data:userData ,docName: deviceId!);
      return response;
    }on FailureModel {
      rethrow;
    }catch(e){
      throw FailureModel(state: 0, message: e.toString(), data: e.toString());
    }
  }
}
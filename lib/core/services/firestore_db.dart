import 'package:bored_no_more/fileExport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/model/failure_model.dart';

class FireStoreDb{

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future createCollection({
    required String collectionName,
   required Map<String, dynamic> data,
    String?docName
  })async{
    try{
      var response = await  db.collection(collectionName).doc(docName).set(data,);

    }on FailureModel {
      rethrow;
    }catch(e){
      throw FailureModel(state: 0, message: e.toString(), data: e.toString());
    }

  }
  Future updateDocument(
      {required String collectionName,required Map<String, dynamic> data, required String docName})async{
    try{
      var response = await  db.collection(collectionName).doc(docName).update(data);
    }on FailureModel {
      rethrow;
    }catch(e){
      throw FailureModel(state: 0, message: e.toString(), data: e.toString());
    }

  }

  Future<Map<String,dynamic>> getData(
      {required String collectionName, required String docName})async{
    try{
      var response = await  db.collection(collectionName).doc(docName).get(const GetOptions(source: Source.serverAndCache));
     return response?.data()??{};
    }on FailureModel {
      rethrow;
    }catch(e){
      throw FailureModel(state: 0, message: e.toString(), data: e.toString());
    }

  }

  Future getDocument({required DocumentReference<Map<String, dynamic>>dc})async{
    try{
      var response = await  dc.get(const GetOptions(source: Source.serverAndCache));
      return response?.data();
    }on FailureModel {
      rethrow;
    }catch(e){
      throw FailureModel(state: 0, message: e.toString(), data: e.toString());
    }

  }

}
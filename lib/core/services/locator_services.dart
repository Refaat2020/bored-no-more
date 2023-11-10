
import 'package:get_it/get_it.dart';

import '../../features/activity_feature/data/repo/activity_repo.dart';
import '../../features/auth_feature/data/repo/auth_repo.dart';
import 'dio_services.dart';
import 'firestore_db.dart';
import 'notification_services.dart';



final locator = GetIt.instance;

///how to take object from class in service locator
/// Repo repo = locator<Repo>();
void setupLocator() {
  locator.registerLazySingleton(()=> DioServices());
  locator.registerLazySingleton(()=> FireStoreDb());
  ///de repo el auth
  locator.registerLazySingleton(()=> AuthRepo());
  locator.registerLazySingleton(()=> ActivityRepo());
  locator.registerLazySingleton(()=> NotificationServices());



}
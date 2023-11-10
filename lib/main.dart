import 'package:bored_no_more/core/constants/app_theme.dart';
import 'package:bored_no_more/core/services/notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workmanager/workmanager.dart';

import 'core/config/app_cubits.dart';
import 'core/config/app_route.dart';
import 'core/config/observer.dart';
import 'core/services/interntnet_observable.dart';
import 'core/services/locator_services.dart';
import 'firebase_options.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();
  await InternetObservable.initObservable();
  setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = AppBlocObserver();
  Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false
  );
  // Periodic task registration
  Workmanager().registerPeriodicTask(
    "2",

    //This is the value that will be
    // returned in the callbackDispatcher
    "simplePeriodicTask",

    // When no frequency is provided
    // the default 15 minutes is set.
    // Minimum frequency is 15 min.
    // Android will automatically change
    // your frequency to 15 min
    // if you have configured a lower frequency.
    frequency: const Duration(minutes: 3),
  );
  runBored();
}
void runBored(){
  final app =  MultiBlocProvider(
    providers: AppCubits.appCubit(),
    child: MyApp(),
  );
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      ensureScreenSize: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          routerConfig: AppRouter.route,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: AppTheme.appTheme,
        );
      },
    );
  }
}
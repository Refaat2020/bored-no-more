
import 'package:bored_no_more/features/activity_feature/domain/services/activities_cubit.dart';
import 'package:provider/single_child_widget.dart';

import '../../features/auth_feature/domain/services/auth_cubit.dart';
import '../../fileExport.dart';



class AppCubits{

  static List<SingleChildWidget> appCubit() => [
    BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),),
    BlocProvider<ActivitiesCubit>(
      create: (context) => ActivitiesCubit(),),

  ];


}

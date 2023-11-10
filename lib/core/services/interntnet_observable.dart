import 'dart:async';


import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../common/widgets/internet_dialog.dart';
import '../../fileExport.dart';
import '../config/app_route.dart';


class InternetObservable{
  static late final  InternetConnectionChecker internetConnectionChecker;
  static late final  StreamSubscription<InternetConnectionStatus> listener;
  static final  GlobalKey noInternet = GlobalKey();
  static final  GlobalKey internetConnectionRestored = GlobalKey();

  static Future<void>initObservable()async{
    internetConnectionChecker = InternetConnectionChecker();
    await execute();
  }

  static Future<void> execute() async {
    // Simple check to see if we have Internet
    // ignore: avoid_print
    print('''The statement 'this machine is connected to the Internet' is: ''');
    final bool isConnected = await internetConnectionChecker.hasConnection;
    // ignore: avoid_print
    print(
      isConnected.toString(),
    );
    // returns a bool

    // We can also get an enum instead of a bool
    // ignore: avoid_print
    print(
      'Current status: ${await internetConnectionChecker.connectionStatus}',
    );
    // Prints either InternetConnectionStatus.connected
    // or InternetConnectionStatus.disconnected

    // actively listen for status updates
    listener =
        InternetConnectionChecker().onStatusChange.listen(
              (InternetConnectionStatus status) async{
            switch (status) {
              case InternetConnectionStatus.connected:
              // ignore: avoid_print
                if (noInternet.currentContext != null) {
                  GoRouter.of(navigatorKey.currentContext!).pop();
                }

                break;
              case InternetConnectionStatus.disconnected:
                final value = await showDialog<bool>(
                    context: navigatorKey.currentContext!,
                    builder: (BuildContext ctx) {
                      return  InternetDialog(
                        popUpKey: noInternet,
                        connectionRestored: false,

                      );
                    });
                break;
            }
          },
        );

    // close listener after 30 seconds, so the program doesn't run forever
    // await Future<void>.delayed(const Duration(seconds: 30));
    // await listener.cancel();
  }

  Future<void> dispose()async{
    await listener.cancel();
  }

}
import 'package:dartz/dartz.dart';

import '../../common/model/failure_model.dart';
import '../services/interntnet_observable.dart';
import 'task_fail_mapper.dart';

extension TaskExcuter<T> on Future<T> {
  //TODO add excute multible futures
  Future<void> excute({
    bool onlyIfConnected = false,
    Function(FailureModel failed)? onFailed,
    Function(T value) ?onSuccess,
  }) async {
    if (onlyIfConnected && !await InternetObservable.internetConnectionChecker.hasConnection) {
      try {
        if (onFailed != null) await onFailed(FailureModel(state: 1, message: "cannot connect to network", data: "cannot connect to network"));
      } catch (e) {
        print(e);
      }
    } else {
      return await Task(() => this).attempt().mapFailure().run().then((o) {
        return o.fold(
              (f) async {
            try {
              if (onFailed != null) await onFailed(f);
            } catch (e) {
              print(e);
            }
          },
              (s) async {
            try {
              if (onSuccess != null) await onSuccess(s);
            } catch (e) {
              print(e);
            }
          },
        );
      });
    }
  }
}

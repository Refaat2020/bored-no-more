import 'package:dio/dio.dart';
import '../../common/model/failure_model.dart';

extension ResponseHandler on Response {
  dynamic handleResponse() async {
    if (statusCode == 500 ) {
      throw FailureModel(message:"Sorry, something went wrong. Please try again later.",state:statusCode,data: data );
    }
    else if (statusCode! >201 &&statusMessage != "Unauthorized" ) {
      if (data is Map) {
        throw FailureModel(message:data["error"],state:statusCode,data: data.toString() );
      }
      throw FailureModel(message:data.toString(),state:statusCode,data: data.toString() );
    }
    else {
      return data;
    }
  }
}

extension DioExceptionHandler on DioException {
  String handleDioException(DioExceptionType dioExceptionType)  {
    switch (dioExceptionType) {
      case DioExceptionType.connectionTimeout:
        return"Sorry, something went wrong. Please try again later.";
      case DioExceptionType.sendTimeout:
        return "Sorry, something went wrong. Please try again later.";
      case DioExceptionType.receiveTimeout:
        return "Sorry, something went wrong. Please try again later.";
      case DioExceptionType.badCertificate:
        return "Sorry, something went wrong. Please try again later.""Sorry, something went wrong. Please try again later.";
      case DioExceptionType.badResponse:
        return "Sorry, something went wrong. Please try again later.";
      case DioExceptionType.cancel:
        return "Sorry, something went wrong. Please try again later.";
      case DioExceptionType.connectionError:
        return "Sorry, something went wrong. Please try again later.";
      case DioExceptionType.unknown:
        return"Sorry, something went wrong. Please try again later.";

    }

  }
}

import 'package:dio/dio.dart';
abstract class Failure {
  final String errMessage;
  Failure({required this.errMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errMessage});
  factory ServerFailure.fromDioError(DioException dioException ) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errMessage: 'connection timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errMessage: 'send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errMessage: 'receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure(errMessage: 'receive timeout with ApiServer');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException .response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure(errMessage: ' request with ApiServer was canceld');
      case DioExceptionType.connectionError:
        return ServerFailure(errMessage: 'no internet connection');
      case DioExceptionType.unknown:
        return ServerFailure(errMessage: 'Unexpected Error,Please try again!');    
    }
  }
  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(errMessage: response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure(
          errMessage: 'Your request not found, please try later!');
    } else if (statusCode == 500) {
      return ServerFailure(
          errMessage: 'Internal Server error, please try later!');
    } else {
      return ServerFailure(
          errMessage: 'opps there was an error, please try later!');
    }
  }
}

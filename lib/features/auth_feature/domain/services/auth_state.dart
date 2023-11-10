part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthDone extends AuthState {}
class AuthNoUserFound extends AuthState {}
class AuthUserFound extends AuthState {
 final bool loginWithBio;

  AuthUserFound(this.loginWithBio);
}
class AuthUserDataDone extends AuthState {}
class AuthError extends AuthState {
  final String?error;

  AuthError({this.error});
}

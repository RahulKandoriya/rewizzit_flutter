import 'package:meta/meta.dart';

@immutable
class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;


  LoginState({
    @required this.isLoading,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory LoginState.empty() {
    return LoginState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.loading() {
    return LoginState(
      isLoading: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.failure() {
    return LoginState(
      isLoading: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isLoading: false,
      isSuccess: true,
      isFailure: false,
    );
  }


  @override
  String toString() {
    return '''LoginState {
      isSubmitting: $isLoading,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
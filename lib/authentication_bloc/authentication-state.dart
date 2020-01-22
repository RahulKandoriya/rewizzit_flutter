import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  ///final String displayName;

  const Authenticated();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Authenticated { displayName: }';
}

class Unauthenticated extends AuthenticationState {}
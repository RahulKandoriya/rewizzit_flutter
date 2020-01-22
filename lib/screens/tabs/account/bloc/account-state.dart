import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class Loading extends AccountState {}

class Loaded extends AccountState {

}

class Failure extends AccountState {}
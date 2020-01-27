import 'package:meta/meta.dart';

@immutable
class AddNodeState {
  final bool isTitleValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isTitleValid;

  AddNodeState({
    @required this.isTitleValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory AddNodeState.empty() {
    return AddNodeState(
      isTitleValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory AddNodeState.loading() {
    return AddNodeState(
      isTitleValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory AddNodeState.failure() {
    return AddNodeState(
      isTitleValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory AddNodeState.success() {
    return AddNodeState(
      isTitleValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  AddNodeState update({
    bool isTitleValid,
  }) {
    return copyWith(
      isTitleValid: isTitleValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  AddNodeState copyWith({
    bool isTitleValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return AddNodeState(
      isTitleValid: isTitleValid ?? this.isTitleValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''AddNodeState {
      isTitleValid: $isTitleValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
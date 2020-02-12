import 'package:meta/meta.dart';

@immutable
class EditNodeState {
  final bool isTitleValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isTitleValid;

  EditNodeState({
    @required this.isTitleValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory EditNodeState.empty() {
    return EditNodeState(
      isTitleValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory EditNodeState.loading() {
    return EditNodeState(
      isTitleValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory EditNodeState.failure() {
    return EditNodeState(
      isTitleValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory EditNodeState.success() {
    return EditNodeState(
      isTitleValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  EditNodeState update({
    bool isTitleValid,
  }) {
    return copyWith(
      isTitleValid: isTitleValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  EditNodeState copyWith({
    bool isTitleValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return EditNodeState(
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
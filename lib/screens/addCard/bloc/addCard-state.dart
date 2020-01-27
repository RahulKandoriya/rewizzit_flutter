import 'package:meta/meta.dart';

@immutable
class AddCardState {
  final bool isTitleValid;
  final bool isContentValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isTitleValid && isContentValid;

  AddCardState({
    @required this.isTitleValid,
    @required this.isContentValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory AddCardState.empty() {
    return AddCardState(
      isTitleValid: true,
      isContentValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory AddCardState.loading() {
    return AddCardState(
      isTitleValid: true,
      isContentValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory AddCardState.failure() {
    return AddCardState(
      isTitleValid: true,
      isContentValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory AddCardState.success() {
    return AddCardState(
      isTitleValid: true,
      isContentValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  AddCardState update({
    bool isTitleValid,
    bool isContentValid,
  }) {
    return copyWith(
      isTitleValid: isTitleValid,
      isContentValid: isContentValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  AddCardState copyWith({
    bool isTitleValid,
    bool isContentValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return AddCardState(
      isTitleValid: isTitleValid ?? this.isTitleValid,
      isContentValid: isContentValid ?? this.isContentValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''AddCardState {
      isTitleValid: $isTitleValid,
      isContentValid: $isContentValid,      
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
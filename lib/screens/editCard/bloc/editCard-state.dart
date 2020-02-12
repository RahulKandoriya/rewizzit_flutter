import 'package:meta/meta.dart';

@immutable
class EditCardState {
  final bool isTitleValid;
  final bool isContentValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isTitleValid && isContentValid;

  EditCardState({
    @required this.isTitleValid,
    @required this.isContentValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory EditCardState.empty() {
    return EditCardState(
      isTitleValid: true,
      isContentValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory EditCardState.loading() {
    return EditCardState(
      isTitleValid: true,
      isContentValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory EditCardState.failure() {
    return EditCardState(
      isTitleValid: true,
      isContentValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory EditCardState.success() {
    return EditCardState(
      isTitleValid: true,
      isContentValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  EditCardState update({
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

  EditCardState copyWith({
    bool isTitleValid,
    bool isContentValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return EditCardState(
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
import 'package:meta/meta.dart';

@immutable
class AddCollectionState {
  final bool isTitleValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isTitleValid;

  AddCollectionState({
    @required this.isTitleValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory AddCollectionState.empty() {
    return AddCollectionState(
      isTitleValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory AddCollectionState.loading() {
    return AddCollectionState(
      isTitleValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory AddCollectionState.failure() {
    return AddCollectionState(
      isTitleValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory AddCollectionState.success() {
    return AddCollectionState(
      isTitleValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  AddCollectionState update({
    bool isTitleValid,
  }) {
    return copyWith(
      isTitleValid: isTitleValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  AddCollectionState copyWith({
    bool isTitleValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return AddCollectionState(
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
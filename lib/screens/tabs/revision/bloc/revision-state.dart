import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rewizzit/data/models/api_response/revision-controls-get-response.dart';
import 'package:rewizzit/data/models/api_response/revision-controls-post-response.dart';

abstract class RevisionState extends Equatable {
  const RevisionState();

  @override
  List<Object> get props => [];
}

class Loading extends RevisionState {}

class RevisionControlsLoaded extends RevisionState {

  final RevisionControlsGetResponse revisionControlsGetResponse;

  const RevisionControlsLoaded({@required this.revisionControlsGetResponse});

  @override
  List<Object> get props => [revisionControlsGetResponse];

  @override
  String toString() => 'Loaded { items: ${revisionControlsGetResponse.data} }';

}

class PostRevisionControlsLoaded extends RevisionState {


  final RevisionControlsPostResponse revisionControlsPostResponse;

  const PostRevisionControlsLoaded({@required this.revisionControlsPostResponse});

  @override
  List<Object> get props => [revisionControlsPostResponse];

  @override
  String toString() => 'Loaded { items: ${revisionControlsPostResponse.data} }';

}

class Failure extends RevisionState {}
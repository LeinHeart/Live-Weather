import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  final String message;

  ServerFailure({@required this.message});

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => [];
}

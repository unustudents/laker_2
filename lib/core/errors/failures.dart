// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String msg;

  const Failure(this.msg);
  @override
  List<Object?> get props => [msg];
}

class ServerFailure extends Failure {
  const ServerFailure(super.msg);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.msg);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure(super.msg);
}

class CacheFailure extends Failure {
  const CacheFailure(super.msg);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.msg);
}

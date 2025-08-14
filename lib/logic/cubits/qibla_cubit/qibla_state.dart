part of 'qibla_cubit.dart';

abstract class QiblaState {}

class QiblaLoading extends QiblaState {
  @override
  String toString() => "Loading";
}

class QiblaSuccess extends QiblaState {
  final double angle;

  QiblaSuccess(this.angle);

  @override
  String toString() => "Success";
}

class QiblaFailure extends QiblaState {
  final String message;

  QiblaFailure({required this.message});

  @override
  String toString() => "Failure";
}

part of 'splash_cubit.dart';

abstract class SplashState {}

final class SplashInitial extends SplashState {
  @override
  String toString() => "Initial";
}

final class SplashLoading extends SplashState {
  @override
  String toString() => "Loading";
}

final class SplashFinished extends SplashState {
  @override
  String toString() => "Finished";
}

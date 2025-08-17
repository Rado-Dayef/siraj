part of 'azkar_cubit.dart';

abstract class AzkarState {}

final class AzkarLoading extends AzkarState {
  @override
  String toString() => "Loading";
}

final class AzkarSuccess extends AzkarState {
  List<AzkarModel> azkar;

  AzkarSuccess({required this.azkar});

  @override
  String toString() => "Success";
}

final class AzkarFailure extends AzkarState {
  String message;

  AzkarFailure({required this.message});

  @override
  String toString() => "Failure";
}

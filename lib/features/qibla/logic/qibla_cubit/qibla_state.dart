part of 'qibla_cubit.dart';

@freezed
class QiblaState with _$QiblaState {
  const factory QiblaState.loading() = loading;

  const factory QiblaState.success({required double angle}) = success;

  const factory QiblaState.failure({required String message}) = failure;
}

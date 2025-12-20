import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:location/location.dart';
import 'package:siraj/core/services/location_services.dart';
import 'package:siraj/core/utils/extensions/string_extension.dart';

part 'qibla_cubit.freezed.dart';
part 'qibla_state.dart';

class QiblaCubit extends Cubit<QiblaState> {
  QiblaCubit() : super(const QiblaState.loading()) {
    getQibla();
  }

  double kaabaLat = 21.4225;
  double kaabaLon = 39.8262;

  StreamSubscription<CompassEvent>? compassSubscription;
  double? qiblaDirection;
  double currentAngle = 0;

  Future<void> getQibla() async {
    try {
      dynamic location = await LocationServices.getCurrentLocation();

      if (location is LocationData) {
        qiblaDirection = calculateBearing(location.latitude!, location.longitude!, kaabaLat, kaabaLon);
        startQibla(location);
        if (!isClosed) {
          emit(QiblaState.success(angle: currentAngle));
        }
      } else {
        location.toString().showToast;
        emit(QiblaState.failure(message: location.toString()));
      }
    } catch (error) {
      error.toString().showToast;
      emit(QiblaState.failure(message: error.toString()));
    }
  }

  void startQibla(location) {
    compassSubscription?.cancel();

    compassSubscription = FlutterCompass.events?.listen(
      (event) {
        if (event.heading != null && qiblaDirection != null) {
          final target = (qiblaDirection! - event.heading!) * (pi / 180);
          final normalized = normalizeAngle(target, currentAngle);
          currentAngle = currentAngle + (normalized - currentAngle) * 0.2;
          if (!isClosed) {
            emit(QiblaState.success(angle: currentAngle));
          }
        }
      },
      onError: (error) {
        error.toString().showToast;
        emit(QiblaState.failure(message: error.toString()));
      },
    );
  }

  double calculateBearing(double lat1, double lon1, double lat2, double lon2) {
    double dLon = (lon2 - lon1) * pi / 180;
    lat1 = lat1 * pi / 180;
    lat2 = lat2 * pi / 180;

    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    double bearing = atan2(y, x);
    return ((bearing * 180 / pi) + 360) % 360;
  }

  double normalizeAngle(double target, double previous) {
    double diff = target - previous;
    if (diff > pi) diff -= 2 * pi;
    if (diff < -pi) diff += 2 * pi;
    return previous + diff;
  }

  @override
  Future<void> close() {
    compassSubscription?.cancel();
    return super.close();
  }
}

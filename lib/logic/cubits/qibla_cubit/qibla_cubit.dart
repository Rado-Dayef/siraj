import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/services/location_services.dart';

part 'qibla_state.dart';

//
// class QiblaCubit extends Cubit<QiblaState> {
//   QiblaCubit() : super(QiblaLoading()) {
//     initialize();
//   }
//
//   StreamSubscription<CompassEvent>? _compassSubscription;
//   double? qiblaDirection;
//   double currentAngle = 0;
//
//   Future<void> initialize() async {
//     try {
//       QiblaLoading loadingState = QiblaLoading();
//       emit(loadingState);
//
//       final location = await LocationService.getCurrentLocation();
//       const kaabaLat = 21.4225;
//       const kaabaLon = 39.8262;
//
//       qiblaDirection = calculateBearing(location.latitude!, location.longitude!, kaabaLat, kaabaLon);
//
//       startCompass();
//
//       emit(QiblaSuccess(0));
//     } catch (error) {
//       error.toString().showToast;
//       QiblaFailure failureState = QiblaFailure(message: error.toString());
//       emit(failureState);
//     }
//   }
//
//   void startCompass() {
//     _compassSubscription?.cancel();
//
//     _compassSubscription = FlutterCompass.events?.listen(
//       (event) {
//         if (event.heading != null && qiblaDirection != null) {
//           final target = (qiblaDirection! - event.heading!) * (pi / 180);
//           final normalized = _normalizeAngle(target, currentAngle);
//           currentAngle = normalized;
//           QiblaSuccess successState = QiblaSuccess(normalized);
//           emit(successState);
//         }
//       },
//       onError: (error) {
//         error.toString().showToast;
//         QiblaFailure failureState = QiblaFailure(message: error.toString());
//         emit(failureState);
//       },
//     );
//   }
//
//   double calculateBearing(double lat1, double lon1, double lat2, double lon2) {
//     double dLon = (lon2 - lon1) * pi / 180;
//     lat1 = lat1 * pi / 180;
//     lat2 = lat2 * pi / 180;
//
//     double y = sin(dLon) * cos(lat2);
//     double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
//     double bearing = atan2(y, x);
//     return ((bearing * 180 / pi) + 360) % 360;
//   }
//
//   double _normalizeAngle(double target, double previous) {
//     double diff = target - previous;
//     if (diff > pi) diff -= 2 * pi;
//     if (diff < -pi) diff += 2 * pi;
//     return previous + diff;
//   }
//
//   @override
//   Future<void> close() {
//     _compassSubscription?.cancel();
//     return super.close();
//   }
// }

class QiblaCubit extends Cubit<QiblaState> {
  QiblaCubit() : super(QiblaLoading()) {
    getQibla();
  }

  StreamSubscription<CompassEvent>? compassSubscription;
  double? qiblaDirection;
  double currentAngle = 0;

  Future<void> getQibla() async {
    try {
      QiblaLoading loadingState = QiblaLoading();
      emit(loadingState);

      final location = await LocationService.getCurrentLocation();
      const kaabaLat = 21.4225;
      const kaabaLon = 39.8262;

      qiblaDirection = calculateBearing(location.latitude!, location.longitude!, kaabaLat, kaabaLon);
      startQibla();
      QiblaSuccess successState = QiblaSuccess(currentAngle);
      emit(successState);
    } catch (error) {
      error.toString().showToast;
      QiblaFailure failureState = QiblaFailure(message: error.toString());
      emit(failureState);
    }
  }

  void startQibla() {
    compassSubscription?.cancel();

    compassSubscription = FlutterCompass.events?.listen(
      (event) {
        if (event.heading != null && qiblaDirection != null) {
          final target = (qiblaDirection! - event.heading!) * (pi / 180);
          final normalized = normalizeAngle(target, currentAngle);
          currentAngle = currentAngle + (normalized - currentAngle) * 0.2;
          QiblaSuccess successState = QiblaSuccess(currentAngle);
          emit(successState);
        }
      },
      onError: (error) {
        error.toString().showToast;
        QiblaFailure failureState = QiblaFailure(message: error.toString());
        emit(failureState);
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
}

import 'package:siraj/core/shared/models/azkar_model.dart';
import 'package:siraj/features/azkar/logic/azkar_cubit/azkar_cubit.dart';

class AzkarArgsModel {
  final AzkarModel azkar;
  final AzkarCubit cubit;

  AzkarArgsModel({required this.azkar, required this.cubit});
}

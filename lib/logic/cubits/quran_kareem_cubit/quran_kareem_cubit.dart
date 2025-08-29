import 'package:flutter_bloc/flutter_bloc.dart';

part 'quran_kareem_state.dart';

class QuranKareemCubit extends Cubit<QuranKareemState> {
  QuranKareemCubit() : super(QuranKareemInitial());
}

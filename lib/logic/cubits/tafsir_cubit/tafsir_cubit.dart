import 'package:flutter_bloc/flutter_bloc.dart';

part 'tafsir_state.dart';

class TafsirCubit extends Cubit<TafsirState> {
  TafsirCubit() : super(TafsirInitial());
}

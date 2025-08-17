import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class DrawerCubit extends Cubit<ZoomDrawerController> {
  DrawerCubit() : super(ZoomDrawerController());

  void toggleDrawer() {
    state.toggle?.call();
  }

  void openDrawer() {
    state.open?.call();
  }

  void closeDrawer() {
    state.close?.call();
  }
}

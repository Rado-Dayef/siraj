import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_numkit/flutter_numkit.dart';

abstract class QuranKareemLazyLoadCubit<T, S> extends Cubit<S> {
  QuranKareemLazyLoadCubit(this.loadingState) : super(loadingState) {
    _init();
  }

  int _currentIndex = 0;
  final int batchSize = 10;
  bool _isLoadingMore = false;

  final List<T> _visibleItems = [];

  final ScrollController controller = ScrollController();

  List<T> get allItems;

  T fromJson(Map<String, dynamic> json);

  S loadingState;

  S successState(List<T> items);

  S failureState(String message);

  Future<void> _init() async {
    controller.addListener(_onScroll);
    await _loadFullItems();
  }

  void _onScroll() {
    if (!controller.hasClients) return;
    final position = controller.position;
    if (position.pixels >= position.maxScrollExtent) {
      loadMoreItems();
    }
  }

  Future<void> _loadFullItems() async {
    try {
      loadMoreItems();
    } catch (e) {
      emit(failureState(e.toString()));
    }
  }

  void loadMoreItems() {
    if (_isLoadingMore) return;
    if (_currentIndex >= allItems.length) return;

    _isLoadingMore = true;
    final end = (_currentIndex + batchSize).clamp(0, allItems.length);
    _visibleItems.addAll(allItems.sublist(_currentIndex, end));
    _currentIndex = end;
    Future.delayed(1.sec, () => emit(successState(List.unmodifiable(_visibleItems))));
    _isLoadingMore = false;
  }

  Future<void> reset({bool withReload = false}) async {
    int lastCurrentIndexValue = _currentIndex;
    _currentIndex = 0;
    _isLoadingMore = false;
    _visibleItems.clear();
    if (controller.hasClients) {
      controller.jumpTo(0);
    }
    emit(loadingState);
    if (withReload && lastCurrentIndexValue != 0) {
      reload();
    }
  }

  Future<void> reload() async {
    await _loadFullItems();
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}

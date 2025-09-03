import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/slider_model.dart';

class SlidersState {
  final List<SliderModel> sliders;
  final bool isLoading;
  final String? error;

  const SlidersState({
    this.sliders = const [],
    this.isLoading = false,
    this.error,
  });

  SlidersState copyWith({
    List<SliderModel>? sliders,
    bool? isLoading,
    String? error,
  }) {
    return SlidersState(
      sliders: sliders ?? this.sliders,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class SlidersNotifier extends StateNotifier<SlidersState> {
  SlidersNotifier() : super(const SlidersState());

  // Load sliders
  Future<void> loadSliders() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Empty sliders list - will be populated by admin actions
      final sliders = <SliderModel>[];

      state = state.copyWith(
        sliders: sliders,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Add slider
  Future<void> addSlider(SliderModel slider) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      final newSlider = slider.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final updatedSliders = [...state.sliders, newSlider];

      state = state.copyWith(
        sliders: updatedSliders,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Update slider
  Future<void> updateSlider(String sliderId, SliderModel slider) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      final updatedSliders = state.sliders.map((s) {
        if (s.id == sliderId) {
          return slider.copyWith(
            id: sliderId,
            updatedAt: DateTime.now(),
          );
        }
        return s;
      }).toList();

      state = state.copyWith(
        sliders: updatedSliders,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Delete slider
  Future<void> deleteSlider(String sliderId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      final updatedSliders =
          state.sliders.where((s) => s.id != sliderId).toList();

      state = state.copyWith(
        sliders: updatedSliders,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Reorder sliders
  Future<void> reorderSliders(List<SliderModel> reorderedSliders) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Update order for each slider
      final updatedSliders = reorderedSliders.asMap().entries.map((entry) {
        return entry.value.copyWith(
          order: entry.key,
          updatedAt: DateTime.now(),
        );
      }).toList();

      state = state.copyWith(
        sliders: updatedSliders,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Get slider by ID
  SliderModel? getSliderById(String sliderId) {
    try {
      return state.sliders.firstWhere((s) => s.id == sliderId);
    } catch (e) {
      return null;
    }
  }

  // Get active sliders sorted by order
  List<SliderModel> get activeSliders {
    return state.sliders
        .where((s) => s.isActive && !s.isDeleted)
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));
  }
}

final slidersProvider =
    StateNotifierProvider<SlidersNotifier, SlidersState>((ref) {
  return SlidersNotifier();
});

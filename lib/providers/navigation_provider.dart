import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_provider.g.dart';

@riverpod
class NavigationIndex extends _$NavigationIndex {
  @override
  int build() {
    return 0; // Default to home page
  }

  void updateIndex(int index) {
    state = index;
  }
}

enum NavigationTab {
  home(0, 'Ana Sayfa'),
  categories(1, 'Kategoriler'),
  favorites(2, 'Favoriler'),
  cart(3, 'Sepet'),
  profile(4, 'Profil');

  const NavigationTab(this.tabIndex, this.label);

  final int tabIndex;
  final String label;
}

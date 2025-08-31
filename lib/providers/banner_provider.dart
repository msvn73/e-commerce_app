import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/banner_item.dart';

part 'banner_provider.g.dart';

@riverpod
class Banners extends _$Banners {
  @override
  List<BannerItem> build() {
    return _sampleBanners;
  }
}

// Sample banner data
final List<BannerItem> _sampleBanners = [
  const BannerItem(
    id: '1',
    title: 'Yeni Koleksiyon',
    subtitle: 'En son trendleri keşfedin',
    imageUrl:
        'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=800',
  ),
  const BannerItem(
    id: '2',
    title: 'Özel Seri',
    subtitle: 'İlk yenileme için',
    imageUrl:
        'https://images.unsplash.com/photo-1472851294608-062f824d29cc?w=800',
  ),
  const BannerItem(
    id: '3',
    title: 'Yaz İndirimi',
    subtitle: 'Seçili ürünlerde %70\'e varan indirim',
    imageUrl:
        'https://images.unsplash.com/photo-1607083206869-4c7672e72a8a?w=800',
  ),
];

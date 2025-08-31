import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/product.dart';

part 'products_provider.g.dart';

@riverpod
class Products extends _$Products {
  @override
  List<Product> build() {
    return _sampleProducts;
  }

  List<Product> getProductsByCategory(String category) {
    if (category == 'Tümü') return state;
    return state.where((product) => product.category == category).toList();
  }

  List<Product> getFavoriteProducts() {
    return state.where((product) => product.isFavorite).toList();
  }

  List<Product> searchProducts(String query) {
    if (query.isEmpty) return state;
    return state
        .where(
          (product) =>
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.description.toLowerCase().contains(query.toLowerCase()) ||
              product.category.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}

// Sample products data
final List<Product> _sampleProducts = [
  const Product(
    id: '1',
    name: 'Klasik Beyaz T-Shirt',
    description:
        'Yüksek kaliteli pamuktan üretilmiş, rahat ve şık bir t-shirt. Günlük kullanım için idealdir.',
    price: 89.99,
    imageUrl:
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
    category: 'T-Shirt',
    availableSizes: ['S', 'M', 'L', 'XL'],
    availableColors: ['Beyaz', 'Siyah', 'Gri'],
    rating: 4.5,
    reviewCount: 128,
  ),
  const Product(
    id: '2',
    name: 'Premium Pamuk Sweatshirt',
    description:
        'Soğuk havalarda sıcak tutacak, premium kalitede pamuk sweatshirt. Rahat kesim ve modern tasarım.',
    price: 249.99,
    imageUrl: 'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=400',
    category: 'Alışveriş',
    availableSizes: ['M', 'L', 'XL', 'XXL'],
    availableColors: ['Kahverengi', 'Siyah', 'Gri'],
    rating: 4.8,
    reviewCount: 89,
  ),
  const Product(
    id: '3',
    name: 'Casual Kot Ceket',
    description:
        'Her kombine uyum sağlayacak klasik kot ceket. Dayanıklı kumaş ve zamansız tasarım.',
    price: 299.99,
    imageUrl: 'https://images.unsplash.com/photo-1544022613-e87ca75a784a?w=400',
    category: 'Popüler',
    availableSizes: ['S', 'M', 'L'],
    availableColors: ['Mavi', 'Siyah'],
    rating: 4.3,
    reviewCount: 67,
  ),
  const Product(
    id: '4',
    name: 'Yaz Çiçekli Elbise',
    description:
        'Hafif ve ferah kumaştan üretilmiş, yaz ayları için ideal çiçek desenli elbise.',
    price: 199.99,
    imageUrl:
        'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=400',
    category: 'Kadın',
    availableSizes: ['XS', 'S', 'M', 'L'],
    availableColors: ['Pembe', 'Beyaz', 'Mavi'],
    rating: 4.6,
    reviewCount: 94,
  ),
  const Product(
    id: '5',
    name: 'Erkek Klasik Gömlek',
    description:
        'İş ve özel günler için uygun, kaliteli kumaştan üretilmiş klasik erkek gömleği.',
    price: 149.99,
    imageUrl:
        'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=400',
    category: 'Erkek',
    availableSizes: ['M', 'L', 'XL'],
    availableColors: ['Beyaz', 'Mavi', 'Siyah'],
    rating: 4.4,
    reviewCount: 156,
  ),
  const Product(
    id: '6',
    name: 'Spor Koşu Ayakkabısı',
    description:
        'Koşu ve günlük aktiviteler için tasarlanmış, rahat ve dayanıklı spor ayakkabısı.',
    price: 399.00,
    imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
    category: 'Popüler',
    availableSizes: ['38', '39', '40', '41', '42'],
    availableColors: ['Siyah', 'Beyaz', 'Kırmızı'],
    rating: 4.7,
    reviewCount: 203,
  ),
];

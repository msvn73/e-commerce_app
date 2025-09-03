import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/sales_model.dart';

class DemoService {
  static const String _categoriesKey = 'demo_categories';
  static const String _productsKey = 'demo_products';
  static const String _salesKey = 'demo_sales';

  // Categories
  static Future<List<CategoryModel>> getCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final categoriesJson = prefs.getStringList(_categoriesKey) ?? [];

    if (categoriesJson.isEmpty) {
      // Generate initial demo categories
      final demoCategories = _generateDemoCategories();
      await saveCategories(demoCategories);
      return demoCategories;
    }

    return categoriesJson
        .map((json) => CategoryModel.fromJson(jsonDecode(json)))
        .toList();
  }

  static Future<void> saveCategories(List<CategoryModel> categories) async {
    final prefs = await SharedPreferences.getInstance();
    final categoriesJson =
        categories.map((category) => jsonEncode(category.toJson())).toList();
    await prefs.setStringList(_categoriesKey, categoriesJson);
  }

  static Future<void> addCategory(CategoryModel category) async {
    final categories = await getCategories();
    final newCategory = category.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    categories.add(newCategory);
    await saveCategories(categories);
  }

  static Future<void> updateCategory(
      String categoryId, CategoryModel updatedCategory) async {
    final categories = await getCategories();
    final index = categories.indexWhere((cat) => cat.id == categoryId);
    if (index != -1) {
      categories[index] = updatedCategory.copyWith(
        id: categoryId,
        updatedAt: DateTime.now(),
      );
      await saveCategories(categories);
    }
  }

  static Future<void> deleteCategory(String categoryId) async {
    final categories = await getCategories();
    categories.removeWhere((cat) => cat.id == categoryId);
    await saveCategories(categories);
  }

  // Products
  static Future<List<ProductModel>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson = prefs.getStringList(_productsKey) ?? [];

    if (productsJson.isEmpty) {
      // Generate initial demo products
      final demoProducts = _generateDemoProducts();
      await saveProducts(demoProducts);
      return demoProducts;
    }

    return productsJson
        .map((json) => ProductModel.fromJson(jsonDecode(json)))
        .toList();
  }

  static Future<void> saveProducts(List<ProductModel> products) async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson =
        products.map((product) => jsonEncode(product.toJson())).toList();
    await prefs.setStringList(_productsKey, productsJson);
  }

  static Future<void> addProduct(ProductFormData formData) async {
    final products = await getProducts();
    final newProduct = ProductModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: formData.name,
      description: formData.description,
      price: formData.price,
      stock: formData.stock,
      categoryId: formData.categoryId.isEmpty ? null : formData.categoryId,
      images: formData.images,
      videos: formData.videos,
      isActive: formData.isActive,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    products.add(newProduct);
    await saveProducts(products);
  }

  static Future<void> updateProduct(
      String productId, ProductFormData formData) async {
    final products = await getProducts();
    final index = products.indexWhere((product) => product.id == productId);
    if (index != -1) {
      products[index] = products[index].copyWith(
        name: formData.name,
        description: formData.description,
        price: formData.price,
        stock: formData.stock,
        categoryId: formData.categoryId.isEmpty ? null : formData.categoryId,
        images: formData.images,
        videos: formData.videos,
        isActive: formData.isActive,
        updatedAt: DateTime.now(),
      );
      await saveProducts(products);
    }
  }

  static Future<void> deleteProduct(String productId) async {
    final products = await getProducts();
    products.removeWhere((product) => product.id == productId);
    await saveProducts(products);
  }

  // Sales
  static Future<List<SalesModel>> getSales() async {
    final prefs = await SharedPreferences.getInstance();
    final salesJson = prefs.getStringList(_salesKey) ?? [];

    if (salesJson.isEmpty) {
      // Generate initial demo sales
      final demoSales = _generateDemoSales();
      await saveSales(demoSales);
      return demoSales;
    }

    return salesJson
        .map((json) => SalesModel.fromJson(jsonDecode(json)))
        .toList();
  }

  static Future<void> saveSales(List<SalesModel> sales) async {
    final prefs = await SharedPreferences.getInstance();
    final salesJson = sales.map((sale) => jsonEncode(sale.toJson())).toList();
    await prefs.setStringList(_salesKey, salesJson);
  }

  static Future<void> addSale(SalesModel sale) async {
    final sales = await getSales();
    final newSale = sale.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    sales.add(newSale);
    await saveSales(sales);
  }

  // Demo data generators
  static List<CategoryModel> _generateDemoCategories() {
    return [
      CategoryModel(
        id: '1',
        name: 'Elektronik',
        description: 'Elektronik ürünler',
        icon: 'electronics',
        color: 'FF6B35',
        isActive: true,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      CategoryModel(
        id: '2',
        name: 'Giyim',
        description: 'Giyim ürünleri',
        icon: 'fashion',
        color: '4ECDC4',
        isActive: true,
        createdAt: DateTime.now().subtract(const Duration(days: 25)),
        updatedAt: DateTime.now().subtract(const Duration(days: 25)),
      ),
      CategoryModel(
        id: '3',
        name: 'Ev & Yaşam',
        description: 'Ev ve yaşam ürünleri',
        icon: 'home',
        color: '45B7D1',
        isActive: true,
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
        updatedAt: DateTime.now().subtract(const Duration(days: 20)),
      ),
    ];
  }

  static List<ProductModel> _generateDemoProducts() {
    return [
      ProductModel(
        id: '1',
        name: 'iPhone 15 Pro',
        description: 'Apple iPhone 15 Pro 128GB',
        price: 45000.0,
        stock: 10,
        categoryId: '1',
        images: [
          'https://via.placeholder.com/300x300/FF6B35/FFFFFF?text=iPhone'
        ],
        videos: [],
        isActive: true,
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        updatedAt: DateTime.now().subtract(const Duration(days: 15)),
      ),
      ProductModel(
        id: '2',
        name: 'Samsung Galaxy S24',
        description: 'Samsung Galaxy S24 256GB',
        price: 35000.0,
        stock: 15,
        categoryId: '1',
        images: [
          'https://via.placeholder.com/300x300/4ECDC4/FFFFFF?text=Galaxy'
        ],
        videos: [],
        isActive: true,
        createdAt: DateTime.now().subtract(const Duration(days: 12)),
        updatedAt: DateTime.now().subtract(const Duration(days: 12)),
      ),
      ProductModel(
        id: '3',
        name: 'Nike Air Max',
        description: 'Nike Air Max 270 Erkek Ayakkabı',
        price: 2500.0,
        stock: 25,
        categoryId: '2',
        images: ['https://via.placeholder.com/300x300/45B7D1/FFFFFF?text=Nike'],
        videos: [],
        isActive: true,
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        updatedAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
    ];
  }

  static List<SalesModel> _generateDemoSales() {
    final random = Random();
    final now = DateTime.now();
    final sales = <SalesModel>[];

    // Generate sales for the last 30 days
    for (int i = 0; i < 30; i++) {
      final date = now.subtract(Duration(days: i));
      final salesCount = random.nextInt(3) + 1; // 1-3 sales per day

      for (int j = 0; j < salesCount; j++) {
        final productNames = [
          'iPhone 15 Pro',
          'Samsung Galaxy S24',
          'Nike Air Max',
        ];

        final productName = productNames[random.nextInt(productNames.length)];
        final price = productName == 'iPhone 15 Pro'
            ? 45000.0
            : productName == 'Samsung Galaxy S24'
                ? 35000.0
                : 2500.0;
        final quantity = random.nextInt(2) + 1;
        final totalAmount = price * quantity;

        final paymentMethods = [
          'Kredi Kartı',
          'Banka Kartı',
          'Nakit',
          'Havale'
        ];

        sales.add(SalesModel(
          id: 'sale_${i}_$j',
          productId: 'product_${random.nextInt(3) + 1}',
          productName: productName,
          price: price,
          quantity: quantity,
          totalAmount: totalAmount,
          customerName: 'Müşteri ${random.nextInt(1000)}',
          customerEmail: 'musteri${random.nextInt(1000)}@email.com',
          customerPhone: '+90 5${random.nextInt(100000000)}',
          paymentMethod: paymentMethods[random.nextInt(paymentMethods.length)],
          status: 'completed',
          saleDate: date,
          createdAt: date,
          updatedAt: date,
        ));
      }
    }

    return sales;
  }

  // Clear all demo data
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_categoriesKey);
    await prefs.remove(_productsKey);
    await prefs.remove(_salesKey);
  }
}

# E-Commerce Uygulaması Kurulum Rehberi

## 🚀 Özellikler

### ✅ Tamamlanan Özellikler
- **Ana Sayfa**: Uygulama açılışta ana sayfaya yönlendirir
- **Profil Yönetimi**: Giriş yapmamış kullanıcılar için giriş/kayıt seçenekleri
- **Google Girişi**: Google hesabı ile hızlı giriş
- **Admin Paneli**: Kategori, ürün ve sipariş yönetimi
- **Supabase Entegrasyonu**: Tüm veriler veritabanında saklanır
- **Oturum Yönetimi**: Giriş durumu korunur

### 🔐 Admin Hesabı
- **Email**: `admin@admin.com`
- **Şifre**: `admin123`

## 📋 Kurulum Adımları

### 1. Supabase Kurulumu

1. [Supabase](https://supabase.com) hesabı oluşturun
2. Yeni bir proje oluşturun
3. `supabase_schema_updated.sql` dosyasını SQL Editor'de çalıştırın
4. Admin kullanıcısını oluşturun:
   ```sql
   -- Auth'da admin@admin.com kullanıcısını oluşturun
   -- Sonra bu komutu çalıştırın:
   UPDATE profiles SET is_admin = true WHERE email = 'admin@admin.com';
   ```

### 2. Supabase Ayarları

1. Project Settings > API'den URL ve anon key'i alın
2. `lib/config/app_config.dart` dosyasını güncelleyin:
   ```dart
   class AppConfig {
     static const String supabaseUrl = 'YOUR_SUPABASE_URL';
     static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
     // ... diğer ayarlar
   }
   ```

### 3. Flutter Bağımlılıkları

```bash
flutter pub get
```

### 4. Uygulamayı Çalıştırma

```bash
flutter run
```

## 🎯 Kullanım Senaryoları

### Giriş Yapmadan
- Ana sayfaya erişim ✅
- Ürünleri görüntüleme ✅
- Profil sayfasında giriş/kayıt seçenekleri ✅

### Normal Kullanıcı Girişi
- Tüm sayfalara erişim ✅
- Sepete ürün ekleme ✅
- Sipariş verme ✅
- Profil yönetimi ✅

### Admin Girişi
- **Email**: `admin@admin.com`
- **Şifre**: `admin123`
- Admin paneline erişim ✅
- Kategori yönetimi ✅
- Ürün yönetimi ✅
- Sipariş yönetimi ✅

## 📱 Sayfa Yapısı

### Ana Sayfa
- Slider ve kampanyalar
- Kategori listesi
- Öne çıkan ürünler
- Giriş durumu göstergesi

### Profil Sayfası
- **Giriş yapmamış**: Giriş/kayıt seçenekleri
- **Giriş yapmış**: Kullanıcı bilgileri ve seçenekler
- **Admin**: Admin panel erişimi

### Admin Paneli
- **Ana Sayfa**: İstatistikler ve hızlı işlemler
- **Ürünler**: Ürün ekleme, düzenleme, silme
- **Kategoriler**: Kategori yönetimi
- **Siparişler**: Sipariş listesi ve durum yönetimi

## 🗄️ Veritabanı Yapısı

### Tablolar
- `profiles`: Kullanıcı profilleri
- `categories`: Ürün kategorileri
- `products`: Ürünler
- `cart_items`: Sepet öğeleri
- `orders`: Siparişler
- `order_items`: Sipariş detayları
- `wishlist`: İstek listesi
- `addresses`: Kullanıcı adresleri

### Güvenlik
- Row Level Security (RLS) aktif
- Kullanıcılar sadece kendi verilerine erişebilir
- Adminler tüm verilere erişebilir
- Public kategoriler ve ürünler herkes tarafından görülebilir

## 🔧 Geliştirme Notları

### Session Yönetimi
- `SessionProvider` ile oturum durumu yönetilir
- Admin ve normal kullanıcı ayrımı yapılır
- Giriş durumu tüm uygulamada korunur

### Router Güvenliği
- Admin sayfaları sadece adminlere açık
- Diğer sayfalar herkese açık
- Giriş yapmadan da gezinebilir

### Veri Kaydetme
- Tüm işlemler Supabase'e kaydedilir
- Hiçbir veri kaybolmaz
- Gerçek zamanlı güncellemeler

## 🚨 Önemli Notlar

1. **Supabase Kurulumu**: Veritabanı şemasını mutlaka çalıştırın
2. **Admin Hesabı**: İlk admin kullanıcısını manuel oluşturun
3. **API Anahtarları**: Supabase URL ve key'lerini güncelleyin
4. **Güvenlik**: RLS politikaları aktif, güvenli

## 📞 Destek

Herhangi bir sorun yaşarsanız:
1. Supabase bağlantısını kontrol edin
2. Veritabanı şemasının doğru çalıştığını kontrol edin
3. API anahtarlarının doğru olduğunu kontrol edin

---

**Not**: Bu uygulama tam fonksiyonel bir e-ticaret uygulamasıdır. Tüm veriler Supabase veritabanında güvenli şekilde saklanır ve hiçbir veri kaybolmaz.

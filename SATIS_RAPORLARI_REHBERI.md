# Satış Raporları Rehberi

## Özellikler

### 📊 Satış Raporları Sistemi
Uygulamanıza kapsamlı bir satış raporları sistemi eklendi. Bu sistem gelecekte satış verilerine göre otomatik olarak grafikler ve analizler oluşturacak.

### 🎯 Ana Özellikler

#### 1. **Genel Bakış Sekmesi**
- **Temel Metrikler**: Toplam gelir, sipariş sayısı, satılan ürün miktarı, ortalama sipariş değeri
- **Gelir Trendi Grafiği**: Son 30 günlük satış trendini gösteren çizgi grafik
- **Ödeme Yöntemleri Grafiği**: Hangi ödeme yöntemlerinin ne kadar kullanıldığını gösteren bar grafik

#### 2. **Günlük Satışlar Sekmesi**
- **Satış Trendi**: Son 30 günlük detaylı satış grafiği
- **Günlük Detaylar Tablosu**: Her gün için satış miktarı ve gelir bilgileri

#### 3. **Kategori Analizi Sekmesi**
- **Pasta Grafik**: Kategoriler arası satış dağılımı
- **Kategori Detayları**: Her kategori için satış miktarı ve yüzde bilgileri

### 🛠️ Nasıl Kullanılır

#### Satış Ekleme
1. Admin panelinde "Ana Sayfa" sekmesine gidin
2. "Hızlı İşlemler" bölümünden "Satış Ekle" butonuna tıklayın
3. Müşteri bilgilerini doldurun
4. Ürün seçin ve miktar girin
5. Ödeme yöntemini seçin
6. "Satışı Kaydet" butonuna tıklayın

#### Raporları Görüntüleme
1. Admin panelinde "Raporlar" sekmesine gidin
2. Üç farklı sekme arasında geçiş yapın:
   - **Genel Bakış**: Temel metrikler ve genel grafikler
   - **Günlük Satışlar**: Günlük trend analizi
   - **Kategori Analizi**: Kategori bazında dağılım

### 📈 Grafik Türleri

#### 1. **Çizgi Grafik (Line Chart)**
- Günlük satış trendlerini gösterir
- Zaman içindeki değişimleri takip etmek için idealdir

#### 2. **Pasta Grafik (Pie Chart)**
- Kategori bazında satış dağılımını gösterir
- Her kategorinin toplam satıştaki payını yüzde olarak gösterir

#### 3. **Bar Grafik (Bar Chart)**
- Ödeme yöntemlerinin kullanım oranlarını gösterir
- Karşılaştırma yapmak için idealdir

### 🔄 Otomatik Güncelleme
- Satış eklendiğinde raporlar otomatik olarak güncellenir
- Grafikler gerçek zamanlı olarak yenilenir
- Yeni veriler anında tüm analizlere yansır

### 📊 Demo Veriler
Şu anda sistem demo verilerle çalışmaktadır. Gerçek satış verileri eklendikçe:
- Demo veriler gerçek verilerle değiştirilecek
- Grafikler gerçek satış verilerine göre güncellenecek
- Tüm metrikler gerçek değerleri gösterecek

### 🎨 Görsel Özellikler
- **Renkli Grafikler**: Her kategori ve ödeme yöntemi için farklı renkler
- **Responsive Tasarım**: Tüm ekran boyutlarında uyumlu
- **Modern UI**: Material Design prensiplerine uygun arayüz
- **Kolay Okunabilirlik**: Büyük fontlar ve net etiketler

### 🔧 Teknik Detaylar

#### Kullanılan Kütüphaneler
- **fl_chart**: Grafik oluşturma için
- **Riverpod**: State management için
- **Supabase**: Veritabanı işlemleri için

#### Veri Yapısı
```dart
SalesModel {
  - productId: Ürün ID'si
  - productName: Ürün adı
  - price: Birim fiyat
  - quantity: Miktar
  - totalAmount: Toplam tutar
  - customerName: Müşteri adı
  - paymentMethod: Ödeme yöntemi
  - saleDate: Satış tarihi
}
```

### 🚀 Gelecek Özellikler
- **Tarih Aralığı Seçimi**: Belirli tarih aralıkları için rapor
- **PDF Export**: Raporları PDF olarak dışa aktarma
- **Email Raporları**: Otomatik email raporları
- **Gelişmiş Filtreler**: Kategori, ürün, müşteri bazında filtreleme
- **Karşılaştırma Grafikleri**: Dönemler arası karşılaştırma

### 📱 Mobil Uyumluluk
- Tüm grafikler mobil cihazlarda mükemmel çalışır
- Touch gesture'lar desteklenir
- Responsive tasarım sayesinde her ekran boyutunda uyumlu

### 🎯 Kullanım Senaryoları
1. **Günlük Satış Takibi**: Her gün satış performansını izleyin
2. **Kategori Analizi**: Hangi kategorilerin daha çok satıldığını görün
3. **Ödeme Yöntemi Analizi**: Müşterilerin hangi ödeme yöntemlerini tercih ettiğini öğrenin
4. **Trend Analizi**: Satış trendlerini takip edin ve gelecek planlaması yapın

Bu sistem sayesinde işletmenizin satış performansını detaylı bir şekilde analiz edebilir ve veri odaklı kararlar alabilirsiniz.

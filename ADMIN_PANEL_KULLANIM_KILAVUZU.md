# 🎯 Admin Paneli Kullanım Kılavuzu

## 📱 Admin Paneline Giriş

### 🔐 Giriş Bilgileri
- **Kullanıcı Adı:** `admin`
- **Şifre:** `admin123`

### 🚀 Giriş Yapma Adımları
1. **Uygulamayı Açın**
2. **Admin Giriş:** `admin@admin.com` / `admin123` ile normal giriş yapın
3. **Otomatik Yönlendirme:** Admin paneline otomatik olarak yönlendirileceksiniz
4. **Bottom Navigation:** Admin giriş yaptığında gizlenir

---

## 🛍️ Ürün Yönetimi

### ➕ Yeni Ürün Ekleme

#### **Adım 1: Ürünler Sayfasına Git**
- Admin panelinde sol menüden **"Ürünler"** sekmesine tıklayın
- **"Yeni Ürün Ekle"** butonuna tıklayın

#### **Adım 2: Ürün Bilgilerini Doldur**
```
📝 Ürün Adı: Örnek: "Samsung Galaxy S24"
💰 Fiyat: Örnek: "25000"
📋 Açıklama: Ürünün detaylı açıklaması
🏷️ Kategori: Elektronik, Giyim, Ev & Yaşam, vb.
📸 Resim URL: Ürün resminin internet adresi
📦 Stok Miktarı: Kaç adet stokta olduğu
⭐ Değerlendirme: 1-5 arası puan
```

#### **Adım 3: Kaydet**
- **"Ürün Ekle"** butonuna tıklayın
- Ürün başarıyla eklenecek

### ✏️ Mevcut Ürün Düzenleme

#### **Adım 1: Ürünü Bul**
- Ürünler listesinde düzenlemek istediğiniz ürünü bulun
- Ürünün yanındaki **"Düzenle"** butonuna tıklayın

#### **Adım 2: Bilgileri Güncelle**
- İstediğiniz alanları değiştirin:
  - ✅ Ürün adı
  - ✅ Fiyat
  - ✅ Açıklama
  - ✅ Kategori
  - ✅ Resim URL
  - ✅ Stok miktarı
  - ✅ Değerlendirme

#### **Adım 3: Değişiklikleri Kaydet**
- **"Güncelle"** butonuna tıklayın
- Değişiklikler kaydedilecek

### 🗑️ Ürün Silme

#### **Adım 1: Ürünü Seç**
- Silmek istediğiniz ürünü bulun
- **"Sil"** butonuna tıklayın

#### **Adım 2: Onayla**
- Silme işlemini onaylayın
- ⚠️ **Dikkat:** Bu işlem geri alınamaz!

---

## 📊 Admin Panel Özellikleri

### 🏠 Ana Sayfa (Overview)
- **Toplam Satış:** Günlük, haftalık, aylık satış rakamları
- **Aktif Kullanıcılar:** Online kullanıcı sayısı
- **Toplam Ürün:** Stoktaki ürün sayısı
- **Bekleyen Siparişler:** Onay bekleyen sipariş sayısı

### 🛒 Sipariş Yönetimi
- **Tüm Siparişler:** Müşteri siparişlerini görüntüleme
- **Sipariş Durumu:** Hazırlanıyor, Kargoda, Teslim Edildi
- **Sipariş Detayları:** Ürün listesi, adres, ödeme bilgileri
- **Durum Güncelleme:** Sipariş durumunu değiştirme

### 👥 Kullanıcı Yönetimi
- **Kullanıcı Listesi:** Tüm kayıtlı kullanıcılar
- **Kullanıcı Detayları:** Profil bilgileri, sipariş geçmişi
- **Kullanıcı Durumu:** Aktif/Pasif yapma
- **Kullanıcı Silme:** Hesap silme işlemi

### ⚙️ Ayarlar
- **Uygulama Ayarları:** Genel uygulama konfigürasyonu
- **Bildirim Ayarları:** Push notification ayarları
- **Güvenlik:** Şifre değiştirme, güvenlik ayarları
- **Yedekleme:** Veri yedekleme ve geri yükleme

---

## 🎨 Resim Yönetimi

### 📸 Ürün Resmi Ekleme/Değiştirme

#### **Yöntem 1: URL ile Resim Ekleme**
```
1. İnternetten ürün resminin URL'sini kopyalayın
2. Ürün ekleme/düzenleme formunda "Resim URL" alanına yapıştırın
3. Kaydedin
```

#### **Yöntem 2: Yerel Resim Kullanma**
```
1. Resmi assets/images/ klasörüne kopyalayın
2. pubspec.yaml'da assets listesine ekleyin
3. Kodda resim yolunu belirtin
```

### 🖼️ Resim Önerileri
- **Boyut:** 400x400 piksel (kare format)
- **Format:** JPG, PNG
- **Kalite:** Yüksek çözünürlük
- **İçerik:** Ürünü net gösteren, arka plan temiz

---

## 🔧 Teknik Bilgiler

### 📱 Admin Panel Erişimi
- **URL:** `/admin` (otomatik yönlendirme)
- **Kimlik Doğrulama:** Email tabanlı (`admin@admin.com`)
- **Oturum:** Giriş yapana kadar aktif

### 🗄️ Veri Yönetimi
- **Veritabanı:** Supabase
- **Gerçek Zamanlı:** Değişiklikler anında yansır
- **Yedekleme:** Otomatik yedekleme sistemi

### 🔒 Güvenlik
- **Şifre:** Güçlü şifre kullanın
- **Oturum:** Güvenli çıkış yapın
- **Erişim:** Sadece yetkili kişiler

---

## 🚨 Sorun Giderme

### ❌ Giriş Yapamıyorum
- **Kontrol Edin:** Kullanıcı adı ve şifre doğru mu?
- **Format:** `admin@admin.com` / `admin123`
- **Çözüm:** Uygulamayı yeniden başlatın

### ❌ Ürün Eklenmiyor
- **Kontrol Edin:** Tüm alanlar dolduruldu mu?
- **Resim URL:** Geçerli bir URL mi?
- **Çözüm:** Formu temizleyip tekrar deneyin

### ❌ Değişiklikler Kaydedilmiyor
- **Kontrol Edin:** İnternet bağlantısı var mı?
- **Çözüm:** Sayfayı yenileyin ve tekrar deneyin

---

## 📞 Destek

### 🆘 Yardım Gerekiyor mu?
- **Teknik Destek:** Geliştirici ekibi ile iletişime geçin
- **Kullanım Soruları:** Bu kılavuzu tekrar okuyun
- **Hata Bildirimi:** Sorunları detaylı olarak rapor edin

### 📋 Kontrol Listesi
- ✅ Admin giriş bilgileri doğru
- ✅ İnternet bağlantısı aktif
- ✅ Tüm form alanları dolduruldu
- ✅ Resim URL'si geçerli
- ✅ Değişiklikler kaydedildi

---

**🎉 Admin paneli başarıyla kullanıma hazır!**
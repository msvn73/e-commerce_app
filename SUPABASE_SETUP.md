# Supabase Kurulum Talimatları

Bu dosya, e-ticaret uygulamasını Supabase ile entegre etmek için gerekli adımları içerir.

## 1. Supabase Projesi Oluşturma

1. [Supabase](https://supabase.com) sitesine gidin
2. "Start your project" butonuna tıklayın
3. GitHub ile giriş yapın
4. "New Project" butonuna tıklayın
5. Proje adını girin (örn: "e-commerce-app")
6. Veritabanı şifresini belirleyin ve kaydedin
7. Bölge seçin (Türkiye için en yakın bölgeyi seçin)
8. "Create new project" butonuna tıklayın

## 2. Proje Ayarları

### API Anahtarlarını Alma
1. Proje dashboard'unda "Settings" > "API" sekmesine gidin
2. "Project URL" ve "anon public" anahtarını kopyalayın
3. Bu bilgileri `lib/config/supabase_config.dart` dosyasına ekleyin:

```dart
static const String supabaseUrl = 'YOUR_PROJECT_URL';
static const String supabaseAnonKey = 'YOUR_ANON_KEY';
```

### Authentication Ayarları
1. "Authentication" > "Settings" sekmesine gidin
2. "Site URL" alanına uygulamanızın URL'ini ekleyin
3. "Redirect URLs" alanına callback URL'leri ekleyin:
   - `com.example.ecommerce://login-callback`
   - `http://localhost:3000/auth/callback`

## 3. Veritabanı Şemasını Oluşturma

1. "SQL Editor" sekmesine gidin
2. `supabase_schema.sql` dosyasının içeriğini kopyalayın
3. SQL Editor'da yapıştırın ve "Run" butonuna tıklayın
4. Tüm tablolar, indeksler ve RLS politikaları oluşturulacak

## 4. Storage Bucket Oluşturma

1. "Storage" sekmesine gidin
2. "New bucket" butonuna tıklayın
3. Bucket adını girin: "product-images"
4. "Public bucket" seçeneğini işaretleyin
5. "Create bucket" butonuna tıklayın

### Storage Politikaları
Storage bucket için RLS politikaları ekleyin:

```sql
-- Herkes ürün resimlerini görüntüleyebilir
CREATE POLICY "Public Access" ON storage.objects
FOR SELECT USING (bucket_id = 'product-images');

-- Sadece authenticated kullanıcılar resim yükleyebilir
CREATE POLICY "Authenticated users can upload" ON storage.objects
FOR INSERT WITH CHECK (
  bucket_id = 'product-images' 
  AND auth.role() = 'authenticated'
);

-- Sadece resim sahibi silebilir
CREATE POLICY "Users can delete own images" ON storage.objects
FOR DELETE USING (
  bucket_id = 'product-images' 
  AND auth.uid()::text = (storage.foldername(name))[1]
);
```

## 5. Flutter Uygulamasında Test

1. Bağımlılıkları yükleyin:
```bash
flutter pub get
```

2. Uygulamayı çalıştırın:
```bash
flutter run
```

3. Konsol çıktısında "Supabase başarıyla başlatıldı" mesajını görmelisiniz

## 6. Güvenlik Kontrolleri

### RLS Politikaları
- Tüm tablolarda RLS etkin olmalı
- Kullanıcılar sadece kendi verilerini görebilmeli
- Kategoriler ve ürünler herkese açık olmalı

### API Anahtarları
- `anon` anahtarı public olabilir
- `service_role` anahtarını asla client tarafında kullanmayın
- Production'da environment variables kullanın

## 7. Environment Variables (Production)

Production ortamında API anahtarlarını environment variables olarak saklayın:

```bash
# .env dosyası
SUPABASE_URL=your_project_url
SUPABASE_ANON_KEY=your_anon_key
```

```dart
// lib/config/supabase_config.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

static const String supabaseUrl = String.fromEnvironment(
  'SUPABASE_URL',
  defaultValue: 'YOUR_SUPABASE_URL',
);

static const String supabaseAnonKey = String.fromEnvironment(
  'SUPABASE_ANON_KEY',
  defaultValue: 'YOUR_SUPABASE_ANON_KEY',
);
```

## 8. Hata Ayıklama

### Yaygın Hatalar

1. **Connection Error**: URL ve anahtar doğru mu kontrol edin
2. **RLS Policy Error**: Tablolarda RLS etkin mi kontrol edin
3. **Authentication Error**: Auth ayarlarını kontrol edin
4. **Permission Denied**: RLS politikalarını kontrol edin

### Debug Modu
Development sırasında debug modunu etkinleştirin:

```dart
await Supabase.initialize(
  url: SupabaseConfig.supabaseUrl,
  anonKey: SupabaseConfig.supabaseAnonKey,
  debug: true, // Development sırasında
);
```

## 9. Monitoring ve Analytics

1. **Dashboard**: Supabase dashboard'unda real-time metrikleri izleyin
2. **Logs**: SQL Editor'da query loglarını kontrol edin
3. **Performance**: Database performance metriklerini izleyin

## 10. Backup ve Recovery

1. **Automatic Backups**: Supabase otomatik günlük backup alır
2. **Manual Backup**: SQL Editor'da veritabanını export edin
3. **Point-in-time Recovery**: Belirli bir zamana geri dönün

## Destek

Sorun yaşarsanız:
1. Supabase [Discord](https://discord.supabase.com) kanalına katılın
2. [GitHub Issues](https://github.com/supabase/supabase/issues) sayfasını kontrol edin
3. [Documentation](https://supabase.com/docs) sayfasını inceleyin

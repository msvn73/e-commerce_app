# Supabase Setup Guide

## The Problem
The error you're seeing is because the application is trying to connect to `your-project.supabase.co` which is a placeholder URL, not your actual Supabase project.

## Solution: Configure Your Supabase Credentials

### Step 1: Get Your Supabase Credentials

1. Go to your [Supabase Dashboard](https://supabase.com/dashboard)
2. Select your project (or create a new one if you don't have one)
3. Go to **Settings** → **API**
4. Copy the following values:
   - **Project URL** (looks like: `https://abcdefghijklmnop.supabase.co`)
   - **anon public key** (a long string starting with `eyJ...`)

### Step 2: Update Your App Configuration

Open the file `lib/config/app_config.dart` and replace the placeholder values:

```dart
class AppConfig {
  // Supabase Configuration
  static const String supabaseUrl = 'https://YOUR-ACTUAL-PROJECT-ID.supabase.co';
  static const String supabaseAnonKey = 'YOUR-ACTUAL-ANON-KEY';
  
  // ... rest of the file stays the same
}
```

**Example:**
```dart
class AppConfig {
  // Supabase Configuration
  static const String supabaseUrl = 'https://abcdefghijklmnop.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
  
  // ... rest of the file stays the same
}
```

### Step 3: Set Up Your Database

1. Go to your Supabase project dashboard
2. Navigate to **SQL Editor**
3. Run the database schema script:
   - Copy the contents of `supabase_clean_schema.sql`
   - Paste it into the SQL Editor
   - Click **Run**

### Step 4: Create an Admin User

1. Go to **Authentication** → **Users** in your Supabase dashboard
2. Click **Add user** and create a new user
3. Note the email address
4. Go to **SQL Editor** and run:
   ```sql
   UPDATE profiles SET is_admin = true WHERE email = 'your-admin-email@example.com';
   ```

### Step 5: Test the Application

1. Run the app: `flutter run`
2. Try to login with your admin credentials
3. Go to the admin panel and try adding a category
4. Check if the products page loads without errors

## Troubleshooting

### If you still get connection errors:
1. Double-check your Supabase URL and anon key
2. Make sure your Supabase project is active (not paused)
3. Check if you have internet connection
4. Verify that the database schema was applied correctly

### If you get authentication errors:
1. Make sure you created a user in Supabase Auth
2. Verify that the user has `is_admin = true` in the profiles table
3. Check if RLS policies are set up correctly

### If you get permission errors:
1. Make sure you ran the complete database schema
2. Check that RLS policies are created
3. Verify that your user is marked as admin

## Next Steps

Once you've configured Supabase correctly:
1. The products page will show "Henüz ürün eklenmemiş" when empty
2. You can add categories and products through the admin panel
3. Products will appear as cards on the products page
4. Everything will work as expected!

## Need Help?

If you're still having issues:
1. Check the Supabase documentation: https://supabase.com/docs
2. Make sure your project is not paused (free tier has limits)
3. Verify your internet connection
4. Check the Flutter console for more detailed error messages

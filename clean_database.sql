-- Clean Database Script
-- This script will remove all existing categories and products
-- Run this in your Supabase SQL Editor

-- Delete all products first (due to foreign key constraints)
UPDATE products SET is_deleted = true, is_active = false;

-- Delete all categories
UPDATE categories SET is_deleted = true, is_active = false;

-- Alternative: If you want to completely remove the data (not recommended for production)
-- DELETE FROM products;
-- DELETE FROM categories;

-- Verify the cleanup
SELECT 'Products count:' as info, COUNT(*) as count FROM products WHERE is_deleted = false
UNION ALL
SELECT 'Categories count:' as info, COUNT(*) as count FROM categories WHERE is_deleted = false;

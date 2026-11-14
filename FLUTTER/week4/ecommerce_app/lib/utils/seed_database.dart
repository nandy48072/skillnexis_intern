import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SeedDatabase {

  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  Future<void> uploadInitialData() async{

    try{
      debugPrint("Starting comprehensive e-commerce database seeding...");

      // 1. SEED CATEGORIES (5 Categories)
      final categories=[

        {'id': 'footwear', 'name': 'Footwear', 'displayOrder': 1},
        {'id': 'accessories', 'name': 'Accessories', 'displayOrder': 2},
        {'id': 'gadgets', 'name': 'Gadgets', 'displayOrder': 3},
        {'id': 'fashion', 'name': 'Fashion', 'displayOrder': 4},
        {'id': 'toys', 'name': 'Toys', 'displayOrder': 5},

      ];

      for (var cat in categories){
        await _firestore.collection('categories').doc(cat['id'] as String).set({
          'categoryName':cat['name'],
          'displayOrder': cat['displayOrder'],
          'status': 'ACTIVE',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      debugPrint("Categories seeded successfully.");

      // 2. SEED SUBCATEGORIES

      final subCategories = [
        // Footwear subcategories
        {'id': 'sub_sandals', 'categoryId': 'footwear', 'name': 'Sandals'},
        {'id': 'sub_shoes', 'categoryId': 'footwear', 'name': 'Shoes'},
        {'id': 'sub_flats', 'categoryId': 'footwear', 'name': 'Flats'},
        {'id': 'sub_kids_footwear', 'categoryId': 'footwear', 'name': 'Kids Footwear'},

        // Accessories subcategories
        {'id': 'sub_wallet', 'categoryId': 'accessories', 'name': 'Wallet'},
        {'id': 'sub_jewelleries', 'categoryId': 'accessories', 'name': 'Jewelleries'},
        {'id': 'sub_belts', 'categoryId': 'accessories', 'name': 'Belts'},
        {'id': 'sub_sunglasses', 'categoryId': 'accessories', 'name': 'Sunglasses'},

        // Gadgets subcategories
        {'id': 'sub_phones', 'categoryId': 'gadgets', 'name': 'Phones'},
        {'id': 'sub_audio', 'categoryId': 'gadgets', 'name': 'Audio'},
        {'id': 'sub_wearables', 'categoryId': 'gadgets', 'name': 'Smart Wearables'},

        // Fashion subcategories
        {'id': 'sub_shirts', 'categoryId': 'fashion', 'name': 'Shirts & Tops'},
        {'id': 'sub_jackets', 'categoryId': 'fashion', 'name': 'Outerwear & Jackets'},
        {'id': 'sub_dresses', 'categoryId': 'fashion', 'name': 'Dresses'},

        // Toys subcategories
        {'id': 'sub_baby_toys', 'categoryId': 'toys', 'name': 'Baby Toys'},
        {'id': 'sub_educational', 'categoryId': 'toys', 'name': 'Educational Toys'},
      ];
      for (var sub in subCategories) {
        await _firestore.collection('sub_categories').doc(sub['id'] as String).set({
          'categoryId': sub['categoryId'],
          'subCategoryName': sub['name'],
          'status': 'ACTIVE',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      debugPrint("Subcategories seeded successfully.");

      // 3. SEED PRODUCTS
      final products=[

        // --- FOOTWEAR (4 products) ---

        {
          'productId': 'prod_01',
          'categoryId': 'footwear',
          'subCategoryId': 'sub_sandals',
          'productName': 'Classic Leather Sandals',
          'brand': 'CraftWalk',
          'description': 'Durable and breathable leather sandals designed for casual outdoor walking.',
          'price': 22.00, 'mrp': 30.00, 'rating': 4.3, 'stockQty': 35,
          'imageUrl': 'https://images.unsplash.com/photo-1603808033192-082d6919d3e1?auto=format&fit=crop&w=500&q=80',
          'colors': ['#8B4513', '#000000'], 'sizes': ['7', '8', '9', '10']
        },
        {
          'productId': 'prod_02',
          'categoryId': 'footwear',
          'subCategoryId': 'sub_shoes',
          'productName': 'Minimalist White Sneakers',
          'brand': 'Minimalist',
          'description': 'Clean, comfortable everyday minimalist sneakers crafted with premium synthetic leather.',
          'price': 25.00, 'mrp': 35.00, 'rating': 4.6, 'stockQty': 50,
          'imageUrl': 'https://images.unsplash.com/photo-1560769629-975ec94e6a86?auto=format&fit=crop&w=500&q=80',
          'colors': ['#FFFFFF', '#000000'], 'sizes': ['7', '8', '9', '10', '11']
        },
        {
          'productId': 'prod_03',
          'categoryId': 'footwear',
          'subCategoryId': 'sub_flats',
          'productName': 'Comfortable Summer Flats',
          'brand': 'SoleJoy',
          'description': 'Soft-soled elegant flats designed for office wear and all-day comfort.',
          'price': 15.00, 'mrp': 22.00, 'rating': 4.2, 'stockQty': 40,
          'imageUrl': 'https://images.unsplash.com/photo-1575537302964-96cd47c06b1b?auto=format&fit=crop&w=500&q=80',
          'colors': ['#E5C158', '#000000', '#BE5504'], 'sizes': ['5', '6', '7', '8']
        },
        {
          'productId': 'prod_04',
          'categoryId': 'footwear',
          'subCategoryId': 'sub_kids_footwear',
          'productName': 'Kids Colorful Sneakers',
          'brand': 'TinySteps',
          'description': 'Lightweight and colorful velcro shoes built specifically for active kids.',
          'price': 14.00, 'mrp': 20.00, 'rating': 4.7, 'stockQty': 30,
          'imageUrl': 'https://images.unsplash.com/photo-1514989940753-eaf625dacda1?auto=format&fit=crop&w=500&q=80',
          'colors': ['#FF4500', '#1E90FF'], 'sizes': ['1', '2', '3', '4']
        },
        // --- ACCESSORIES (4 products) ---
        {
          'productId': 'prod_05',
          'categoryId': 'accessories',
          'subCategoryId': 'sub_wallet',
          'productName': 'Genuine Leather Bi-fold Wallet',
          'brand': 'UrbanHide',
          'description': 'Slim profile leather wallet equipped with RFID blocking technology and multiple card slots.',
          'price': 12.00, 'mrp': 18.00, 'rating': 4.5, 'stockQty': 45,
          'imageUrl': 'https://images.unsplash.com/photo-1627123424574-724758594e93?auto=format&fit=crop&w=500&q=80',
          'colors': ['#5C4033', '#000000'], 'sizes': ['Standard']
        },
        {
          'productId': 'prod_06',
          'categoryId': 'accessories',
          'subCategoryId': 'sub_jewelleries',
          'productName': 'Gold Plated Elegant Pendant',
          'brand': 'AuraGems',
          'description': 'Delicate 18k gold plated necklace with a minimalist geometric crystal pendant.',
          'price': 19.50, 'mrp': 29.00, 'rating': 4.8, 'stockQty': 25,
          'imageUrl': 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?auto=format&fit=crop&w=500&q=80',
          'colors': ['#FFD700', '#C0C0C0'], 'sizes': ['Standard']
        },
        {
          'productId': 'prod_07',
          'categoryId': 'accessories',
          'subCategoryId': 'sub_belts',
          'productName': 'Classic Reversible Leather Belt',
          'brand': 'StitchFit',
          'description': 'Dual-color reversible leather belt with a polished metal buckle.',
          'price': 11.00, 'mrp': 16.00, 'rating': 4.1, 'stockQty': 35,
          'imageUrl': 'https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?auto=format&fit=crop&w=500&q=80',
          'colors': ['#000000', '#3E2723'], 'sizes': ['32', '34', '36', '38']
        },
        {
          'productId': 'prod_08',
          'categoryId': 'accessories',
          'subCategoryId': 'sub_sunglasses',
          'productName': 'Polarized UV Protection Shades',
          'brand': 'SunGuard',
          'description': 'Stylish lightweight frame sunglasses featuring 100% UV400 protection lenses.',
          'price': 16.00, 'mrp': 24.00, 'rating': 4.4, 'stockQty': 30,
          'imageUrl': 'https://images.unsplash.com/photo-1511499767150-a48a237f0083?auto=format&fit=crop&w=500&q=80',
          'colors': ['#000000', '#DAA520'], 'sizes': ['Standard']
        },

        // --- GADGETS (4 products) ---
        {
          'productId': 'prod_09',
          'categoryId': 'gadgets',
          'subCategoryId': 'sub_phones',
          'productName': 'Compact Mobile Gadget Pro',
          'brand': 'TechPulse',
          'description': 'High-performance compact digital accessory with sleek glass finish and fast UI interface.',
          'price': 45.00, 'mrp': 60.00, 'rating': 4.9, 'stockQty': 20,
          'imageUrl': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&w=500&q=80',
          'colors': ['#000000', '#Silver'], 'sizes': ['Standard']
        },
        {
          'productId': 'prod_10',
          'categoryId': 'gadgets',
          'subCategoryId': 'sub_audio',
          'productName': 'Wireless Active Noise Earbuds',
          'brand': 'SoundWave',
          'description': 'True wireless earbuds offering immersive deep bass and 30-hour playback case.',
          'price': 29.00, 'mrp': 45.00, 'rating': 4.7, 'stockQty': 40,
          'imageUrl': 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?auto=format&fit=crop&w=500&q=80',
          'colors': ['#FFFFFF', '#000000'], 'sizes': ['Standard']
        },
        {
          'productId': 'prod_11',
          'categoryId': 'gadgets',
          'subCategoryId': 'sub_wearables',
          'productName': 'Minimalist Smart Watch',
          'brand': 'Minimandist',
          'description': 'Fitness tracker and smartwatch with heart-rate monitor and long battery life.',
          'price': 28.00, 'mrp': 40.00, 'rating': 4.5, 'stockQty': 25,
          'imageUrl': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=500&q=80',
          'colors': ['#000000', '#E5E7EB'], 'sizes': ['Standard']
        },
        {
          'productId': 'prod_12',
          'categoryId': 'gadgets',
          'subCategoryId': 'sub_audio',
          'productName': 'Portable Bluetooth Speaker',
          'brand': 'SonicBoom',
          'description': 'Water-resistant compact portable speaker delivering crisp 360-degree sound.',
          'price': 21.00, 'mrp': 32.00, 'rating': 4.3, 'stockQty': 30,
          'imageUrl': 'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?auto=format&fit=crop&w=500&q=80',
          'colors': ['#FF0000', '#000000', '#0000FF'], 'sizes': ['Standard']
        },

        // --- FASHION (4 products) ---
        {
          'productId': 'prod_13',
          'categoryId': 'fashion',
          'subCategoryId': 'sub_shirts',
          'productName': 'Casual Cotton Shirt',
          'brand': 'UrbanStyle',
          'description': 'Breathable 100% organic cotton casual button-down shirt for daily wear.',
          'price': 18.00, 'mrp': 26.00, 'rating': 4.2, 'stockQty': 50,
          'imageUrl': 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?auto=format&fit=crop&w=500&q=80',
          'colors': ['#FFFFFF', '#4682B4', '#2F4F4F'], 'sizes': ['S', 'M', 'L', 'XL']
        },
        {
          'productId': 'prod_14',
          'categoryId': 'fashion',
          'subCategoryId': 'sub_jackets',
          'productName': 'Minimalist Bomber Jacket',
          'brand': 'Minimandist',
          'description': 'Lightweight olive bomber jacket designed for versatile daily wear and effortless styling.',
          'price': 35.00, 'mrp': 50.00, 'rating': 4.7, 'stockQty': 20,
          'imageUrl': 'https://images.unsplash.com/photo-1551028719-00167b16eac5?auto=format&fit=crop&w=500&q=80',
          'colors': ['#3B4238', '#18181B'], 'sizes': ['S', 'M', 'L', 'XL']
        },
        {
          'productId': 'prod_15',
          'categoryId': 'fashion',
          'subCategoryId': 'sub_dresses',
          'productName': 'Summer Floral Dress',
          'brand': 'ChicAura',
          'description': 'Light, flowing summer dress featuring delicate floral patterns and soft fabric.',
          'price': 24.00, 'mrp': 38.00, 'rating': 4.6, 'stockQty': 25,
          'imageUrl': 'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?auto=format&fit=crop&w=500&q=80',
          'colors': ['#FFC0CB', '#FFF8DC'], 'sizes': ['XS', 'S', 'M', 'L']
        },
        {
          'productId': 'prod_16',
          'categoryId': 'fashion',
          'subCategoryId': 'sub_shirts',
          'productName': 'Slim Fit Denim Jeans',
          'brand': 'BlueLine',
          'description': 'Classic stretchable slim-fit denim jeans with a modern washed finish.',
          'price': 27.00, 'mrp': 40.00, 'rating': 4.4, 'stockQty': 35,
          'imageUrl': 'https://images.unsplash.com/photo-1542272604-787c3835535d?auto=format&fit=crop&w=500&q=80',
          'colors': ['#191970', '#708090'], 'sizes': ['30', '32', '34', '36']
        },

        // --- TOYS (4 products) ---
        {
          'productId': 'prod_17',
          'categoryId': 'toys',
          'subCategoryId': 'sub_baby_toys',
          'productName': 'Plush Soft Teddy Bear',
          'brand': 'CuddleCuddle',
          'description': 'Ultra-soft, huggable teddy bear toy made from child-safe hypoallergenic materials.',
          'price': 12.00, 'mrp': 18.00, 'rating': 4.8, 'stockQty': 40,
          'imageUrl': 'https://images.unsplash.com/photo-1563089145-599997674d42?auto=format&fit=crop&w=500&q=80',
          'colors': ['#D2B48C', '#FFFFFF'], 'sizes': ['Standard']
        },
        {
          'productId': 'prod_18',
          'categoryId': 'toys',
          'subCategoryId': 'sub_educational',
          'productName': 'Wooden Educational Building Blocks',
          'brand': 'BrainyKids',
          'description': 'Eco-friendly wooden blocks set to encourage motor skills and creative shapes.',
          'price': 15.00, 'mrp': 22.00, 'rating': 4.9, 'stockQty': 30,
          'imageUrl': 'https://images.unsplash.com/photo-1587654780291-39c9404d746b?auto=format&fit=crop&w=500&q=80',
          'colors': ['#Multi'], 'sizes': ['Standard']
        },
        {
          'productId': 'prod_19',
          'categoryId': 'toys',
          'subCategoryId': 'sub_baby_toys',
          'productName': 'Interactive Musical Baby Toy',
          'brand': 'TotJoy',
          'description': 'Colorful musical rattle and button toy designed to stimulate infant senses.',
          'price': 10.00, 'mrp': 15.00, 'rating': 4.5, 'stockQty': 25,
          'imageUrl': 'https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?auto=format&fit=crop&w=500&q=80',
          'colors': ['#FF69B4', '#00BFFF'], 'sizes': ['Standard']
        },
        {
          'productId': 'prod_20',
          'categoryId': 'toys',
          'subCategoryId': 'sub_educational',
          'productName': 'STEM Logic Puzzle Set',
          'brand': 'GeniusPlay',
          'description': 'Challenging puzzle game designed to introduce children to problem solving and logic.',
          'price': 16.50, 'mrp': 25.00, 'rating': 4.7, 'stockQty': 20,
          'imageUrl': 'https://images.unsplash.com/photo-1610890716171-6b1bb98ffd09?auto=format&fit=crop&w=500&q=80',
          'colors': ['#Multi'], 'sizes': ['Standard']
        },
      ];

      for (var prod in products) {
        await _firestore.collection('products').doc(prod['productId'] as String).set({
          ...prod,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      debugPrint("All 20 products seeded successfully!");
    }
    catch(e){
      debugPrint("Error during database seeding: $e");
    }
  }
}
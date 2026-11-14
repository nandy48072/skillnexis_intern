import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/product_model.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static String? get _userId => FirebaseAuth.instance.currentUser?.uid;

  // --- WISHLIST METHODS ---
  static Future<void> toggleWishlist(ProductModel product, bool isWishlisted) async {
    if (_userId == null) return;
    final docRef = _firestore
        .collection('users')
        .doc(_userId)
        .collection('wishlist')
        .doc(product.id);

    if (isWishlisted) {
      await docRef.set({
        'productId': product.id,
        'productName': product.name,
        'description': product.description,
        'price': product.price,
        'categoryId': product.categoryId,
        'imageUrl': product.imageUrl,
        'rating': product.rating,
        'isFeatured': product.isFeatured,
        'addedAt': FieldValue.serverTimestamp(),
      });
    } else {
      await docRef.delete();
    }
  }

  // --- CART METHODS ---
  static Future<void> addToCart(ProductModel product, {int quantity = 1}) async {
    if (_userId == null) return;
    final docRef = _firestore
        .collection('users')
        .doc(_userId)
        .collection('cart')
        .doc(product.id);

    final doc = await docRef.get();
    if (doc.exists) {
      final currentQty = doc.data()?['quantity'] ?? 0;
      await docRef.update({'quantity': currentQty + quantity});
    } else {
      await docRef.set({
        'productId': product.id,
        'productName': product.name,
        'description': product.description,
        'price': product.price,
        'categoryId': product.categoryId,
        'imageUrl': product.imageUrl,
        'rating': product.rating,
        'isFeatured': product.isFeatured,
        'quantity': quantity,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  static Future<void> updateCartQuantity(String productId, int newQuantity) async {
    if (_userId == null) return;
    final docRef = _firestore
        .collection('users')
        .doc(_userId)
        .collection('cart')
        .doc(productId);

    if (newQuantity <= 0) {
      await docRef.delete();
    } else {
      await docRef.update({'quantity': newQuantity});
    }
  }

  static Future<void> removeFromCart(String productId) async {
    if (_userId == null) return;
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('cart')
        .doc(productId)
        .delete();
  }

  // --- ADDRESS MANAGEMENT ---
  static Future<void> addAddress(String address, String phone) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final addressRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('addresses');

    // Add a new address entry
    await addressRef.add({
      'address': address,
      'phone': phone,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Also sync primary address string on main user doc
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'shippingAddress': address,
      'phoneNumber': phone,
    }, SetOptions(merge: true));
  }

  // --- ORDER MANAGEMENT ---
  static Future<String> placeOrder({
    required List<QueryDocumentSnapshot> cartDocs,
    required double totalAmount,
    required String paymentMethod,
    required String address,
    required String phone,
  }) async {
    if (_userId == null) throw Exception('User not authenticated');

    // 1. Save or update the address in the user's profile document & subcollection
    await addAddress(address, phone);

    // 2. Using 'final' for type inference prevents any angle-bracket copy/paste bugs
    final orderItems = cartDocs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return {
        'productId': doc.id,
        'productName': data['productName'] ?? '',
        'price': data['price'] ?? 0.0,
        'quantity': data['quantity'] ?? 1,
        'imageUrl': data['imageUrl'] ?? '',
      };
    }).toList();

    // 3. Create the order document in the 'orders' collection
    DocumentReference orderRef = await _firestore.collection('orders').add({
      'userId': _userId,
      'userEmail': FirebaseAuth.instance.currentUser?.email ?? 'Guest',
      'items': orderItems,
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'shippingAddress': address,
      'phoneNumber': phone,
      'orderStatus': 'Order Placed',
      'createdAt': FieldValue.serverTimestamp(),
    });

    // 4. Clear the user's cart subcollection using a batch write
    WriteBatch batch = _firestore.batch();
    for (var doc in cartDocs) {
      batch.delete(doc.reference);
    }
    await batch.commit();

    return orderRef.id;
  }
}
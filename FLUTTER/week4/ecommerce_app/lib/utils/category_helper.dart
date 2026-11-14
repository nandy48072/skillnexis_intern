class CategoryHelper {
  static String getAssetPath(String categoryId) {
    switch (categoryId) {
      case 'footwear':
        return 'assets/images/cat_footwear.png';
      case 'accessories':
        return 'assets/images/cat_accessories.png';
      case 'gadgets':
        return 'assets/images/cat_gadgets.png';
      case 'fashion':
        return 'assets/images/cat_fashion.png';
      case 'toys':
        return 'assets/images/cat_toys.png';
      default:
        return '';
    }
  }
}
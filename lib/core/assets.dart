class ImageAssets {
  static String categoryImage(int index,bool themeDark)
  {
    if(!themeDark) return "assets/dark/category-image-$index.png";
    return "assets/light/category-image-$index.png";
  }
}
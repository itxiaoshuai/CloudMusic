class RadioCategoryData {
  int code;
  List<Category> categories;

  static RadioCategoryData fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    RadioCategoryData radioCategoryData = RadioCategoryData();
    radioCategoryData.code = map['code'];
    radioCategoryData.categories = []..addAll(
        (map['categories'] as List ?? []).map((o) => Category.fromJson(o)));
    return radioCategoryData;
  }
}

class Category {
  String name;
  int id;
  String picIPadUrl;

  static Category fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Category category = Category();
    category.name = map['name'];
    category.id = map['id'];
    category.picIPadUrl = map['picIPadUrl'];
    return category;
  }
}

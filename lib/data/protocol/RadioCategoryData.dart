class RadioCategoryData {
  late int code;
  late List<Category> categories;

  static RadioCategoryData fromJson(Map<String, dynamic> map) {
    RadioCategoryData radioCategoryData = RadioCategoryData();
    radioCategoryData.code = map['code'];
    radioCategoryData.categories = []..addAll(
        (map['categories'] as List).map((o) => Category.fromJson(o)));
    return radioCategoryData;
  }
}

class Category {
  late String name;
  late int id;
  late String picIPadUrl;

  static Category fromJson(Map<String, dynamic> map) {
    Category category = Category();
    category.name = map['name'];
    category.id = map['id'];
    category.picIPadUrl = map['picIPadUrl'];
    return category;
  }
}

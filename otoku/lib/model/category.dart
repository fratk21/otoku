class category {
  List<Categories>? categories;
  List<Subcategories>? subcategories;

  category({this.categories, this.subcategories});

  category.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['subcategories'] != null) {
      subcategories = <Subcategories>[];
      json['subcategories'].forEach((v) {
        subcategories!.add(new Subcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? categoryName;
  List<String>? subcategories;

  Categories({this.categoryName, this.subcategories});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    subcategories = json['subcategories'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['subcategories'] = this.subcategories;
    return data;
  }
}

class Subcategories {
  String? subcategoryName;
  List<String>? subcategories;

  Subcategories({this.subcategoryName, this.subcategories});

  Subcategories.fromJson(Map<String, dynamic> json) {
    subcategoryName = json['subcategory_name'];
    subcategories = json['subcategories'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subcategory_name'] = this.subcategoryName;
    data['subcategories'] = this.subcategories;
    return data;
  }
}

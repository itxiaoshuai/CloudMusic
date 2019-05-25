class BannerModel {
  int code;
  List<Banner> banners;

  BannerModel({this.code, this.banners});

  BannerModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['banners'] != null) {
      banners = new List<Banner>();
      (json['banners'] as List).forEach((v) {
        banners.add(new Banner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.banners != null) {
      data['banners'] = this.banners.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banner {
  String bannerId;
  String pic;
  String titleColor;
  String requestId;
  bool exclusive;
  String scm;
  int targetId;
  bool showAdTag;
  int targetType;
  String typeTitle;
  String url;
  String encodeId;

  Banner({
    this.bannerId,
    this.pic,
    this.titleColor,
    this.requestId,
    this.exclusive,
    this.scm,
    this.targetId,
    this.showAdTag,
    this.targetType,
    this.typeTitle,
    this.url,
    this.encodeId,
  });

  Banner.fromJson(Map<String, dynamic> json) {
    bannerId = json['bannerId'];
    pic = json['pic'];
    titleColor = json['titleColor'];
    requestId = json['requestId'];
    exclusive = json['exclusive'];
    scm = json['scm'];
    targetId = json['targetId'];
    showAdTag = json['showAdTag'];
    targetType = json['targetType'];
    typeTitle = json['typeTitle'];
    url = json['url'];
    encodeId = json['encodeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannerId'] = this.bannerId;
    data['pic'] = this.pic;
    data['titleColor'] = this.titleColor;
    data['requestId'] = this.requestId;
    data['exclusive'] = this.exclusive;
    data['scm'] = this.scm;
    data['targetId'] = this.targetId;
    data['showAdTag'] = this.showAdTag;
    data['targetType'] = this.targetType;
    data['typeTitle'] = this.typeTitle;
    data['url'] = this.url;
    data['encodeId'] = this.encodeId;
    return data;
  }
}

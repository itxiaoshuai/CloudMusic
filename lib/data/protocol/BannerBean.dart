class BannerList {
  late int code;
  late List<BannerBean> banners;

  static BannerList fromJson(Map<String, dynamic> map) {
    BannerList commentList = BannerList();
    commentList.code = map['code'];
    commentList.banners = []..addAll(
        (map['banners'] as List).map((o) => BannerBean.fromJson(o)));
    return commentList;
  }
}

class BannerBean {
  late int targetId;
  late String imageUrl;
  late String titleColor;
  late String typeTitle;
  late String? url;


  static BannerBean fromJson(Map<String, dynamic> map) {
    BannerBean bannerBean = BannerBean();
    bannerBean.targetId = map['targetId'];
    bannerBean.imageUrl = map['imageUrl'];
    bannerBean.titleColor = map['titleColor'];
    bannerBean.typeTitle = map['typeTitle'];
    bannerBean.url = map['url'];
    return bannerBean;
  }
}

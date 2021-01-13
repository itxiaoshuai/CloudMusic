import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/base/res/styles.dart';
import 'package:cloud_music/base/utils/number_utils.dart';
import 'package:cloud_music/data/protocol/Follow.dart';
import 'package:cloud_music/data/protocol/search_user.dart';
import 'package:cloud_music/model/search_model.dart';
import 'package:cloud_music/pages/my/PageMy.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/provider_widget.dart';
import 'package:cloud_music/provider/view_state_widget.dart';
import 'package:cloud_music/widget/head_widget.dart';
import 'package:common_utils/common_utils.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import '../../r.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchUserListPage extends StatefulWidget {
  SearchUserListPageState createState() => SearchUserListPageState();
}

class SearchUserListPageState extends State<SearchUserListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProviderWidget<SearchModel>(
          model: SearchModel(),
          onModelReady: (model) {
            Map<String, dynamic> formData = {'keywords': "四季予你", "type": 1002};
            model.loadSearchResult(formData);
          },
          builder: (context, model, child) {
            switch (model.layoutState) {
              case LayoutState.IDLE:
                break;
              case LayoutState.LOADING:
                return ViewStateLoadingWidget();
                break;
              case LayoutState.EMPTY:
                // TODO: Handle this case.
                break;
              case LayoutState.ERROR:
                // TODO: Handle this case.
                break;
              case LayoutState.UNAUTHORIZED:
                // TODO: Handle this case.
                break;
              case LayoutState.SUCCESS:
                // TODO: Handle this case.
                break;
            }

            return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  SearchUser follow = SearchUser.fromJson(
                      model.data['result']['userprofiles'][index]);
                  return _buildFriendItem(follow);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(
                        top: 0, bottom: 0, left: 184.w, right: 0),
                    child: Center(
                      child: Divider(
                        color: Colors.grey[300],
                        height: 0.6,
                      ),
                    ),
                  );
                },
                itemCount: model.data['result']['userprofiles'].length);
          }),
    );
  }

  Widget _buildFriendItem(SearchUser follow) {
    return Container(
      padding: EdgeInsets.only(left: 46.w, right: 46.w, top: 10, bottom: 10),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 108.w,
                height: 108.w,
                color: Colors.blue,
                child: Image.network(follow.avatarUrl),
              ),
            ),
          ),
          Gaps.hGap15,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(follow.nickname, style: R.style.textDark16),
                Visibility(
                  visible: follow.signature.length > 0,
                  child: Text(
                    follow.signature,
                    style: R.style.textGray10,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 2, bottom: 2, left: 6, right: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 0.5),
              shape: BoxShape.rectangle,
              // 默认值也是矩形
              borderRadius: BorderRadius.circular((20.0)), // 圆角度
            ),
            margin: EdgeInsets.only(
              left: 10,
            ),
            child: Text(
              '+ 关注',
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Colors.red, fontWeight: FontWeight.w100, fontSize: 10),
            ),
          ),
          Gaps.hGap10,
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

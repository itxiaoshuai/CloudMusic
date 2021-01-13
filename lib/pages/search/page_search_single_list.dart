import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/base/res/styles.dart';
import 'package:cloud_music/base/utils/number_utils.dart';
import 'package:cloud_music/data/protocol/Follow.dart';
import 'package:cloud_music/data/protocol/artist.dart';
import 'package:cloud_music/data/protocol/new_album.dart';
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

class SearchSingleListPage extends StatefulWidget {
  SearchSingleListPageState createState() => SearchSingleListPageState();
}

class SearchSingleListPageState extends State<SearchSingleListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProviderWidget<SearchModel>(
          model: SearchModel(),
          onModelReady: (model) {
            Map<String, dynamic> formData = {'keywords': "四季予你", "type": 100};
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
                  Artist album =
                      Artist.fromJson(model.data['result']['artists'][index]);
                  return _buildFriendItem(album);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(
                        top: 0, bottom: 0, left: 184.w, right: 0),
                    child: Center(
                      child: Divider(
                        color: Colors.transparent,
                        height: 0.6,
                      ),
                    ),
                  );
                },
                itemCount: model.data['result']['artists'].length);
          }),
    );
  }

  Widget _buildFriendItem(Artist artist) {
    return Container(
      padding: EdgeInsets.only(left: 46.w, right: 46.w, top: 10, bottom: 10),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: 110.w,
                height: 110.w,
                child: Image.network(
                  artist.picUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Gaps.hGap15,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: artist.name.length > 0,
                  child: Text(
                    '${artist.name}  ',
                    style: R.style.textDark14,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          artist.accountId == null || artist.accountId == 0
              ? Container()
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      color: Colors.red,
                      size: 30.w,
                    ),
                    Gaps.hGap5,
                    Text(
                      '已入驻',
                      style: R.style.textGray12,
                    ),
                  ],
                ),
          Gaps.hGap10,
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/base/res/styles.dart';
import 'package:cloud_music/base/utils/number_utils.dart';
import 'package:cloud_music/data/protocol/Follow.dart';
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

class SearchAlbumListPage extends StatefulWidget {
  SearchAlbumListPageState createState() => SearchAlbumListPageState();
}

class SearchAlbumListPageState extends State<SearchAlbumListPage>  with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProviderWidget<SearchModel>(
          model: SearchModel(),
          onModelReady: (model) {
            Map<String, dynamic> formData = {'keywords': "四季予你", "type": 10};
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
                  Album album =
                      Album.fromJson(model.data['result']['albums'][index]);
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
                itemCount: model.data['result']['albums'].length);
          }),
    );
  }

  Widget _buildFriendItem(Album album) {
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
                child: Image.network(album.blurPicUrl),
              ),
            ),
          ),
          Gaps.hGap15,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      text: "${album.name}",
                      style: R.style.textDark16,
                      children: [
                        TextSpan(
                            text:  album.alias.length > 0
                                ? "(${album.alias[0]})"
                                : "",
                            style: R.style.textGray14),
                      ]),
                  textDirection: TextDirection.ltr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                Visibility(
                  visible: album.artist.name.length > 0,
                  child: Text(
                    '${album.artist.name}  ${DateUtil.formatDateMs(album.publishTime, format: 'yyyy.MM.dd')}',
                    style: R.style.textGray10,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
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

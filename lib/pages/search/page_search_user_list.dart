import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/data/protocol/search_user.dart';
import 'package:cloud_music/model/search_model.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/provider_widget.dart';
import 'package:cloud_music/provider/view_state_widget.dart';
import 'package:cloud_music/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../r.dart';

class SearchUserListPage extends StatefulWidget {
  SearchUserListPageState createState() => SearchUserListPageState();
}

class SearchUserListPageState extends State<SearchUserListPage>
    with AutomaticKeepAliveClientMixin {
  var isDown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProviderWidget<SearchModel>(
          model: SearchModel(),
          onModelReady: (model) {
            Map<String, dynamic> formData = {'keywords': "四季予你", "type": 1002};
            model.loadSearchResult(formData);
          },     child: Container(),
          builder: (context, model, child) {
            switch (model.layoutState) {
              case LayoutState.IDLE:
                break;
              case LayoutState.LOADING:
                return ViewStateLoadingWidget();
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
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(RouteName.USER_HOME,
              arguments: follow.userId);
        },
        child: Container(
          padding:
              EdgeInsets.only(left: 46.w, right: 46.w, top: 10, bottom: 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: 108.w,
                  height: 108.w,
                  color: Colors.blue,
                  child: Image.network(follow.avatarUrl),
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
              ImageTapWidget(
                text: "+ 关注",
                onTap: () {},
              ),
              Gaps.hGap10,
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class ImageTapWidget extends StatefulWidget {
  final String text;

  final VoidCallback onTap;

  // final Widget child;
  ImageTapWidget({
    required this.onTap,
    required this.text,
  });

  @override
  _ImageTapWidgetState createState() => _ImageTapWidgetState();
}

class _ImageTapWidgetState extends State<ImageTapWidget> {
  var isDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (d) => setState(() => this.isDown = true),
      onTapUp: (d) => setState(() => this.isDown = false),
      onTapCancel: () => setState(() => this.isDown = false),
      child: isDown
          ? ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: Center(
          child: Material(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(
                  30.0), //如果[borderRadius]被指定，那么[type]属性不能是 [MaterialType.circle]。
            ),
            child: InkWell(
              // onTap: () {
              //
              // },
              child: Container(
                color: Colors.red,
                padding: EdgeInsets.only(
                    left: 8, right: 8, top: 2, bottom: 2),
                child: Row(
                  children: [
                    Text(
                      widget.text,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
          : ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: Center(
          child: Material(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(
                  30.0), //如果[borderRadius]被指定，那么[type]属性不能是 [MaterialType.circle]。
            ),
            child: InkWell(
              // onTap: () {
              //
              // },
              child: Container(
                padding: EdgeInsets.only(
                    left: 8, right: 8, top: 2, bottom: 2),
                child: Row(
                  children: [
                    Text(
                      widget.text,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.w100,
                          fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

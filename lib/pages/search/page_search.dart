import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/model/search_model.dart';
import 'package:cloud_music/pages/album/InfiniteGridView.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/provider_widget.dart';
import 'package:cloud_music/provider/view_state_widget.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var i = 0;
    return Scaffold(
      appBar: AppBar(),
      body: ProviderWidget<SearchModel>(
          model: SearchModel(),
          onModelReady: (model) {
            model.loadSearchHot();
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
            return Container(
              // color: Colors.red,
//      padding: const EdgeInsets.all(18.0),
              child: LayoutBuilder(builder: (context, constraints) {
                int count = 2;
                double spacing = 8;
                double totalWidthSpacing = spacing * (count + 1);
                double width =
                    ((constraints.maxWidth - totalWidthSpacing) ~/ count)
                        .toDouble();
                print(width);
                return Padding(
                  padding: EdgeInsets.only(left: spacing),
                  child: Wrap(
                    spacing: spacing,
                    direction: Axis.horizontal,
                    children: model.searchHotList.map<Widget>((p) {
                      i++;
                      return Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        width: width,
                        child: Row(
                          children: [
                            Text(
                              "$i",
                              style: i <= 3
                                  ? TextStyle(color: Colors.red)
                                  : TextStyle(color: Colors.grey),
                            ),
                            Gaps.hGap4,
                            Text(
                              "${p['searchWord']}",
                              style: i <= 3
                                  ? TextStyle(fontWeight: FontWeight.bold)
                                  : TextStyle(),
                            ),
                            Image.network(
                              p['iconUrl'] == null ? "" : p['iconUrl'],
                              height: 12,
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
            );
          }),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/CommonLoading.dart';
import 'package:flutter_app/net/huyi_android_api.dart';
import 'package:flutter_app/pages/video/VideoDetailPage.dart';
import 'package:flutter_app/route/routes.dart';

class VideoList extends StatefulWidget {
  final int id;

  VideoList({
    this.id,
  });

  @override
  State<StatefulWidget> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  List _videoList = [];

  @override
  void initState() {
    loadData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _videoList.map<Widget>((p) {
        return InkWell(
          onTap: () async {
            Map<String, dynamic> formData = {
              'id': p['vid'],
            };
            var response =
                await http.get('/video/url', queryParameters: formData);
            print(response.data);
            List urls = response.data['urls'];
            if (urls.length > 0) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return VideoDetailPage(
                  id: p['vid'],
                  url: urls[0]['url'],
                );
              }));
            }
          },
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: p['coverUrl'],
                      placeholder: (context, url) => ProgressView(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                )),
                Text(p['title']),
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: 40,
                          height: 40,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Future<void> loadData(id) async {
    Map<String, dynamic> formData = {
      'id': id,
    };
    var response =
        await http.get('/related/allvideo', queryParameters: formData);
    print(response.data);
    List rows = response.data['data'];
    _videoList = rows;
    setState(() {});
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/CommonLoading.dart';
import 'package:flutter_app/net/huyi_android_api.dart';
import 'package:flutter_app/route/routes.dart';

class VideoList extends StatefulWidget {
  final String area;

  VideoList({
    this.area,
  });

  @override
  State<StatefulWidget> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  List _videoList = [];

  @override
  void initState() {
    loadData(widget.area);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _videoList.map<Widget>((p) {
        return Container(
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
                    imageUrl: p['cover'],
                    placeholder: (context, url) => ProgressView(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              )),
              Text(p['name']),
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
        );
      }).toList(),
    );
  }

  Future<void> loadData(area) async {
    Map<String, dynamic> formData = {
      'area': area,
    };
    var response = await http.get('/mv/all', queryParameters: formData);
    print(response.data);
    List rows = response.data['data'];
    _videoList = rows;
    setState(() {});
  }
}

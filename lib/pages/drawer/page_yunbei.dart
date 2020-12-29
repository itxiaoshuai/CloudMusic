import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/data/protocol/yun_task.dart';
import 'package:cloud_music/manager/request_manager.dart';
import 'package:flutter/material.dart';

class YunBeiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _YunBeiPageState();
}

class _YunBeiPageState extends State<YunBeiPage> {
  YunCoinTask _task;

  @override
  Future<void> initState() {
    super.initState();
    _refresh();
  }

  Future<YunCoinTask> _refresh() async {
    _task = await RequestManager.fetchTasks();
    setState(() {
      print('_taskccccccccccccccccccccccc');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _task == null
          ? Container()
          : ListView.builder(
              itemCount: _task.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_task.data[index].taskName),
                  subtitle: Text(_task.data[index].taskDescription),
                  leading: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: _task.data[index].webPicUrl,
                    placeholder: (context, url) => ProgressView(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  trailing: Icon(Icons.chevron_right, color: Colors.pink),
                );
              },
            ),
    );
  }
}

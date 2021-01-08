import 'package:cloud_music/base/res/gaps.dart';
import 'package:flutter/material.dart';

import '../../../r.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        iconTheme:IconThemeData(
          color: Colors.black
        ) ,
        backgroundColor: Colors.white,
        title: Text('设置',style: R.style.textBoldDark14,),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  // padding: EdgeInsets.only(left: 10),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        child: Row(
                          children: [
                            Gaps.hGap15,
                            Text('网络', style: R.style.textGray12),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Gaps.hGap15,
                            Text('使用3G/4G/5G网络播放'),
                            Spacer(),
                            SwitchWidget(),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Row(
                        children: [
                          Gaps.hGap15,
                          Text('使用3G/4G/5G网络下载'),
                          Spacer(),
                          SwitchWidget(),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Row(
                        children: [
                          Gaps.hGap15,
                          Text('动态页中WIFI下自动播放视频'),
                          Spacer(),
                          SwitchWidget(),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  // padding: EdgeInsets.only(left: 10),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        child: Row(
                          children: [
                            Gaps.hGap15,
                            Text('播放和下载', style: R.style.textGray12),
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('在线播放音质'),
                                Spacer(),
                                Text('自动',style: R.style.textGray12),
                                Gaps.hGap15,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Gaps.line,
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('下载音质'),
                                Spacer(),
                                Text('极高',style: R.style.textGray12),
                                Gaps.hGap15,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Gaps.line,
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('鲸云音乐'),
                                Spacer(),
                                // Text('自动'),
                                // Gaps.hGap15,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('视频解码模式'),
                                Spacer(),
                                Text('默认设置',style: R.style.textGray12),
                                Gaps.hGap15,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('设置下载目录'),
                                Spacer(),
                                Text('存储卡1',style: R.style.textGray12),
                                Gaps.hGap15,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('缓存设置'),
                                // Spacer(),
                                // Text('存储卡1'),
                                // Gaps.hGap15,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('允许与其它应用同时播放'),
                                Spacer(),
                                SwitchWidget(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('直播内容推荐'),
                                Spacer(),
                                SwitchWidget(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  // padding: EdgeInsets.only(left: 10),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        child: Row(
                          children: [
                            Gaps.hGap15,
                            Text('账号和隐私', style: R.style.textGray12),
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('账号和绑定设置'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('消息和隐私设置'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('登入保护'),
                                Spacer(),
                                // Text('自动'),
                                // Gaps.hGap15,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Gaps.line,
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  // padding: EdgeInsets.only(left: 10),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        child: Row(
                          children: [
                            Gaps.hGap15,
                            Text('工具', style: R.style.textGray12),
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('桌面歌词'),
                                Spacer(),
                                SwitchWidget(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('跑步FM离线包'),
                                    Text('连接Wi-Fi,自动缓存跑步歌曲',
                                        style: R.style.textGray10),
                                  ],
                                ),
                                Spacer(),
                                SwitchWidget(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('桌面小部件'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('锁屏显示'),
                                Spacer(),
                                Text('云音乐锁屏', style: R.style.textGray12),
                                Gaps.hGap15,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('通知栏样式'),
                                Spacer(),
                                Text('云音乐通知栏（自动）', style: R.style.textGray12),
                                Gaps.hGap15,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('切换语言'),
                                Spacer(),
                                Text('默认', style: R.style.textGray12),
                                Gaps.hGap15,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('底部导航自定义'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('账号页管理'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('自动下载安装包'),
                                Spacer(),
                                Text('仅Wi_Fi网络', style: R.style.textGray12),
                                Gaps.hGap15,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  // padding: EdgeInsets.only(left: 10),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        child: Row(
                          children: [
                            Gaps.hGap15,
                            Text('音乐硬件', style: R.style.textGray12),
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('耳机线控切歌'),
                                Spacer(),
                                Text('已开启', style: R.style.textGray12),
                                Gaps.hGap15,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('车载蓝牙歌词'),
                                Spacer(),
                                SwitchWidget(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('连接DLNA设备'),
                                    Text('用Wi-Fi将音乐传输到支持DLNA的设备播放',
                                        style: R.style.textGray10),
                                  ],
                                ),
                                Spacer(),
                                SwitchWidget(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('智能硬件'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  // padding: EdgeInsets.only(left: 10),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        child: Row(
                          children: [
                            Gaps.hGap15,
                            Text('关于', style: R.style.textGray12),
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('8.0版本新手指南'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('帮助与反馈'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            child: Row(
                              children: [
                                Gaps.hGap15,
                                Text('关于网易云'),
                                Spacer(),
                                // Text('自动'),
                                // Gaps.hGap15,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Gaps.line,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SwitchWidget extends StatefulWidget {
  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: this.flag,
      activeColor: Colors.red,
      onChanged: (value) {
        setState(() {
          this.flag = value;
        });
      },
    );
  }
}

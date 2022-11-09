import 'dart:async';
import 'package:anion/add_page.dart';
import 'package:anion/delete_page.dart';
import 'package:anion/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:anion/model/ani_data.dart';
import 'package:anion/ani_container.dart';
import 'package:anion/model/ani_data.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 800) {
          return Scaffold(
            appBar: AppBar(title: const Text("ANION")),
            body: HomeBodyMobile(),
          );
        } else {
          return Scaffold(
            body: HomeBodyPage(),
          );
        }
      }),
    );
  }
}

class HomeBodyMobile extends StatefulWidget {
  HomeBodyMobile({Key? key}) : super(key: key);

  @override
  State<HomeBodyMobile> createState() => _HomeBodyMobileState();
}

class _HomeBodyMobileState extends State<HomeBodyMobile> {
  var id = 0;
  var index = 0;

  void refreshData() {
    id++;
    index = 0;
  }

  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ListView(scrollDirection: Axis.vertical, children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              const Text("Your list:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const Expanded(
                child: SizedBox(),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DeletePage();
                    })).then(onGoBack);
                  },
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AddPage();
                    })).then(onGoBack);
                  },
                  child: const Text("Add")),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ),
        ...aniListData.map((aniData) {
          if (index >= aniListData.length) index = 0;
          index++;
          return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: AniContainer(aniData: aniData, index: index));
        }).toList(),
      ]),
    );
  }
}

class HomeBodyPage extends StatefulWidget {
  HomeBodyPage({Key? key}) : super(key: key);

  @override
  State<HomeBodyPage> createState() => _HomeBodyPageState();
}

class _HomeBodyPageState extends State<HomeBodyPage> {
  var id = 0;
  var index = 0;

  List<Widget> getColumedAniList(int col, int maxColumn) {
    int i = col;
    List<Widget> result = [];
    for (i = col; i < aniListData.length; i += maxColumn) {
      result.add(Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: AniContainer(aniData: aniListData[i], index: i + 1)));
    }
    return result;
  }

  void refreshData() {
    id++;
    index = 0;
  }

  FutureOr onGoBack(dynamic value) {
    refreshData();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Flexible(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("ANION",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40)),
                      SizedBox(
                        height: 10,
                      ),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AddPage();
                            })).then(onGoBack);
                          },
                          child: Container(
                            width: 80,
                            height: 20,
                            alignment: Alignment.center,
                            child: const Text(
                              "Add",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DeletePage();
                            })).then(onGoBack);
                          },
                          child: Container(
                            width: 80,
                            height: 20,
                            alignment: Alignment.center,
                            child: const Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 40,
          ),
          Flexible(
            child: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(children: getColumedAniList(0, 2)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Column(children: getColumedAniList(1, 2)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

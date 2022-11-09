import 'package:anion/model/ani_data.dart';
import 'package:flutter/material.dart';
import 'package:anion/ani_container.dart';

class DeletePage extends StatelessWidget {
  const DeletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 800) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Delete Entry"),
          ),
          body: DeleteWebPageBody(
            textButton: (constraints.maxWidth > 400),
          ),
        );
      } else {
        return Scaffold(
          body: DeleteMobilePageBody(
            textButton: (constraints.maxWidth > 400),
          ),
        );
      }
    });
  }
}

class DeleteWebPageBody extends StatelessWidget {
  final bool textButton;
  DeleteWebPageBody({Key? key, required this.textButton}) : super(key: key);
  var index = 0;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              const Text("Select entry to delete",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ),
        ...aniListData.map((aniData) {
          index++;
          return AniDeleteContainer(
            aniData: aniData,
            index: index,
            textButton: textButton,
          );
        }).toList(),
      ]),
    );
  }
}

class DeleteMobilePageBody extends StatelessWidget {
  final bool textButton;
  DeleteMobilePageBody({Key? key, required this.textButton}) : super(key: key);
  var index = 0;

  List<Widget> getColumedAniList(int col, int maxColumn) {
    int i = col;
    List<Widget> result = [];
    for (i = col; i < aniListData.length; i += maxColumn) {
      result.add(Padding(
          padding: EdgeInsets.symmetric(vertical: 0),
          child: AniDeleteContainer(
            aniData: aniListData[i],
            index: i + 1,
            textButton: textButton,
          )));
    }
    return result;
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back)),
              const Text("Select entry to delete",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const Expanded(
                child: SizedBox(),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ),
        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(children: getColumedAniList(0, 2)),
              ),
              SizedBox(
                width: 24,
              ),
              Flexible(
                child: Column(children: getColumedAniList(1, 2)),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

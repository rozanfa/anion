import 'package:anion/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:anion/model/ani_data.dart';

class AniContainer extends StatelessWidget {
  final AniData aniData;
  int index;
  AniContainer({Key? key, required this.aniData, required this.index})
      : super(key: key);

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailPage(
            aniData: aniData,
          );
        }));
      },
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.indigo[100],
          border: Border.all(color: Colors.indigo, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("$index\."),
              const SizedBox(
                width: 10,
              ),
              Image.network(aniData.url),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  aniData.title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // con:st Spacer(),
              const Icon(Icons.star, color: Colors.yellow),
              const SizedBox(width: 2),
              Text(aniData.rating.toString()),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}

class AniCard extends StatelessWidget {
  final AniData aniData;
  int index;
  AniCard({Key? key, required this.aniData, required this.index})
      : super(key: key);

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailPage(
            aniData: aniData,
          );
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.indigo[100],
          border: Border.all(color: Colors.indigo, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Expanded(
                  child: Center(
                    child: Image.network(
                      aniData.url,
                    ),
                  ),
                ),
                Container(
                  child: Text("$index\."),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      color: Colors.indigo[100]),
                ),
              ]),
              Text(
                aniData.title,
                overflow: TextOverflow.ellipsis,
              ),
              // con:st Spacer(),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.yellow),
                  const SizedBox(width: 2),
                  Text(aniData.rating.toString()),
                ],
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}

class AniDeleteContainer extends StatelessWidget {
  final bool textButton;
  final AniData aniData;
  int index;
  AniDeleteContainer(
      {Key? key,
      required this.aniData,
      required this.index,
      required this.textButton});

  Widget getDeleteSign(text) {
    if (text) {
      return Container(
        height: 48,
        width: 75,
        decoration: BoxDecoration(
          color: Colors.red[100],
          border: Border.all(color: Colors.red, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Center(child: Text("Delete", style: TextStyle())),
      );
    } else {
      return Container(
        height: 48,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.red[100],
          border: Border.all(color: Colors.red, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: Center(child: Icon(Icons.delete_forever)),
      );
    }
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Flexible(
            child: AniContainer(
              aniData: aniData,
              index: this.index,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          InkWell(
              onTap: () {
                aniListData.removeAt(index - 1);
                Navigator.pop(context);
              },
              child: getDeleteSign(textButton)),
        ],
      ),
    );
  }
}

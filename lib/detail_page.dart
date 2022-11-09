import 'package:anion/model/ani_data.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  AniData aniData;
  DetailPage({Key? key, required this.aniData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 800) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Entry"),
          ),
          body: DetailMobilePageBody(aniData: aniData),
        );
      } else {
        return Scaffold(
          body: DetailWebPageBody(
            aniData: aniData,
          ),
        );
      }
    });
  }
}

class DetailWebPageBody extends StatelessWidget {
  AniData aniData;
  DetailWebPageBody({Key? key, required this.aniData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back)),
              Image.network(aniData.url),
              SizedBox(
                width: 20,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      aniData.title,
                      softWrap: true,
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 32,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          aniData.rating.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      aniData.notes,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class DetailMobilePageBody extends StatelessWidget {
  AniData aniData;
  DetailMobilePageBody({Key? key, required this.aniData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(aniData.url),
              SizedBox(
                width: 12,
              ),
              Text(
                aniData.title,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 32,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    aniData.rating.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                aniData.notes,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        )
      ],
    );
  }
}

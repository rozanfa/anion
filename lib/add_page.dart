import 'package:anion/model/ani_data.dart';
import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 800) {
          return Scaffold(
            appBar: AppBar(title: const Text("Add Entry")),
            body: AddPageBody(),
          );
        } else {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(children: [
                AddPageBody(),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back)),
              ]),
            ),
          );
        }
      }),
    );
  }
}

class AddPageBody extends StatefulWidget {
  const AddPageBody({Key? key}) : super(key: key);

  @override
  State<AddPageBody> createState() => _AddPageBodyState();
}

class _AddPageBodyState extends State<AddPageBody> {
  var title = "";
  var url = "";
  var rating = "";
  var notes = "";
  var aniData;
  final _ratingController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  void dispose() {
    _ratingController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  String? get _errorRatingText {
    // at any time, we can get the text from _controller.value.text
    final text = _ratingController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    try {
      (double.parse(rating));
    } catch (e) {
      return "Rating must be a floating number";
    }
    if (double.parse(rating) < 0 || double.parse(rating) > 10) {
      return "Rating must between 0 and 10";
    }
    // return null if the text is valid
    return null;
  }

  String? get _errorImageUrlText {
    // at any time, we can get the text from _controller.value.text
    final text = _imageUrlController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (!url
        .substring(url.length > 5 ? url.length - 5 : 0)
        .toLowerCase()
        .contains(".jpg")) {
      return "Url must be a valid jpg file";

      // return null if the text is valid
    }
    return null;
  }

  String? get _errorTitleText {
    // at any time, we can get the text from _controller.value.text
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (title.isEmpty) {
      return 'Title can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }

  bool _submitted = false;

  void _submit() {
    setState(() => _submitted = true);
    if (_errorTitleText == null &&
        _errorImageUrlText == null &&
        _errorRatingText == null) {
      aniData = AniData(
          title: title, url: url, rating: double.parse(rating), notes: notes);
      aniListData.add(aniData);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text("Add entry",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(
                height: 12,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Title",
                    errorText: _submitted ? _errorTitleText : null),
                onChanged: (text) {
                  title = text;
                  setState(() {});
                },
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                controller: _imageUrlController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Image Url",
                    errorText: _submitted ? _errorImageUrlText : null),
                onChanged: (text) {
                  url = text;
                  setState(() {});
                },
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                controller: _ratingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Rating",
                    errorText: _submitted ? _errorRatingText : null),
                onChanged: (text) {
                  rating = text;
                  setState(() {});
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Notes"),
                onChanged: (text) {
                  notes = text;
                  setState(() {});
                },
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text(
                    "Sumbit",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

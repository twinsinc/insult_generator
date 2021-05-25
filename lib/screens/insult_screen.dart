import 'package:flutter/material.dart';
import 'package:insult_generator/constants.dart';
import 'package:insult_generator/screens/saved_screen.dart';
import 'package:insult_generator/services/insult_model.dart';
import 'package:share/share.dart';

class InsultScreen extends StatefulWidget {
  final insultData;
  final _saved = <String>{};

  InsultScreen({@required this.insultData});
  @override
  _InsultScreenState createState() => _InsultScreenState();
}

class _InsultScreenState extends State<InsultScreen> {
  InsultModel insultModel = InsultModel();
  String dropDownValue = 'EN';
  String insult = '';

  void saveInsult(String insult) {
    bool alreadySaved = wasAlreadySaved(insult);
    if (alreadySaved) {
      widget._saved.remove(insult);
    } else {
      widget._saved.add(insult);
    }
  }

  bool wasAlreadySaved(String insult) {
    bool alreadySaved = widget._saved.contains(insult);
    return alreadySaved;
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.insultData);
  }

  void updateUI(dynamic insultData) {
    setState(() {
      insult = insultData['insult']
          .replaceAll(r"&quot;", "'")
          .replaceAll(r"--&gt;", "-");
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () async {
                    List<String> deleted = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SavedInsults(saved: widget._saved);
                        },
                      ),
                    );
                    setState(() {
                      if (deleted.isNotEmpty) {
                        for (var i = 0; i < deleted.length; i++)
                          widget._saved.remove(deleted[i]);
                      }
                    });
                  },
                  child: Icon(
                    Icons.favorite,
                    color: kLightMainColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DropdownButton<String>(
                    value: dropDownValue,
                    style: const TextStyle(
                      color: kLightMainColor,
                    ),
                    underline: Container(
                      height: 2,
                      color: kLightMainColor,
                    ),
                    onChanged: (String? newValue) async {
                      dropDownValue = newValue!;
                      var insultData = await insultModel
                          .getEvilInsult(dropDownValue.toLowerCase());
                      setState(() {
                        updateUI(insultData);
                      });
                    },
                    items: <String>[
                      'EN',
                      'RU',
                      'DE',
                      'CN',
                      'ES',
                      'EL',
                      'FR',
                      'SW',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Text(
              'EVIL INSULT GENERATOR',
              style: kInsultStyle,
            ),
            Container(
              alignment: Alignment.center,
              height: size.height * .5,
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: kMainColor.withOpacity(0.7),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Text(
                    insult,
                    style: kInsultStyle,
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            saveInsult(insult);
                          });
                        },
                        child: Icon(
                          wasAlreadySaved(insult)
                              ? Icons.bookmark_outlined
                              : Icons.bookmark_outline,
                          color: kLightMainColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await Share.share(insult,
                              subject: 'https://evilinsult.com/');
                        },
                        child: Icon(
                          Icons.share,
                          color: kLightMainColor,
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    kButtonColor,
                  ),
                  textStyle: MaterialStateProperty.all(kInsultStyle),
                  minimumSize: MaterialStateProperty.all(
                    Size(70.0, 70.0),
                  ),
                ),
                child: Text('GENERATE INSULT'),
                onPressed: () async {
                  var insultData = await insultModel
                      .getEvilInsult(dropDownValue.toLowerCase());
                  setState(() {
                    updateUI(insultData);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:insult_generator/constants.dart';

import 'insult_screen.dart';

class SavedInsults extends StatefulWidget {
  final Set<String> saved;
  SavedInsults({required this.saved});
  @override
  _SavedInsultsState createState() => _SavedInsultsState();
}

class _SavedInsultsState extends State<SavedInsults> {
  late List<bool> isSaved;
  List<String> deleted = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSaved = List.generate(widget.saved.length, (index) => true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Insults'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, deleted);
          },
        ),
      ),
      body: ListView(
        children: [
          for (var i = 0; i < widget.saved.length; i++)
            Column(
              children: [
                ListTile(
                  title: Text(
                    widget.saved.elementAt(i),
                    style: kInsultStyle,
                  ),
                  trailing: TextButton(
                    child: isSaved[i]
                        ? Icon(
                            Icons.bookmark_outlined,
                            color: kLightMainColor,
                          )
                        : Icon(
                            Icons.bookmark_outline,
                            color: kLightMainColor,
                          ),
                    onPressed: () {
                      setState(() {
                        if (isSaved[i]) {
                          isSaved[i] = false;
                          deleted.add(widget.saved.elementAt(i));
                        } else {
                          isSaved[i] = true;
                          deleted.remove(widget.saved.elementAt(i));
                        }
                      });
                    },
                  ),
                ),
                Divider(
                  thickness: 1.0,
                ),
              ],
            )
        ],
      ),
    );
  }
}

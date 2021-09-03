import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:osfs1/getData/getFeedbackQue.dart';

import 'DrawerAdmin.dart';
import 'package:osfs1/constant.dart';


class QuestionScreen extends StatefulWidget {

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController _controller = TextEditingController();

  Future feedbackQue() async {
    feedbackQueList = [];
    await FeedbackQueData().getFeedbackQue().then((value) => {
          feedbackQueMap = value,
          value.forEach((key, value) {
            setState(() {
              feedbackQueList.add(value);
            });
          })
        });
    return feedbackQueMap;
  }

  @override
  void initState() {
    super.initState();
    feedbackQue();
  }

  var question;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Question'),
      ),
      drawer: AdminDrawer(),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Question'),
                    onChanged: (text) {
                      question = text;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    try {
                      setState(() {

                        firestore.collection('Questions').add({
                          'que': question,
                        });
                      });
                    } catch (e) {
                      print(e);
                    }
                    _controller.clear();
                  },
                  child: Text('ADD'),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: feedbackQue(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: feedbackQueMap.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    feedbackQueMap.values
                                        .elementAt(index)
                                        .toString(),
                                    style: TextStyle(fontSize: 22.0),
                                  ),
                                ),
                                IconButton(
                                  alignment: Alignment.centerLeft,
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        content: Text(
                                            "Are you sure you want to delete ?"),
                                        actions: [
                                          TextButton(
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text(
                                              "Delete",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                firestore
                                                    .collection('Questions')
                                                    .doc(feedbackQueMap.keys
                                                        .elementAt(index))
                                                    .delete()
                                                    .then(
                                                        (_) => print('Deleted'))
                                                    .catchError((error) => print(
                                                        'Delete failed: $error'));
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

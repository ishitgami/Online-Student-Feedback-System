import 'package:flutter/material.dart';
import 'package:osfs1/data/model/AdminModel.dart';
import 'package:osfs1/data/model/AdminProvider.dart';
import 'package:osfs1/presentation/screen/admin/addFeedQue.dart';
import 'package:provider/provider.dart';
import 'DrawerAdmin.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
    //Provider
  AdminProvider collegedata;
  AdminData adminData;
  
  
  var feedbackQueMapList;

  @override
  Widget build(BuildContext context) {
     collegedata = Provider.of<AdminProvider>(context);

  collegedata.getFeedQues().then((value) {
    // print(value);
      feedbackQueMapList = value;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Question'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           Navigator.push(context,  MaterialPageRoute(builder: (context) => AddFeedQue()));
        },
        child: Icon(Icons.add),
      ),
      drawer: AdminDrawer(),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              ListView.builder(
              shrinkWrap: true,
              itemCount: feedbackQueMapList == null ? 0 : feedbackQueMapList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                         Expanded(
                          child: Text(
                            feedbackQueMapList.elementAt(index)['Que'].toString(),
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
                                content:
                                    Text("Are you sure you want to delete ?"),
                                actions: [
                                  TextButton(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      collegedata.deleteFeedbackQue(feedbackQueMapList.elementAt(index)['id'].toString());
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
            ),
            ],
          ),
        ),
      )
    );
  }
}

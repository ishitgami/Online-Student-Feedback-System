import 'package:flutter/material.dart';
import 'package:osfs1/data/model/AdminProvider.dart';
import 'package:osfs1/presentation/screen/admin/addFeedRestrictions.dart';
import 'package:provider/provider.dart';
import 'DrawerAdmin.dart';


class RestrictionsScreen extends StatefulWidget {
  @override
  _RestrictionsScreenState createState() =>
      _RestrictionsScreenState();
}

class _RestrictionsScreenState
    extends State<RestrictionsScreen> {
AdminProvider collegedata;

  var feedbackClassMapList;


  @override
  Widget build(BuildContext context) {
    collegedata = Provider.of<AdminProvider>(context);

    collegedata.getFeedbackClass().then((value) {
      setState(() {
         feedbackClassMapList = value;
      });
     
    });
 
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Restrictions'),
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
          Navigator.push(context,  MaterialPageRoute(builder: (context) => AddFeedbackRestriction()));
      },
      child: Icon(Icons.add),
      ),
      drawer: AdminDrawer(),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: feedbackClassMapList == null ? 0 : feedbackClassMapList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              feedbackClassMapList.elementAt(index)['Name'].toString(),
                              style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              feedbackClassMapList.elementAt(index)['subject'].toString(),
                              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
                            ),
                             Text(
                              feedbackClassMapList.elementAt(index)['AcademicYear'].toString(),
                             
                            ),
                            Text(
                              feedbackClassMapList.elementAt(index)['Department'].toString(),
                              
                              style: TextStyle(fontSize: 14.0,),
                            ),
                          ],
                        ),
                        Spacer(),
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
                                      collegedata.deleteFeedbackClass(feedbackClassMapList.elementAt(index)['id'].toString());
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
      
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:osfs1/faculty/studentListScreen.dart';

class AddFclassData extends StatefulWidget {
  @override
  _AddFclassDataState createState() => _AddFclassDataState();
}

class _AddFclassDataState extends State<AddFclassData> {
  String fClassName;
  String fClassDescription;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Add\nFeedBackClass',style: TextStyle(color: Colors.blueAccent,fontSize: 30,fontWeight: FontWeight.bold),),
              SizedBox(
                height: 20,
              ),
              TextField(
                  onChanged: (value) {
                    fClassName = value;
                  },
                  decoration: InputDecoration(
                    label: Text('FeedbackClass Name'),
                  )),
              SizedBox(
                height: 10,
              ),
              TextField(
                  onChanged: (value) {
                    fClassName = value;
                  },
                  decoration: InputDecoration(
                    label: Text('FeedbackClass Description'),
                  )),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancle',style: TextStyle(color :Colors.white),),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                    color: Colors.blueAccent,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentListScreen(),
                        ),
                      );
                    },
                    child: Text('Next',style: TextStyle(color :Colors.white),),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

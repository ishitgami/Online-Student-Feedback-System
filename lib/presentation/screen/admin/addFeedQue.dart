import 'package:flutter/material.dart';
import 'package:osfs1/data/model/AdminProvider.dart';
import 'package:osfs1/core/constant/constant.dart';
import 'package:provider/provider.dart';

class AddFeedQue extends StatefulWidget {
  @override
  State<AddFeedQue> createState() => _AddFeedQueState();
}

class _AddFeedQueState extends State<AddFeedQue> {
  TextEditingController _controller = TextEditingController();
  AdminProvider collegedata;
  var feedbackQuestion;

  @override
  Widget build(BuildContext context) {
    collegedata = Provider.of<AdminProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add FeedBack Questions'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FeedBack Question',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
                minLines: 2, 
                maxLines: 7, 
                controller: _controller,
                style: TextStyle(fontSize: 20),
                onChanged: (text) {
                  feedbackQuestion = text;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                onPressed: ()  {
                  Navigator.pop(context);
                },
                child: Text('BACK')),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        collegedata
                            .addFeedQue(feedbackQuestion);
                        _controller.clear();
                        
                      } catch (e) {
                        print(e);
                      }
                      Navigator.pop(context);
                    },
                    child: Text('ADD')),
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }
}

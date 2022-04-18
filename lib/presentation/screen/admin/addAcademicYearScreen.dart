import 'package:flutter/material.dart';
import 'package:osfs1/core/constant/constant.dart';
import 'package:osfs1/data/model/AdminProvider.dart';
import 'package:provider/provider.dart';

class AddAcademicYearScreen extends StatelessWidget {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  AdminProvider collegedata;

  @override
  Widget build(BuildContext context) {
     collegedata = Provider.of<AdminProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Academic Year'),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: _controller1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Start Year'),
              onChanged: (text) {
                academicYear1 = text;
              },
            ),
            TextField(
              controller: _controller2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'End Year',
              ),
              onChanged: (text) {
                academicYear2 = text;
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
                            .addAcademicYear(academicYear1 + '-' + academicYear2);
                        _controller1.clear();
                        _controller2.clear();
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
    );
  }
}

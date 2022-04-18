import 'package:flutter/material.dart';
import 'package:osfs1/data/model/AdminProvider.dart';
import 'package:provider/provider.dart';

class AddDepartmentScreen extends StatelessWidget {
  TextEditingController _controller = TextEditingController();

  //Provider
  AdminProvider collegedata;
  var departmentName;

  @override
  Widget build(BuildContext context) {
    collegedata = Provider.of<AdminProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Department'),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Department Name'),
              onChanged: (text) {
                departmentName = text;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('BACK')),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        collegedata.addDepartment(departmentName);
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
    );
  }
}

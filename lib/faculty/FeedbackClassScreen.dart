import 'package:flutter/material.dart';

import 'FacultyDrawer.dart';

class FeedbackClassScreen extends StatelessWidget {
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FacultyDrawer(),
      appBar: AppBar(
        title: Text('FeedbackClassScreen'),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('increment_floatingActionButton'),
        child: Icon(Icons.add),
        onPressed: () {
         
        },
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have pushed the button this many times:'),

          ],
        ),
      ),
    );
  }
}


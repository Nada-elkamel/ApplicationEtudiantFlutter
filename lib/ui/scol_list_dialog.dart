import 'package:flutter/material.dart';
import 'package:tp5/models/scol1_list.dart';
import 'package:tp5/util/dbuse.dart';

class ScolListDialog {
  final txtNonClass = TextEditingController();
  final txtNbreEtud = TextEditingController();

  Widget buildDialog(BuildContext context, ScolList list, bool isNew) {
    dbuse helper = dbuse();
    if (!isNew) {
      txtNonClass.text = list.nomClass;
      txtNbreEtud.text = list.nbreEtud.toString();
    }

    return AlertDialog(
      title: Text((isNew) ? 'Class list' : 'Edit class list'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: txtNonClass,
              decoration: InputDecoration(hintText: 'Class List Name'),
            ),
            TextField(
              controller: txtNbreEtud,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Class List number of students'),
            ),
            ElevatedButton(
              child: Text('Save Class List'),
              onPressed: () {
                list.nomClass = txtNonClass.text;
                list.nbreEtud = int.parse(txtNbreEtud.text);
                helper.insertClass(list);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

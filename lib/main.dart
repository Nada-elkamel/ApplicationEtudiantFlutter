import 'package:flutter/material.dart';
import 'package:tp5/models/scol1_list.dart';
import 'package:tp5/ui/students_screen.dart';
import 'package:tp5/util/dbuse.dart';
import 'package:tp5/ui/scol_list_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Classes List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShList(),
    );
  }
}

class ShList extends StatefulWidget {
  @override
  _ShListState createState() => _ShListState();
}

class _ShListState extends State<ShList> {
  List<ScolList> scolList = [];
  dbuse helper = dbuse();
  late ScolListDialog dialog;

  @override
  void initState() {
    dialog = ScolListDialog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    showData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Classes List'),
      ),
      body: ListView.builder(
        itemCount: (scolList != null) ? scolList.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(scolList[index].nomClass),
            onDismissed: (direction) {
              String strName = scolList[index].nomClass;
              helper.deleteList(scolList[index]); // Call your delete method here
              setState(() {
                scolList.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("$strName deleted")),
              );
            },
            child: ListTile(
              title: Text(scolList[index].nomClass),
              leading: CircleAvatar(
                child: Text(scolList[index].codClass.toString()),
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        dialog.buildDialog(context, scolList[index], false),
                  );
                },
              ),
              onTap: () {
                // Use Navigator.push to navigate to the StudentsScreen and pass the ScolList object
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentsScreen(scolList[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                dialog.buildDialog(context, ScolList(0, '', 0), true),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }

  Future showData() async {
    await helper.openDb();
    scolList = await helper.getClasses();
    setState(() {
      scolList = scolList;
    });
  }
}

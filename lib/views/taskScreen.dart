import 'package:NoteAppFirebase/helper/auth.dart';
import 'package:NoteAppFirebase/helper/toggler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  final String uid;
  TaskScreen(this.uid);
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String task;
  var taskCollection = FirebaseFirestore.instance;
  var taskcollections = FirebaseFirestore.instance.collection('tasks');

  void showdialog(bool isUpdate, DocumentSnapshot ds) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: isUpdate ? Text("Update Todo") : Text("Add Todo"),
            content: Form(
                key: formKey,
                child: TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Task"),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "This field can't be empty.";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    task = val;
                  },
                )),
            actions: [
              RaisedButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    if (isUpdate) {
                      taskcollections
                          .doc(widget.uid)
                          .collection("task")
                          .doc(ds.id)
                          .update({'task': task, 'time': DateTime.now()});
                    } else {
                      taskcollections
                          .doc(widget.uid)
                          .collection('task')
                          .add({'task': task, 'time': DateTime.now()});
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text("Add"),
              )
            ],
          );
        });
  }

  AuthMethods authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authentication()));
            },
          )
        ],
      ),
      body: Container(
        // color: Colors.black,
        child: StreamBuilder(
          stream: taskcollections
              .doc(widget.uid)
              .collection('task')
              .orderBy('time')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        ds['task'],
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      onLongPress: () {
                        // delete
                        taskcollections
                            .doc(widget.uid)
                            .collection('task')
                            .doc(ds.id)
                            .delete();
                      },
                      onTap: () {
                        // == Update
                        showdialog(true, ds);
                      },
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showdialog(false, null);
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}

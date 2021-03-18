import 'package:flutter/material.dart';
import 'package:main_page_app/q_and_a/note.dart';
import 'package:main_page_app/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';


class EndScreen extends StatefulWidget{
  int total_questions;
  List<String> subjects;
  EndScreen(this.total_questions,this.subjects);
  @override
  State<StatefulWidget> createState() {
    return _EndScreenState(total_questions,subjects);
  }
}

class _EndScreenState extends State<EndScreen>{
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  int total_questions;
  List<String> subjects;
  List<int> marks=[];
  _EndScreenState(this.total_questions,this.subjects);
  @override
  Widget build(BuildContext context) {

    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Result'),
          ),
          body: ListView(children: <Widget>[
            // Center(
            //     child: Text(
            //       'Your Scores',
            //       style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            //     )),
            getNoteListView()
            // SingleChildScrollView(
            //     scrollDirection: Axis.vertical,
            //     child: SingleChildScrollView(
            //         scrollDirection: Axis.horizontal,
            //         child:DataTable(
            //         columns: [
            //           DataColumn(label: Text(
            //               'Subjects',
            //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            //           )),
            //           DataColumn(label: Text(
            //               'Score',
            //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            //           )),
            //           DataColumn(label: Text(
            //               'Total Marks',
            //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            //           )),
            //         ],
            //         rows: getLists()
            //       ),
            // )),
          ])
      ),
    );
  }

  List<DataRow> getLists(){
    List<DataRow> dataRowList=[];
    for(int i=0;i<subjects.length;i++){
      DataRow row=DataRow(cells: [
        DataCell(Text(subjects[i])),
        DataCell(Text('2')),
        DataCell(Text(total_questions.toString())),
      ]);
      dataRowList.add(row);
    }
    return dataRowList;
  }

  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  ListView getNoteListView() {

    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            title: Text(this.noteList[position].title, style: titleStyle,),

            subtitle: Text(this.noteList[position].marks0+" "+this.noteList[position].marks1+" "+this.noteList[position].marks2),

          ),
        );
      },
    );
  }

}
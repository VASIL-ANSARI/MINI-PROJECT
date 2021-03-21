import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EndScreen extends StatefulWidget{
  int total_questions;
  List<String> subjects;
  String registration_number;
  EndScreen(this.total_questions,this.subjects,this.registration_number);
  @override
  State<StatefulWidget> createState() {
    return _EndScreenState(total_questions,subjects,registration_number);
  }
}

class _EndScreenState extends State<EndScreen>{
  int count = 0;
  List<String> marks=[];
  String registration_number;

  int total_questions;
  List<String> subjects;
  var number=0;

  _EndScreenState(this.total_questions,this.subjects,this.registration_number);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
          appBar: AppBar(
            title: Text('Result'),
          ),
          body: ListView(children: <Widget>[
            Center(
                child: Text(
                  'Your Scores',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
            SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:DataTable(
                    columns: [
                      DataColumn(label: Text(
                          'Subjects',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                      )),
                      DataColumn(label: Text(
                          'Score',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                      )),
                      DataColumn(label: Text(
                          'Total Marks',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                      )),
                    ],
                    rows: getLists()
                  ),
            )),
          ])
      );
  }

  List<DataRow> getLists(){
    List<DataRow> dataRowList=[];
    for(int i=0;i<subjects.length;i++){
      DataRow row=DataRow(cells: [
        DataCell(Text(subjects[i])),
        DataCell(FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return CircularProgressIndicator();
            }
            return Text(
              snapshot.data.getStringList(registration_number+'_'+subjects[i])!=null?snapshot.data.getStringList(registration_number+'_'+subjects[i])[0]:"NA"
            );
          },
        )),
        DataCell(Text("5")),
      ]);
      dataRowList.add(row);
    }
    return dataRowList;
  }

  Future<List<String>> read(String s) async {
    var prefs = await SharedPreferences.getInstance();
    var value = prefs.getStringList(s);
    print("Value : $value");
    marks.addAll(value);
    return value;
  }

}
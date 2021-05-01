import 'package:flutter/material.dart';
import 'package:main_page_app/q_and_a/video_description.dart';
import 'package:main_page_app/screens/you_tube_screen.dart';

class VideoScreen extends StatefulWidget{

  String branch;
  VideoScreen(this.branch);
  @override
  State<StatefulWidget> createState() {
    return _VideoScreenState(branch);
  }
}

class _VideoScreenState extends State<VideoScreen>{

  List<VideoDescription> lists;
  String branch;

  _VideoScreenState(this.branch){
    if (branch.toLowerCase() == "b.tech cs") {
      lists=_getCSLectures();
    } else if (branch.toLowerCase() == "b.tech ee") {
      lists=_getEELectures();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child:Text('Video Lectures',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)),
      ),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          _getRowWidget(lists[0].name,lists[0].image,lists[0].description,lists[0].url),
          _getRowWidget(lists[1].name,lists[1].image,lists[1].description,lists[1].url),
          _getRowWidget(lists[2].name,lists[2].image,lists[2].description,lists[2].url),
          _getRowWidget(lists[3].name,lists[3].image,lists[3].description,lists[3].url),
          _getRowWidget(lists[4].name,lists[4].image,lists[4].description,lists[4].url),
          _getRowWidget(lists[5].name,lists[5].image,lists[5].description,lists[5].url),
          _getRowWidget(lists[6].name,lists[6].image,lists[6].description,lists[6].url),
          _getRowWidget(lists[7].name,lists[7].image,lists[7].description,lists[7].url)
        ],
      ),
    );
  }

  Widget _getRowWidget(String name,String image,String description,String url){
    return Container(
      margin: EdgeInsets.only(top:5.0,left: 10.0,right: 10.0),
      child: FlatButton(onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (context){
          return Youtube(title:'Video', url:url);
        }));
      }, child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(5.0),
            child: Image.asset(image),
            height:100.0,
            width: 100.0,
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(2.0),
                child: Container(child: Text(name,style: TextStyle(color: Colors.teal,fontWeight: FontWeight.w800),),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child:Container(child: Text(description,style: TextStyle(color: Colors.brown,fontWeight: FontWeight.bold),),
                width: MediaQuery.of(context).size.width-180,)

              )
            ],
          )
        ],
      )
        , padding: EdgeInsets.all(20.0),color: Colors.white,),
    );
  }

  List<VideoDescription> _getCSLectures(){
    return [
      VideoDescription('DBMS','Database Management System-Overview,introduction and many more...','https://www.youtube.com/watch?v=3EJlovevfcA','images/dbms.jpg'),
      VideoDescription('OS','Basics and Intro to Operating Systems','https://www.youtube.com/watch?v=WJ-UaAaumNA','images/os.jpg'),
      VideoDescription('OS','Operating Systems','https://www.youtube.com/playlist?list=PLBlnK6fEyqRiVhbXDGLXDk_OQAeuVcp2O','images/os1.jpg'),
      VideoDescription('Computer Networking','Different layers of OSI model','https://youtu.be/4D55Cmj2t-A','images/cn.jpg'),
      VideoDescription('Computer Networking','Different layers of models','https://www.youtube.com/watch?v=UXMIxCYZu8o&list=PLEbnTDJUr_IegfoqO4iPnPYQui46QqT0j&index=3','images/cn1.jpg'),
      VideoDescription('Compiler Design','Different Stages during compilation','https://www.youtube.com/watch?v=XUsw5igq4DM&list=PLxCzCOWd7aiEKtKSIHYusizkESC42diyc','images/ccn.jpg'),
      VideoDescription('Digital Electronics','Basics and Intro to Digital Electronics','https://youtu.be/M0mx8S05v60','images/de.jpg'),
      VideoDescription('Computer Organization','Basics and Intro to Computer architectures','https://youtu.be/zMkye9iaWB4','images/coa.jpg'),
    ];
  }

  List<VideoDescription> _getEELectures(){
    return [
      VideoDescription('Control Systems','Understanding control systems in detail','https://youtu.be/HcLYoCmWOjI','images/cs.jpg'),
      VideoDescription('Power Systems','Understanding power systems in detail','https://youtu.be/pWd2b-F4STw','images/ps.jpg'),
      VideoDescription('Network Theory','Theory of networking','https://youtu.be/NEhH6C7Fzw4','images/nt.jpg'),
      VideoDescription('Analog Electronics','Analog Signals basic and Intro','https://youtu.be/7jaa1rlW7Ak','images/ae.jpg'),
      VideoDescription('Signals and Systems','Signals and Systems','https://youtu.be/s8rsR_TStaA','images/ss.jpg'),
      VideoDescription('Engineering Mathematics','Fundamental of mathematics for engineering','https://youtu.be/Nzxh9YjRAFw','images/em.jpg'),
      VideoDescription('Communication Theory','Theory of communication','https://youtu.be/kAs8OerKRmc','images/ct.png'),
      VideoDescription('Electromagnetic field Theory','Basics and Intro to Electromagnetic theory','https://youtu.be/FtEShPAFpek','images/ps.jpg'),
    ];
  }
}
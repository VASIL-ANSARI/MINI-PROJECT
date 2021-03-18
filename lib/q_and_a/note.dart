
class Note {

  int _id;
  String _title;
  String _marks0;
  String _marks1;
  String _marks2;

  Note(this._title, [this._marks0, this._marks1,this._marks2]);

  Note.withId(this._id,this._title, [this._marks0, this._marks1,this._marks2]);


  int get id => _id;

  set id(int value) {
    _id = value;
  } // Convert a Note object into a Map object

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get marks0 => _marks0;

  set marks0(String value) {
    _marks0 = value;
  }

  String get marks1 => _marks1;

  set marks1(String value) {
    _marks1 = value;
  }

  String get marks2 => _marks2;

  set marks2(String value) {
    _marks2 = value;
  }

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['marks0'] = _marks0;
    map['marks1'] = _marks1;
    map['marks2'] = _marks2;

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._marks0 = map['marks0'];
    this._marks1 = map['marks1'];
    this._marks2 = map['marks2'];
  }

}
import 'package:flutter/material.dart';

class QA{
  String _question;
  String _answer;
  List<String> _choices;

  QA(this._question, this._answer, this._choices);

  List<String> get choices => _choices;

  set choices(List<String> value) {
    _choices = value;
  }

  String get answer => _answer;

  set answer(String value) {
    _answer = value;
  }

  String get question => _question;

  set question(String value) {
    _question = value;
  }
}
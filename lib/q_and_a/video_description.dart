import 'package:flutter/material.dart';

class VideoDescription {
  String _name;
  String _description;
  String _url;
  String _image;

  VideoDescription(this._name, this._description, this._url, this._image);

  String get image => _image;

  String get url => _url;

  String get description => _description;

  String get name => _name;
}
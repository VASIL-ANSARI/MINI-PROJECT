import 'package:flutter/material.dart';

const String _onemath = 'PDFs/onemath.pdf';
const String _onephysics = 'PDFs/onephysics.pdf';
const String _oneC = 'PDFs/oneC.pdf';
const String _twocseDSA = 'PDFs/twocseDSA.pdf';
const String _twocseOOP = 'PDFs/twocseOOP.pdf';
const String _twocseDM = 'PDFs/twocseDM.pdf';
const String _threecseCOA = 'PDFs/threecseCOA.pdf';
const String _threecseOS = 'PDFs/threecseOS.pdf';
const String _threecseDBMS = 'PDFs/threecseDBMS.pdf';
const String _threecseCN = 'PDFs/threecseCN.pdf';
const String _twoeeeBEE = 'PDFs/twoeeeBEE.pdf';
const String _twoeeeEFT = 'PDFs/twoeeeEFT.pdf';
const String _twoeeePS = 'PDFs/twoeeePS.pdf';
const String _twoeeeSS = 'PDFs/twoeeeSS.pdf';
const String _threeeeeES = 'PDFs/threeeeeES.pdf';
const String _threeeeeCT = 'PDFs/threeeeeCT.pdf';
const String _threeeeeCOA = 'PDFs/threeeeeCOA.pdf';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

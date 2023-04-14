import 'dart:core';

class Tender {
  int tenderNo;
  String dept;
  DateTime bidStartDate;
  DateTime bidDueDate;
  String description;
  String pac;

  Tender(
      {required this.tenderNo,
      required this.dept,
      required this.bidStartDate,
      required this.bidDueDate,
      required this.description,
      required this.pac});

  factory Tender.fromJson(Map<String, dynamic> parsedJson) {
    return Tender(
        tenderNo: parsedJson['tenderNo'],
        dept: parsedJson['dept'],
        bidStartDate:
            DateTime.fromMillisecondsSinceEpoch(parsedJson['bidStartDate']),
        bidDueDate:
            DateTime.fromMillisecondsSinceEpoch(parsedJson['bidDueDate']),
        description: parsedJson['description'],
        pac: parsedJson['pac']);
  }
}

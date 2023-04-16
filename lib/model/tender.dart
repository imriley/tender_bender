import 'dart:core';

class Tender {
  int tenderNo;
  String dept;
  int bidStartDate;
  int bidDueDate;
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
        bidStartDate: parsedJson['bidStartDate'],
        bidDueDate: parsedJson['bidDueDate'],
        description: parsedJson['description'],
        pac: parsedJson['pac']);
  }
}

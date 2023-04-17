import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tender_bender/model/tender.dart';

class TenderPage extends StatelessWidget {
  final Tender tender;
  const TenderPage({super.key, required this.tender});

  String convertDatetime(datetime) {
    datetime = DateTime.fromMillisecondsSinceEpoch(datetime * 1000);
    DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm:ss a");
    String string = dateFormat.format(datetime);
    return string;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 246, 251, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          iconSize: 32,
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF322651),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
          child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Tender No: ",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF322651),
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          tender.tenderNo.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF444162),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Department Name",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF322651),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      tender.dept,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF444162),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF322651),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      tender.description,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF444162),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Bid Submission Start Date",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF322651),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      convertDatetime(tender.bidStartDate),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF444162),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Bid Due Date",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF322651),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      convertDatetime(tender.bidDueDate),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF444162),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Estimated Value: ",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF322651),
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          tender.pac != '0' ? tender.pac : 'Not available',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF444162),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Share.share(
                        "Check out this tender I found in Tender Bender: \nTender No: ${tender.tenderNo}\nDepartment Name: ${tender.dept}\nDescription: ${tender.description}\nBid Submission Start Date: ${tender.bidStartDate}\nBid Due Date: ${tender.bidDueDate}\nEstimated Value: ${tender.pac != '0' ? tender.pac : 'Not available'}",
                        subject:
                            "Check out this tender I found in Tender Bender");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7853),
                    minimumSize: const Size.fromHeight(32),
                  ),
                  child: const Text(
                    'Share',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}

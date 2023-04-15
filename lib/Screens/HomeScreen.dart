import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tender_bender/model/tender.dart';
import 'package:tender_bender/utils/debouncer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  final FocusNode _focusSearch = FocusNode();
  List<Tender> tenderList = [];
  List<Tender> filteredTenderList = [];
  final _debouncer = Debouncer(milliseconds: 1000);

  Future<void> readJson() async {
    final String jsonString =
        await rootBundle.loadString('assets/tenders.json');
    Iterable jsonResponse = json.decode(jsonString);
    tenderList = jsonResponse.map((e) => Tender.fromJson(e)).toList();
    setState(() {
      filteredTenderList = tenderList;
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusSearch.unfocus();
      },
      onPanStart: (details) {
        _focusSearch.unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(247, 246, 251, 1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarOpacity: 0,
          titleSpacing: 16,
          toolbarHeight: double.tryParse('40'),
          title: const Text(
            "Hello Alexa",
            style: TextStyle(
              color: Color(0xFF322651),
              fontSize: 20,
            ),
          ),
          actions: const [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80"),
            ),
            SizedBox(
              width: 16,
            )
          ],
        ),
        body: Center(
          child: SizedBox(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Find Tenders",
                    style: TextStyle(
                        fontSize: 28,
                        color: Color(0xFF322651),
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            focusNode: _focusSearch,
                            controller: searchController,
                            onChanged: (string) {
                              _debouncer.run(() {
                                setState(() {
                                  filteredTenderList = tenderList
                                      .where((tender) => (tender.dept
                                              .toLowerCase()
                                              .contains(string.toLowerCase()) ||
                                          tender.tenderNo
                                              .toString()
                                              .toLowerCase()
                                              .contains(string.toLowerCase())))
                                      .toList();
                                });
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              filled: true,
                              hintText: "Search for departments, tender no...",
                              hintStyle: const TextStyle(
                                color: Color(0xFF9E9E9E),
                              ),
                              fillColor: const Color(0xFFEEF1F7),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xFFEEF1F7),
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: Color(0xFFEEF1F7),
                                ),
                              ),
                              suffixIcon: searchController.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Color(0xFF9E9E9E),
                                      ),
                                      onPressed: () {
                                        searchController.clear();
                                        setState(
                                          () {
                                            filteredTenderList = tenderList;
                                          },
                                        );
                                      },
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: const Color(0xFFFF7853),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          child: const Icon(
                            Icons.search,
                            size: 28,
                            color: Color(0xFFE7E4E7),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: filteredTenderList.isNotEmpty
                        ? ListView.builder(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            shrinkWrap: true,
                            itemCount: filteredTenderList.length,
                            itemBuilder: (BuildContext context, int index) {
                              Tender tender = filteredTenderList[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEEF1F6),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () {
                                      print('Hello');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            tender.dept,
                                            style: TextStyle(
                                              fontFamily: GoogleFonts.poppins()
                                                  .fontFamily,
                                              fontSize: 16,
                                              letterSpacing: 0.1,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFF322651),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            tender.description,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF444162),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Tender No: ",
                                                    style: TextStyle(
                                                        fontFamily: GoogleFonts
                                                                .poppins()
                                                            .fontFamily,
                                                        fontSize: 14,
                                                        color: const Color(
                                                            0xFF322651),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    tender.tenderNo.toString(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily:
                                                          GoogleFonts.poppins()
                                                              .fontFamily,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: const Color(
                                                          0xFF444162),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              if (tender.pac != '0') ...[
                                                Row(
                                                  children: [
                                                    Text(
                                                      "PAC: ",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .poppins()
                                                                  .fontFamily,
                                                          fontSize: 14,
                                                          color: const Color(
                                                              0xFF322651),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      tender.pac,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: GoogleFonts
                                                                .poppins()
                                                            .fontFamily,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color(
                                                            0xFF444162),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ]
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text(
                              "No Data found.",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

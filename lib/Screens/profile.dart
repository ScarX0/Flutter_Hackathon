import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {

  bool changer = false;
  bool _isLoading = false;

  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final WidthSize = MediaQuery.of(context).size.width;
    final HeightSize = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top +
            MediaQuery.of(context).padding.bottom);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xff4FBDBA).withOpacity(0.5),
        body: SingleChildScrollView(
          child: Container(
            // height: HeightSize,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: Color(0xff072227),
                ),
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: HeightSize * 0.32,
                      ),
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xff4FBDBA).withOpacity(0.5),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100),
                                //  bottomLeft: Radius.circular(100),
                              ),
                            ),
                            child: Container()),
                      )
                    ],
                  ),
                ),
                Container(
                  height: WidthSize * 0.12,
                  width: WidthSize * 0.12,
                  decoration: BoxDecoration(
                    color: Color(0xff4FBDBA),
                    borderRadius: BorderRadius.circular(80.0),
                  ),
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      left: WidthSize * 0.01),
                  child: InkWell(
                      child: Transform.rotate(
                        angle: 180 * math.pi / 180,
                        child: Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: WidthSize * (40.0 / 540),
                        ),
                      ),
                      onTap: () async {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('تسجبيل الخروج'),
                            content: const Text('متأكد ؟'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text(
                                  'لا',
                                  style: TextStyle(color: Color(0xff4FBDBA)),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {},
                                child: const Text(
                                  'نعم',
                                  style: TextStyle(color: Color(0xff4FBDBA)),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                //////

                ///////
                Container(
                  margin: EdgeInsets.only(top: HeightSize * 0.22),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: WidthSize * (80 / 540),
                        ),
                        SizedBox(
                            child: GestureDetector(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  TextStyle style = TextStyle(
                                    fontSize: WidthSize * 0.03148,
                                    fontFamily: 'Baloo Thambi 2',
                                    color: Colors.white,
                                  );
                                  return AlertDialog(
                                    title: Text(
                                      'اختر صورة',
                                      style: TextStyle(
                                        fontSize: WidthSize * 0.03148,
                                        fontFamily: 'Baloo Thambi 2',
                                        color: Colors.black,
                                      ),
                                    ),
                                    actions: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color: Color(0xff4FBDBA)),
                                        child: ListTile(
                                          leading: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                          ),
                                          title: Text(
                                            'التقط صورة',
                                            style: style,
                                          ),
                                          minLeadingWidth: 1.0,
                                          onTap: () async {},
                                        ),
                                      ),
                                      SizedBox(height: HeightSize * 0.01644),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color: Color(0xff4FBDBA)),
                                        child: ListTile(
                                          leading: const Icon(
                                            Icons.photo_album_outlined,
                                            color: Colors.white,
                                          ),
                                          title: Text(
                                            'اختر من معرض الصور',
                                            style: style,
                                          ),
                                          minLeadingWidth: 1.0,
                                          onTap: () async {},
                                        ),
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: HeightSize * 0.01),
                            child: Text(
                              "تغيير الصورة الشخصية",
                              style: TextStyle(
                                fontSize: WidthSize * 0.032,
                                color: Colors.white,
                                fontFamily: 'Gothic',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        )),
                        Padding(
                          padding: EdgeInsets.only(top: HeightSize * 0.05),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "الاسم  ",
                                    style: TextStyle(
                                        fontSize: WidthSize * (30 / 540),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'Gothic'),
                                  ),
                                  Text(
                                    "البريد الالكتروني",
                                    style: TextStyle(
                                        fontSize: WidthSize * (30 / 540),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'Gothic'),
                                  ),
                                  Text(
                                    "رقم الهاتف",
                                    style: TextStyle(
                                        fontSize: WidthSize * (30 / 540),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'Gothic'),
                                  ),
                                  !changer
                                      ? SizedBox(
                                          height: HeightSize * 0.22,
                                        )
                                      : SizedBox(
                                          height: HeightSize * 0.08,
                                        ),
                                ],
                              ),
                              changer
                                  ? Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.topCenter,
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: WidthSize * 0.05),
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Color(
                                                                  0xff072227)),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.0),
                                                          side:
                                                              const BorderSide(
                                                            color: Colors.white,
                                                            width: 2.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    child: const Icon(
                                                      Icons.clear,
                                                      color: Colors.white,
                                                      size: 32.0,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        changer = false;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: WidthSize * 0.07),
                                                  width: WidthSize * 0.65,
                                                  child: Form(
                                                    key: _formKey,
                                                    child: TextFormField(
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      textAlign:
                                                          TextAlign.right,
                                                      controller:
                                                          _nameController,
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.length < 2) {
                                                          return 'Invalid name';
                                                        }
                                                        return null;
                                                      },
                                                      onSaved: (value) {},
                                                      keyboardType:
                                                          TextInputType.name,
                                                      cursorColor:
                                                          Color(0xff4FBDBA),
                                                      decoration:
                                                          InputDecoration(
                                                        errorStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: 'Gothic',
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0)),

                                                        hoverColor:
                                                            Colors.black,
                                                        focusColor:
                                                            Color(0xff4FBDBA),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    const BorderSide(
                                                                  color: Color(
                                                                      0xff4FBDBA),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0)),
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        //          contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                                        hintText:
                                                            'الاسم الجديد',
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                        suffixIcon: const Icon(
                                                          Icons.edit,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: HeightSize * 0.03,
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(),

                              RaisedButton(
                                onPressed: () async {
                                  if (changer) {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        changer = false;
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      changer = true;
                                    });
                                  }
                                },
                                padding: const EdgeInsets.all(0.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Container(
                                  width: WidthSize * 0.9,
                                  height: HeightSize * 0.09,
                                  decoration: const BoxDecoration(
                                      color: Color(0xff072227),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: Center(
                                    child: Text(
                                      !changer ? "تغيير الاسم" : "تحديث",
                                      style: TextStyle(
                                        fontFamily: "Gothic",
                                        fontSize: WidthSize * (25 / 540),
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),

                              // Text(snapshot
                              //     .data!
                              //     .docs[snapshot.data!.docs.indexWhere((element) =>
                              // element['id'] ==
                              //     Provider.of<AuthService>(context, listen: false).ID)]
                              //     .id),
                              // RaisedButton(
                              //   onPressed: () async {
                              //     await FirebaseFirestore.instance
                              //         .collection('users')
                              //         .doc(snapshot
                              //         .data!
                              //         .docs[snapshot.data!.docs.indexWhere((element) =>
                              //     element['id'] ==
                              //         Provider.of<AuthService>(context, listen: false)
                              //             .ID)]
                              //         .id)
                              //         .update({"name": "hello"});
                              //   },
                              //   textColor: Color(0xffE50914),
                              //   padding: const EdgeInsets.all(0.0),
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(20.0)),
                              //   child: Container(
                              //     width: 90,
                              //     height: 40,
                              //     decoration: const BoxDecoration(
                              //         color: Colors.blue,
                              //         borderRadius: BorderRadius.all(Radius.circular(20.0))),
                              //     child: Center(
                              //       child: Text(
                              //         "modify",
                              //         style: TextStyle(
                              //           fontFamily: "Gothic",
                              //           fontSize: 18,
                              //           color: Colors.black,
                              //           fontWeight: FontWeight.bold,
                              //         ),
                              //         textAlign: TextAlign.center,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // Container(
                              //   color: Colors.yellow,
                              //   height: 250,
                              //   child: ListView.builder(
                              //       itemCount: snapshot.data!.docs.length,
                              //       itemBuilder: (BuildContext context, int index) {
                              //         return ListTile(
                              //             trailing: Text(
                              //               snapshot.data!.docs[index]['isBoutique']
                              //                   ? "BT"
                              //                   : "/",
                              //               style:
                              //               TextStyle(color: Colors.green, fontSize: 15),
                              //             ),
                              //             title:
                              //             Text("${snapshot.data!.docs[index]['name']}"));
                              //       }),
                              // ),
                              // RaisedButton(
                              //   onPressed: () async {
                              //     await authService.signOut();
                              //   },
                              //   textColor: Color(0xffE50914),
                              //   padding: const EdgeInsets.all(0.0),
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(20.0)),
                              //   child: Container(
                              //     width: 90,
                              //     height: 40,
                              //     decoration: const BoxDecoration(
                              //         color: Colors.white,
                              //         borderRadius: BorderRadius.all(Radius.circular(20.0))),
                              //     child: Center(
                              //       child: Text(
                              //         "logout",
                              //         style: TextStyle(
                              //           fontFamily: "Gothic",
                              //           fontSize: 18,
                              //           color: Colors.black,
                              //           fontWeight: FontWeight.bold,
                              //         ),
                              //         textAlign: TextAlign.center,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

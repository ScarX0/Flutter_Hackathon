import 'package:flutter/material.dart';
import 'dart:math' as math;


class menu extends StatefulWidget {
  const menu({Key? key}) : super(key: key);

  @override
  State<menu> createState() => _menuState();
}

class _menuState extends State<menu> {
  final _soupeController = TextEditingController();
  final _plat1Controller = TextEditingController();
  final _plat2Controller = TextEditingController();
  final _entreeController = TextEditingController();
  final _dessertController = TextEditingController();
  final _autreController = TextEditingController();

  bool soupe = true ;
  bool plat1 = true ;
  bool plat2 = true ;
  bool entree= true ;
  bool dessert= true ;
  bool autre = true ;

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
      child:Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Transform.rotate(
              angle: 180 * math.pi / 180,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.white,
                ),
                onPressed: () {Navigator.pop(context);},
              ),
            )
          ],
          backgroundColor: Color(0xff582e44),
          title: Center(child: Text("وجبة اليوم")),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: WidthSize*0.05 , vertical: HeightSize*0.05),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                Container(
                  height: HeightSize * 0.07,
                  padding: EdgeInsets.only(
                      bottom: HeightSize * 0.015),
                  child: FilterChip(
                    padding: EdgeInsets.only(
                        bottom: HeightSize * 0.01332),
                    selectedColor:
                    const Color(0xff582e44),
                    showCheckmark: false,
                    labelStyle: const TextStyle(),
                    labelPadding:
                    const EdgeInsets.all(7),
                    label: Text(
                      '  الطبق الثاني',
                      style: TextStyle(
                          color: plat2
                              ? Colors.white
                              : Colors.black),
                    ),
                    selected: plat2,
                    onSelected: (bool value) {
                      setState(() {
                        plat2 = !plat2;
                      });
                    },
                  ),
                ),
                Container(
                  height: HeightSize * 0.07,
                  padding: EdgeInsets.only(
                      bottom: HeightSize * 0.015),
                  child: FilterChip(
                    padding: EdgeInsets.only(
                        bottom: HeightSize * 0.01332),
                    selectedColor:
                    const Color(0xff582e44),
                    showCheckmark: false,
                    labelStyle: const TextStyle(),
                    labelPadding:
                    const EdgeInsets.all(7),
                    label: Text(
                      'الطبق الأساسي',
                      style: TextStyle(
                          color: plat1
                              ? Colors.white
                              : Colors.black),
                    ),
                    selected: plat1,
                    onSelected: (bool value) {
                      setState(() {
                        plat1 = !plat1;
                      });
                    },
                  ),
                ),
                Container(
                  height: HeightSize * 0.07,
                  padding: EdgeInsets.only(
                      bottom: HeightSize * 0.015),
                  child: FilterChip(
                    padding: EdgeInsets.only(
                        bottom: HeightSize * 0.01332),
                    selectedColor:
                    const Color(0xff582e44),
                    showCheckmark: false,
                    labelStyle: const TextStyle(),
                    labelPadding:
                    const EdgeInsets.all(7),
                    label: Text(
                      '  الحساء  ',
                      style: TextStyle(
                          color: soupe
                              ? Colors.white
                              : Colors.black),
                    ),
                    selected: soupe,
                    onSelected: (bool value) {
                      setState(() {
                        soupe = !soupe;
                      });
                    },
                  ),
                ),
              ],) ,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [
                Container(
                  height: HeightSize * 0.07,
                  padding: EdgeInsets.only(
                      bottom: HeightSize * 0.015),
                  child: FilterChip(
                    padding: EdgeInsets.only(
                        bottom: HeightSize * 0.01332),
                    selectedColor:
                    const Color(0xff582e44),
                    showCheckmark: false,
                    labelStyle: const TextStyle(),
                    labelPadding:
                    const EdgeInsets.all(7),
                    label: Text(
                      ' اخرى  ',
                      style: TextStyle(
                          color: autre
                              ? Colors.white
                              : Colors.black),
                    ),
                    selected: autre,
                    onSelected: (bool value) {
                      setState(() {
                        autre = !autre;
                      });
                    },
                  ),
                ),
                Container(
                  height: HeightSize * 0.07,
                  padding: EdgeInsets.only(
                      bottom: HeightSize * 0.015),
                  child: FilterChip(
                    padding: EdgeInsets.only(
                        bottom: HeightSize * 0.01332),
                    selectedColor:
                    const Color(0xff582e44),
                    showCheckmark: false,
                    labelStyle: const TextStyle(),
                    labelPadding:
                    const EdgeInsets.all(7),
                    label: Text(
                      'التحلية ',
                      style: TextStyle(
                          color: dessert
                              ? Colors.white
                              : Colors.black),
                    ),
                    selected: dessert,
                    onSelected: (bool value) {
                      setState(() {
                        dessert = !dessert;
                      });
                    },
                  ),
                ),
                Container(
                  height: HeightSize * 0.07,
                  padding: EdgeInsets.only(
                      bottom: HeightSize * 0.015),
                  child: FilterChip(
                    padding: EdgeInsets.only(
                        bottom: HeightSize * 0.01332),
                    selectedColor:
                    const Color(0xff582e44),
                    showCheckmark: false,
                    labelStyle: const TextStyle(),
                    labelPadding:
                    const EdgeInsets.all(7),
                    label: Text(
                      '  المقبلة  ',
                      style: TextStyle(
                          color: entree
                              ? Colors.white
                              : Colors.black),
                    ),
                    selected: entree,
                    onSelected: (bool value) {
                      setState(() {
                        entree = !entree;
                      });
                    },
                  ),
                ),
              ],) ,
              (soupe ||plat1 ||plat2||entree||dessert||autre) ?     Container(
              height: HeightSize*0.55,
              child: Column(children: [
              SizedBox(height: HeightSize*0.01,),
              soupe?     SizedBox(
                height:
                HeightSize * 0.09,
                child: TextFormField(
                  textDirection:
                  TextDirection.rtl,
                  textAlign: TextAlign.right,
                  controller: _soupeController,
                  validator: (value) {
                    if (value == null ||
                        value.length < 3) {
                      return 'Invalid a';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    //  _authData['email'] = value!;
                  },
                  keyboardType:
                  TextInputType.name,
                  cursorColor:
                  Color(0xff582e44),
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.fromLTRB(
                        0,
                        0,
                        WidthSize*0.05,
                        0),
                    errorStyle: TextStyle(
                      color: Colors.white,
                      fontWeight:
                      FontWeight.w400,
                    ),
                    errorBorder:
                    OutlineInputBorder(
                        borderSide:
                        const BorderSide(
                          color:
                          Colors.white,
                        ),
                        borderRadius:
                        BorderRadius
                            .circular(
                            20.0)),
                    hoverColor: Colors.black,
                    focusColor:
                    Color(0xff582e44),
                    focusedBorder:
                    OutlineInputBorder(
                        borderSide:
                        const BorderSide(
                          color: Color(
                              0xff582e44),
                        ),
                        borderRadius:
                        BorderRadius
                            .circular(
                            20.0)),
                    fillColor: Colors.white,
                    filled: true,
                    //          contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                    hintText: 'الحساء',
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius
                            .circular(
                            20.0)),

                  ),
                ),
              ):Container(),
              plat1?    SizedBox(
                height:
                HeightSize * 0.09,
                child: TextFormField(
                  textDirection:
                  TextDirection.rtl,
                  textAlign: TextAlign.right,
                  controller: _plat1Controller,
                  validator: (value) {
                    if (value == null ||
                        value.length < 3) {
                      return 'Invalid b';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    //  _authData['email'] = value!;
                  },
                  keyboardType:
                  TextInputType.name,
                  cursorColor:
                  Color(0xff582e44),
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.fromLTRB(
                        0,
                        0,
                        WidthSize*0.05,
                        0),
                    errorStyle: TextStyle(
                      color: Colors.white,
                      fontWeight:
                      FontWeight.w400,
                    ),
                    errorBorder:
                    OutlineInputBorder(
                        borderSide:
                        const BorderSide(
                          color:
                          Colors.white,
                        ),
                        borderRadius:
                        BorderRadius
                            .circular(
                            20.0)),
                    hoverColor: Colors.black,
                    focusColor:
                    Color(0xff582e44),
                    focusedBorder:
                    OutlineInputBorder(
                        borderSide:
                        const BorderSide(
                          color: Color(
                              0xff582e44),
                        ),
                        borderRadius:
                        BorderRadius
                            .circular(
                            20.0)),
                    fillColor: Colors.white,
                    filled: true,
                    //          contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                    hintText: 'الطبق الأساسي',
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius
                            .circular(
                            20.0)),

                  ),
                ),
              ):Container(),
              plat2?   SizedBox(
                height:
                HeightSize * 0.09,
                child: TextFormField(
                  textDirection:
                  TextDirection.rtl,
                  textAlign: TextAlign.right,
                  controller: _plat2Controller,
                  validator: (value) {
                    if (value == null ||
                        value.length < 3) {
                      return 'Invalid a';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    //  _authData['email'] = value!;
                  },
                  keyboardType:
                  TextInputType.name,
                  cursorColor:
                  Color(0xff582e44),
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.fromLTRB(
                        0,
                        0,
                        WidthSize*0.05,
                        0),
                    errorStyle: TextStyle(
                      color: Colors.white,
                      fontWeight:
                      FontWeight.w400,
                    ),
                    errorBorder:
                    OutlineInputBorder(
                        borderSide:
                        const BorderSide(
                          color:
                          Colors.white,
                        ),
                        borderRadius:
                        BorderRadius
                            .circular(
                            20.0)),
                    hoverColor: Colors.black,
                    focusColor:
                    Color(0xff582e44),
                    focusedBorder:
                    OutlineInputBorder(
                        borderSide:
                        const BorderSide(
                          color: Color(
                              0xff582e44),
                        ),
                        borderRadius:
                        BorderRadius
                            .circular(
                            20.0)),
                    fillColor: Colors.white,
                    filled: true,
                    //          contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                    hintText: 'الطبق الثاني',
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius
                            .circular(
                            20.0)),

                  ),
                ),
              ):Container(),
              entree?  SizedBox(
                height:
                HeightSize * 0.09,
                child: TextFormField(
                  textDirection:
                  TextDirection.rtl,
                  textAlign: TextAlign.right,
                  controller: _entreeController,
                  validator: (value) {
                    if (value == null ||
                        value.length < 3) {
                      return 'Invalid a';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    //  _authData['email'] = value!;
                  },
                  keyboardType:
                  TextInputType.name,
                  cursorColor:
                  Color(0xff582e44),
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.fromLTRB(
                        0,
                        0,
                        WidthSize*0.05,
                        0),
                    errorStyle: TextStyle(
                      color: Colors.white,
                      fontWeight:
                      FontWeight.w400,
                    ),
                    errorBorder:
                    OutlineInputBorder(
                        borderSide:
                        const BorderSide(
                          color:
                          Colors.white,
                        ),
                        borderRadius:
                        BorderRadius
                            .circular(
                            20.0)),
                    hoverColor: Colors.black,
                    focusColor:
                    Color(0xff582e44),
                    focusedBorder:
                    OutlineInputBorder(
                        borderSide:
                        const BorderSide(
                          color: Color(
                              0xff582e44),
                        ),
                        borderRadius:
                        BorderRadius
                            .circular(
                            20.0)),
                    fillColor: Colors.white,
                    filled: true,
                    //          contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                    hintText: 'المقبلة',
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius
                            .circular(
                            20.0)),

                  ),
                ),
              ):Container(),
              dessert?    SizedBox(
                height:
                HeightSize * 0.09,
                child: TextFormField(
                  textDirection:
                  TextDirection.rtl,
                  textAlign: TextAlign.right,
                  controller: _dessertController,
                  validator: (value) {
                    if (value == null ||
                        value.length < 3) {
                      return 'Invalid a';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    //  _authData['email'] = value!;
                  },
                  keyboardType:
                  TextInputType.name,
                  cursorColor:
                  Color(0xff582e44),
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.fromLTRB(
                        0,
                        0,
                        WidthSize*0.05,
                        0),
                    errorStyle: TextStyle(
                      color: Colors.white,
                      fontWeight:
                      FontWeight.w400,
                    ),
                    errorBorder:
                    OutlineInputBorder(
                        borderSide:
                        const BorderSide(
                          color:
                          Colors.white,
                        ),
                        borderRadius:
                        BorderRadius
                            .circular(
                            20.0)),
                    hoverColor: Colors.black,
                    focusColor:
                    Color(0xff582e44),
                    focusedBorder:
                    OutlineInputBorder(
                        borderSide:
                        const BorderSide(
                          color: Color(
                              0xff582e44),
                        ),
                        borderRadius:
                        BorderRadius
                            .circular(
                            20.0)),
                    fillColor: Colors.white,
                    filled: true,
                    //          contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                    hintText: 'التحلية',
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius
                            .circular(
                            20.0)),

                  ),
                ),
              ):Container(),
              autre?   SizedBox(
                height:
                HeightSize * 0.09,
                child: TextFormField(
                  textDirection:
                  TextDirection.rtl,
                  textAlign: TextAlign.right,
                  controller: _autreController,
                  validator: (value) {
                    if (value == null ||
                        value.length < 3) {
                      return 'Invalid a';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    //  _authData['email'] = value!;
                  },
                  keyboardType:
                  TextInputType.name,
                  cursorColor:
                  Color(0xff582e44),
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.fromLTRB(
                        0,
                        0,
                        WidthSize*0.05,
                        0),
                    errorStyle: TextStyle(
                      color: Colors.white,
                      fontWeight:
                      FontWeight.w400,
                    ),
                    errorBorder:
                    OutlineInputBorder(
                        borderSide:
                        const BorderSide(
                          color:
                          Colors.white,
                        ),
                        borderRadius:
                        BorderRadius
                            .circular(
                            20.0)),
                    hoverColor: Colors.black,
                    focusColor:
                    Color(0xff582e44),
                    focusedBorder:
                    OutlineInputBorder(
                        borderSide:
                        const BorderSide(
                          color: Color(
                              0xff582e44),
                        ),
                        borderRadius:
                        BorderRadius
                            .circular(
                            20.0)),
                    fillColor: Colors.white,
                    filled: true,
                    //          contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                    hintText: 'أخرى',
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius
                            .circular(
                            20.0)),

                  ),
                ),
              ):Container(),


            ],),) : Container(
                  height: HeightSize*0.5,
                  child: Center(child: Text('اختر طبقا على الأقل'))),
              (soupe ||plat1 ||plat2||entree||dessert||autre) ?          RaisedButton(
                onPressed: () async {

                },
                textColor: Color(0xff582e44),
                padding:
                const EdgeInsets.all(0.0),
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(
                        20.0)),
                child: Container(
                  width: WidthSize * 0.5,
                  height: HeightSize * 0.08,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.all(
                          Radius.circular(
                              20.0))),
                  child: Center(
                    child: Text(
                      "تأكيد",
                      style: TextStyle(
                        fontSize: WidthSize *
                            (25 / 540),
                        color:
                        Color(0xff582e44),
                        fontWeight:
                        FontWeight.bold,
                      ),
                      textAlign:
                      TextAlign.center,
                    ),
                  ),
                ),
              ):Container(
               ),

            ],),
          ),
        ),
      ),
    );
  }
}

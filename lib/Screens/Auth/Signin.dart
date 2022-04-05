import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/auth.dart';
import 'forgotPassword.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool signin = true;

  bool _passwordVisible = true;

  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _email_upController = TextEditingController();
  final _password_upController = TextEditingController();
  bool _password_upVisible = true;

  final _numberController = TextEditingController();
  final _nomController = TextEditingController();
  final _boutiqueController = TextEditingController();

  bool isCheck = false;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _formKeyUP = GlobalKey<FormState>();

  Future<bool> createNormalUser(String name, String email, String phone) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<AuthService>(context, listen: false).createUser(
        _nomController.text,
        _email_upController.text,
        _numberController.text,
      );
      setState(() {
        _isLoading = false;
      });
      return true;
    } catch (e) {}
    setState(() {
      _isLoading = false;
    });
    return false;
  }

  Future<bool> submit(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<AuthService>(context, listen: false)
          .signUp(email, password);

      setState(() {
        _isLoading = false;
      });

      return true;
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      _isLoading = false;
    });
    return false;
  }

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
        body: SingleChildScrollView(
          child: Container(
            // height: HeightSize,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(color: Colors.white),
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
                            color: Color(0xffbd7344),
                            borderRadius: BorderRadius.only(
                              topRight: signin
                                  ? Radius.circular(60)
                                  : Radius.circular(0),
                              topLeft: signin
                                  ? Radius.circular(0)
                                  : Radius.circular(60),
                              //  bottomLeft: Radius.circular(100),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: HeightSize * 0.11,
                                padding: EdgeInsets.symmetric(
                                    vertical: HeightSize * 0.02,
                                    horizontal: WidthSize * 0.07),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          signin = !signin;
                                        });
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "تسجيل الدخول",
                                            style: TextStyle(
                                              fontSize: WidthSize * (30 / 540),
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 300),
                                            width: WidthSize * 0.2,
                                            height: HeightSize * 0.005,
                                            color: !signin
                                                ? Color(0xffbd7344)
                                                : Color(0xff582e44),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          signin = !signin;
                                        });
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "فتح حساب",
                                            style: TextStyle(
                                              fontSize: WidthSize * (30 / 540),
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 300),
                                            width: WidthSize * 0.2,
                                            height: HeightSize * 0.005,
                                            color: signin
                                                ? Color(0xffbd7344)
                                                : Color(0xff582e44),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: signin
                                    ? Form(
                                        key: _formKey,
                                        child: Container(
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  height: HeightSize * 0.09,
                                                  child: TextFormField(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    textAlign: TextAlign.right,
                                                    controller:
                                                        _emailController,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          !value
                                                              .contains('@') ||
                                                          !value
                                                              .contains('.')) {
                                                        return 'Invalid Email';
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (value) {
                                                      //  _authData['email'] = value!;
                                                    },
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    cursorColor:
                                                        Color(0xff582e44),
                                                    decoration: InputDecoration(
                                                      errorStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                                      hintText:
                                                          'البريد الالكتروني',
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0)),
                                                      suffixIcon: const Icon(
                                                        Icons.email,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: HeightSize * 0.005),
                                                SizedBox(
                                                  height: HeightSize * 0.09,
                                                  child: TextFormField(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    textAlign: TextAlign.right,
                                                    controller:
                                                        _passwordController,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.length < 5) {
                                                        return 'Invalid Password';
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (value) {
                                                      //  _authData['password'] = value!;
                                                    },
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                    obscureText:
                                                        _passwordVisible,
                                                    cursorColor:
                                                        Color(0xff582e44),
                                                    decoration: InputDecoration(
                                                      errorStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
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

                                                      //     contentPadding: const EdgeInsets.fromLTRB(10, 8, 10, 8),

                                                      hintText: 'كلمة السر',
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0)),
                                                      suffixIcon: const Icon(
                                                        Icons.password,
                                                        color: Colors.black,
                                                      ),
                                                      prefixIcon: IconButton(
                                                        icon: Icon(
                                                          // Based on passwordVisible state choose the icon
                                                          _passwordVisible
                                                              ? Icons.visibility
                                                              : Icons
                                                                  .visibility_off,
                                                          color: Colors.black,
                                                        ),
                                                        onPressed: () {
                                                          // Update the state i.e. toogle the state of passwordVisible variable
                                                          setState(() {
                                                            _passwordVisible =
                                                                !_passwordVisible;
                                                          });
                                                        },
                                                      ),

                                                      // icon:
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                          child:
                                                              GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        forgot()),
                                                          );
                                                        },
                                                        child: Text(
                                                          "نسيت كلمة السر",
                                                          style: TextStyle(
                                                            fontSize:
                                                                WidthSize *
                                                                    0.032,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                          ),
                                                        ),
                                                      )),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "البقاء متصلا",
                                                            style: TextStyle(
                                                              fontSize:
                                                                  WidthSize *
                                                                      0.032,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Checkbox(
                                                              checkColor: Color(
                                                                  0xff582e44),
                                                              // color of tick Mark
                                                              activeColor:
                                                                  Colors.white,
                                                              value: isCheck,
                                                              onChanged: (bool?
                                                                  value) {
                                                                setState(() {
                                                                  isCheck =
                                                                      value!;
                                                                });
                                                              }),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: HeightSize * 0.03),
                                                RaisedButton(
                                                  onPressed: () async {
                                                    if (_formKey.currentState!
                                                        .validate()) {}
                                                  },
                                                  textColor: Color(0xff582e44),
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  child: Container(
                                                    width: WidthSize * 0.9,
                                                    height: HeightSize * 0.08,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                    child: Center(
                                                      child: Text(
                                                        "تسحبيل الدخول",
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
                                                ),
                                              ],
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: HeightSize * 0.08,
                                              horizontal: WidthSize * 0.1),
                                        ),
                                      )
                                    : Form(
                                        key: _formKeyUP,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  !Provider.of<AuthService>(
                                                              context,
                                                              listen: false)
                                                          .isVisiteur
                                                      ? HeightSize * 0.01
                                                      : HeightSize * 0.05,
                                              horizontal: WidthSize * 0.1),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                height:
                                                    !Provider.of<AuthService>(
                                                                context,
                                                                listen: false)
                                                            .isVisiteur
                                                        ? HeightSize * 0.07
                                                        : HeightSize * 0.09,
                                                child: TextFormField(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  textAlign: TextAlign.right,
                                                  controller: _nomController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.length < 3) {
                                                      return 'Invalid name';
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
                                                            !Provider.of<AuthService>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .isVisiteur
                                                                ? HeightSize *
                                                                    (15 / 912)
                                                                : 0,
                                                            0,
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
                                                    hintText: 'الاسم',
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    20.0)),
                                                    suffixIcon: const Icon(
                                                      Icons.person,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    !Provider.of<AuthService>(
                                                                context,
                                                                listen: false)
                                                            .isVisiteur
                                                        ? HeightSize * 0.07
                                                        : HeightSize * 0.09,
                                                child: TextFormField(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  textAlign: TextAlign.right,
                                                  controller:
                                                      _email_upController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        !value.contains('@') ||
                                                        !value.contains('.')) {
                                                      return 'Invalid Email';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    //  _authData['email'] = value!;
                                                  },
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  cursorColor:
                                                      Color(0xff582e44),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            0,
                                                            !Provider.of<AuthService>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .isVisiteur
                                                                ? HeightSize *
                                                                    (15 / 912)
                                                                : 0,
                                                            0,
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
                                                    hintText:
                                                        'البريد الالكتروني',
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    20.0)),
                                                    suffixIcon: const Icon(
                                                      Icons.email,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    !Provider.of<AuthService>(
                                                                context,
                                                                listen: false)
                                                            .isVisiteur
                                                        ? HeightSize * 0.07
                                                        : HeightSize * 0.09,
                                                child: TextFormField(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  textAlign: TextAlign.right,
                                                  controller: _numberController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.length != 10) {
                                                      return 'Invalid number';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    //  _authData['email'] = value!;
                                                  },
                                                  keyboardType:
                                                      TextInputType.number,
                                                  cursorColor:
                                                      Color(0xff582e44),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            0,
                                                            !Provider.of<AuthService>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .isVisiteur
                                                                ? HeightSize *
                                                                    (15 / 912)
                                                                : 0,
                                                            0,
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
                                                    hintText: 'رقم الهاتف',
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    20.0)),
                                                    suffixIcon: const Icon(
                                                      Icons.phone,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              !Provider.of<AuthService>(context,
                                                          listen: false)
                                                      .isVisiteur
                                                  ? SizedBox(
                                                      height: !Provider.of<
                                                                      AuthService>(
                                                                  context,
                                                                  listen: false)
                                                              .isVisiteur
                                                          ? HeightSize * 0.07
                                                          : HeightSize * 0.09,
                                                      child: TextFormField(
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        textAlign:
                                                            TextAlign.right,
                                                        controller:
                                                            _boutiqueController,
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.length <
                                                                  2) {
                                                            return 'Invalid boutique';
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
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding: EdgeInsets.fromLTRB(
                                                              0,
                                                              !Provider.of<AuthService>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .isVisiteur
                                                                  ? HeightSize *
                                                                      (15 / 912)
                                                                  : 0,
                                                              0,
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
                                                          fillColor:
                                                              Colors.white,
                                                          filled: true,
                                                          //          contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                                          hintText:
                                                              'اسم المطعم',
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                          suffixIcon:
                                                              const Icon(
                                                            Icons
                                                                .storefront_outlined,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                height:
                                                    !Provider.of<AuthService>(
                                                                context,
                                                                listen: false)
                                                            .isVisiteur
                                                        ? HeightSize * 0.07
                                                        : HeightSize * 0.09,
                                                child: TextFormField(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  textAlign: TextAlign.right,
                                                  controller:
                                                      _password_upController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.length < 5) {
                                                      return 'Invalid Password';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    //  _authData['password'] = value!;
                                                  },
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  obscureText:
                                                      _password_upVisible,
                                                  cursorColor:
                                                      Color(0xff582e44),
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            0,
                                                            !Provider.of<AuthService>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .isVisiteur
                                                                ? HeightSize *
                                                                    (15 / 912)
                                                                : 0,
                                                            0,
                                                            0),
                                                    hoverColor: Colors.black,
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

                                                    //     contentPadding: const EdgeInsets.fromLTRB(10, 8, 10, 8),

                                                    hintText: 'كلمة السر',
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    20.0)),
                                                    suffixIcon: const Icon(
                                                      Icons.password,
                                                      color: Colors.black,
                                                    ),
                                                    prefixIcon: IconButton(
                                                      icon: Icon(
                                                        // Based on passwordVisible state choose the icon
                                                        _password_upVisible
                                                            ? Icons.visibility
                                                            : Icons
                                                                .visibility_off,
                                                        color: Colors.black,
                                                      ),
                                                      onPressed: () {
                                                        // Update the state i.e. toogle the state of passwordVisible variable
                                                        setState(() {
                                                          _password_upVisible =
                                                              !_password_upVisible;
                                                        });
                                                      },
                                                    ),

                                                    // icon:
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                    !Provider.of<AuthService>(
                                                                context,
                                                                listen: false)
                                                            .isVisiteur
                                                        ? HeightSize * 0.015
                                                        : HeightSize * 0.02,
                                              ),
                                              RaisedButton(
                                                onPressed: () async {
                                                  if (_formKeyUP.currentState!
                                                      .validate()) {
                                                    await submit(
                                                        _email_upController
                                                            .text,
                                                        _password_upController
                                                            .text);
                                                  }
                                                },
                                                textColor: Color(0xff582e44),
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                                child: Container(
                                                  width: WidthSize * 0.9,
                                                  height:
                                                      !Provider.of<AuthService>(
                                                                  context,
                                                                  listen: false)
                                                              .isVisiteur
                                                          ? HeightSize * 0.08
                                                          : HeightSize * 0.08,
                                                  decoration: const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
                                                  child: Center(
                                                    child: Text(
                                                      "فتح حساب",
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
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: HeightSize * 0.09,
                    ),
                    height: WidthSize * 0.3,
                    width: WidthSize * 0.3,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(80)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/aber_sabel.png"),
                        )),
                  ),
                ),
                Container(
                  height: WidthSize * 0.12,
                  width: WidthSize * 0.12,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      left: WidthSize * 0.01),
                  child: InkWell(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xff582e44),
                        size: WidthSize * (40.0 / 540),
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

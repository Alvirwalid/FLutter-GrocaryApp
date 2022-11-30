import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grocaryapp/const/const.dart';
import 'package:grocaryapp/const/firebaseconst.dart';
import 'package:grocaryapp/screens/auth/login.dart';
import 'package:grocaryapp/screens/home.dart';
import 'package:grocaryapp/screens/loadingmanager.dart';
import 'package:grocaryapp/service/globalmethod.dart';
import 'package:grocaryapp/service/utils.dart';
import 'package:grocaryapp/widget/authbutton.dart';
import 'package:grocaryapp/widget/back_widget.dart';
import 'package:grocaryapp/widget/googlebutton.dart';
import 'package:grocaryapp/widget/textwidhet.dart';

import '../btm_bar.dart';

class RegisterScreens extends StatefulWidget {
  const RegisterScreens({super.key});

  static const routename = '/RegisterScreens';

  @override
  State<RegisterScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<RegisterScreens> {
  final _fullnametextCController = TextEditingController();
  final _emailCController = TextEditingController();
  final _passwordCController = TextEditingController();
  final _addressTextCController = TextEditingController();
  final _passfocus = FocusNode();
  final _emailfocus = FocusNode();
  final _addressfocus = FocusNode();
  var _obscureText = true;

  final _formkey = GlobalKey<FormState>();

  bool _isLoaded = false;

  void submitFormOnregistration() async {
    final isVallid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isVallid) {
      _formkey.currentState!.save();

      setState(() {
        _isLoaded = true;
      });

      try {
        await authinstance.createUserWithEmailAndPassword(
            email: _emailCController.text.toLowerCase().trim(),
            password: _passwordCController.text.trim());

        final User? user = authinstance.currentUser;
        final _uid = user!.uid;

        //print(_uid);

        await FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'id': _uid,
          'name': _fullnametextCController.text,
          'email': _emailCController.text.toLowerCase(),
          'shipping-address': _addressTextCController.text,
          'userwish': [],
          'userCart': [],
          'createdAt': Timestamp.now()
        });

        Get.offAllNamed(BottomScreen.routename);

        print('Registration Succesfully');
        setState(() {
          _isLoaded = false;
        });
      } on FirebaseAuthException catch (error) {
        print('An error ccured $error');
        GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
        setState(() {
          _isLoaded = false;
        });
      } catch (error) {
        print('An error ccured $error');
        GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
        setState(() {
          _isLoaded = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fullnametextCController.dispose();
    _emailCController.dispose();
    _passwordCController.dispose();
    _addressTextCController.dispose();
    _emailfocus.dispose();
    _passfocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screensize;
    return Scaffold(
      body: Loadingmanager(
        isLoading: _isLoaded,
        child: Stack(
          children: [
            Swiper(
              duration: 800, autoplayDelay: 6000,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Constss.imglist[index]['imagepath'],
                  fit: BoxFit.cover,
                );
              },
              autoplay: true,
              itemCount: Constss.imglist.length,
              // pagination: const SwiperPagination(
              //     alignment: Alignment.bottomCenter,
              //     builder: DotSwiperPaginationBuilder(
              //         color: Colors.white, activeColor: Colors.red)),
              // control: const SwiperControl(),
            ),
            Container(
              color: Colors.black.withOpacity(0.7),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: size.height * 0.2,
                    ),
                    Textwidget(
                        text: 'Welcome Back',
                        color: Colors.white,
                        textsize: 24),
                    const SizedBox(
                      height: 8,
                    ),
                    Textwidget(
                        text: 'Sign in to continue',
                        color: Colors.white,
                        textsize: 16),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _fullnametextCController,
                              textInputAction: TextInputAction.next,
                              //onEditingComplete: () => submitFormOnregistration(),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Full Name';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Full Name',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _emailCController,
                              textInputAction: TextInputAction.next,
                              // onEditingComplete: () => submitFormOnregistration(),
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'Enter a valid email address';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            ///pass
                            TextFormField(
                              controller: _passwordCController,
                              textInputAction: TextInputAction.next,
                              // onEditingComplete: () => submitFormOnregistration(),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 7) {
                                  return 'enter more than 7';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                suffix: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: _obscureText
                                        ? const Icon(
                                            Icons.visibility,
                                            color: Colors.white,
                                          )
                                        : const Icon(Icons.visibility_off,
                                            color: Colors.white)),
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                              ),
                              obscureText: _obscureText,
                            ),
                            TextFormField(
                              controller: _addressTextCController,
                              textInputAction: TextInputAction.done,
                              // onEditingComplete: () => submitFormOnregistration(),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 10) {
                                  return 'Enter a valid  address';
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Shipping address',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Forget password',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.lightBlue,
                                        fontSize: 15,
                                        decoration: TextDecoration.underline),
                                  )),
                            )
                          ],
                        )),
                    SizedBox(
                      width: double.infinity,
                      child: AuthButton(
                        btntext: 'Sign Up',
                        fct: () {
                          submitFormOnregistration();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Already a user?',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            children: [
                          TextSpan(
                              text: '   Sign in',
                              style: const TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()
                                ..onTap = (() {
                                  Get.toNamed(LoginScreens.routename);
                                }))
                        ])),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

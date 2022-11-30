import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:grocaryapp/const/const.dart';
import 'package:grocaryapp/const/firebaseconst.dart';
import 'package:grocaryapp/screens/auth/forgetpass.dart';
import 'package:grocaryapp/screens/auth/register.dart';
import 'package:grocaryapp/screens/btm_bar.dart';
import 'package:grocaryapp/screens/loadingmanager.dart';
import 'package:grocaryapp/service/globalmethod.dart';
import 'package:grocaryapp/service/utils.dart';
import 'package:grocaryapp/widget/authbutton.dart';
import 'package:grocaryapp/widget/googlebutton.dart';
import 'package:grocaryapp/widget/textwidhet.dart';

class LoginScreens extends StatefulWidget {
  const LoginScreens({super.key});
  static const routename = '/LoginScreens';

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
  final _emailCController = TextEditingController();
  final _passwordCController = TextEditingController();
  final _passfocus = FocusNode();
  var _obscureText = true;

  final _formkey = GlobalKey<FormState>();

  bool _isloaded = false;

  void submitFormOnLogin() async {
    final isVallid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isVallid) {
      _formkey.currentState!.save();

      setState(() {
        _isloaded = true;
      });

      try {
        authinstance.signInWithEmailAndPassword(
            email: _emailCController.text.toLowerCase().trim(),
            password: _passwordCController.text);
        Get.offAllNamed(BottomScreen.routename);
        setState(() {
          _isloaded = false;
        });

        print('Login Succesfully');
      } on FirebaseAuthException catch (error) {
        print('An error occured $error');
        GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
        setState(() {
          _isloaded = false;
        });
      } catch (error) {
        print('An error occured $error');
        GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
        setState(() {
          _isloaded = false;
        });
      }

      print('The form is valid');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailCController.dispose();
    _passwordCController.dispose();
    _passfocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screensize;
    return Scaffold(
      body: Loadingmanager(
        isLoading: _isloaded,
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
                              controller: _emailCController,
                              textInputAction: TextInputAction.next,
                              // onEditingComplete: () =>
                              //     FocusScope.of(context).requestFocus(_passfocus),
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
                              textInputAction: TextInputAction.done,
                              // onEditingComplete: () => submitFormOnLogin(),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 6) {
                                  return 'Enter a valid  password';
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
                                hintStyle: const TextStyle(color: Colors.white),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                              ),
                              obscureText: _obscureText,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: TextButton(
                                  onPressed: () {
                                    Get.toNamed(ForgetPassScreens.routename);
                                  },
                                  child: const Text(
                                    'Forget password',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 15,
                                        color: Colors.lightBlue,
                                        decoration: TextDecoration.underline),
                                  )),
                            )
                          ],
                        )),
                    SizedBox(
                      width: double.infinity,
                      child: AuthButton(
                        btntext: 'Login',
                        fct: () {
                          submitFormOnLogin();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const GoogleButton(),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(
                          color: Colors.white,
                          thickness: 2,
                        )),
                        Textwidget(
                            text: 'OR', color: Colors.white, textsize: 18),
                        const Expanded(
                            child: Divider(
                          color: Colors.white,
                          thickness: 2,
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: AuthButton(
                        btntext: 'Continue as a guest',
                        primary: Colors.black,
                        fct: () {
                          Get.toNamed(BottomScreen.routename);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            children: [
                          TextSpan(
                              text: '   Sign up',
                              style: const TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()
                                ..onTap = (() {
                                  Get.toNamed(RegisterScreens.routename);
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

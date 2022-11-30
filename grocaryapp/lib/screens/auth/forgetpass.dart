import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grocaryapp/const/const.dart';
import 'package:grocaryapp/const/firebaseconst.dart';
import 'package:grocaryapp/screens/auth/register.dart';
import 'package:grocaryapp/screens/loadingmanager.dart';
import 'package:grocaryapp/service/globalmethod.dart';
import 'package:grocaryapp/service/utils.dart';
import 'package:grocaryapp/widget/authbutton.dart';
import 'package:grocaryapp/widget/back_widget.dart';
import 'package:grocaryapp/widget/googlebutton.dart';
import 'package:grocaryapp/widget/textwidhet.dart';

class ForgetPassScreens extends StatefulWidget {
  const ForgetPassScreens({super.key});
  static const routename = '/ForgetPassScreens';

  @override
  State<ForgetPassScreens> createState() => _ForgetPassScreensState();
}

class _ForgetPassScreensState extends State<ForgetPassScreens> {
  final _emailCController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  bool _isLoaded = false;

  // verifiedemail() async {
  //   final user = FirebaseAuth.instance.currentUser;

  //   try {
  //     if (user!.emailVerified) {
  //     } else {
  //       user.sendEmailVerification();
  //     }
  //   } on FirebaseException catch (error) {
  //     print('object');
  //     print(error);
  //   } catch (error) {
  //     print('object');
  //     print(error);
  //   }
  // }

  forgetpassFCT() async {
    final isVallid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_emailCController.text.isEmail) {
      setState(() {
        _isLoaded = true;
      });
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailCController.text.toString());

        Fluttertoast.showToast(
            msg: "An email has been sent to your email",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade600,
            textColor: Colors.white,
            fontSize: 16.0);

        print('Successful reset password');
        // print(authinstance.currentUser!.uid);
        setState(() {
          _isLoaded = false;
        });

        Get.back();
      } on FirebaseException catch (error) {
        setState(() {
          _isLoaded = false;
        });
        GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
      } catch (error) {
        setState(() {
          _isLoaded = false;
        });
        GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
      }

      return print('ok');
    } else {
      setState(() {
        _isLoaded = false;
      });
      return showDialog(
        // barrierColor: Colors.white38,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white38,
          title: Row(
            children: [
              const Icon(
                IconlyBold.danger,
                color: Colors.red,
              ),
              const SizedBox(
                width: 8,
              ),
              Textwidget(
                  text: 'Error occured', color: Colors.white, textsize: 18),
            ],
          ),
          content: Textwidget(
              text: 'please enter a valid email address',
              color: Colors.white,
              textsize: 14),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(color: Colors.lightBlue),
                ))
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailCController.dispose();
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
            SizedBox(
              height: size.height * 0.1,
            ),
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
                      height: size.height * 0.06,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.canPop(context)
                              ? Navigator.pop(context)
                              : null;
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    Textwidget(
                        text: 'Forget password',
                        color: Colors.white,
                        textsize: 24),
                    const SizedBox(
                      height: 8,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextField(
                              controller: _emailCController,

                              // onEditingComplete: () =>
                              //     FocusScope.of(context).requestFocus(_passfocus),

                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Email address',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )),
                    SizedBox(
                      width: double.infinity,
                      child: AuthButton(
                        btntext: 'Reset now',
                        fct: () {
                          forgetpassFCT();
                          // verifiedemail();
                        },
                      ),
                    ),
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

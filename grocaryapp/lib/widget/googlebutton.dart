import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocaryapp/const/firebaseconst.dart';
import 'package:grocaryapp/screens/btm_bar.dart';
import 'package:grocaryapp/service/globalmethod.dart';
import 'package:grocaryapp/widget/textwidhet.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({super.key});

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  Future<void> googleSignIn(context) async {
    final googleSignIn = GoogleSignIn();

    final googleAccount = await googleSignIn.signIn();

    // setState(() {
    //   _isloaded = true;
    // });

    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;

      print('Access token isss${googleAuth.accessToken}');
      print('Access token isss${googleAuth.idToken}');

      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          await authinstance.signInWithCredential(GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken));
          // setState(() {
          //   _isloaded = false;
          // });
          print('Login Successfully');

          Get.offAllNamed(BottomScreen.routename);
        } on FirebaseAuthException catch (error) {
          print('An error occures $error');
          GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
          // setState(() {
          //   _isloaded = false;
          // });

          GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
          print('An error occures $error');
        } catch (error) {
          GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
          // setState(() {
          //   _isloaded = false;
          // });
          print('An error occures $error');
        } finally {
          // setState(() {
          //   _isloaded = false;
          // });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () {
          googleSignIn(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                color: Colors.white,
                width: 40,
                child: Image.asset('asset/image/google.png')),
            const SizedBox(
              width: 20,
            ),
            Textwidget(
                text: 'Sign in with Google', color: Colors.white, textsize: 18)
          ],
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:grocaryapp/screens/auth/forgetpass.dart';
import 'package:grocaryapp/screens/auth/login.dart';
import 'package:grocaryapp/screens/loadingmanager.dart';
import 'package:grocaryapp/screens/order/orderscreen.dart';
import 'package:grocaryapp/screens/viewrecently/viewrecently.dart';
import 'package:grocaryapp/screens/wishlist/wishlist_screen.dart';
import 'package:grocaryapp/service/globalmethod.dart';
import 'package:grocaryapp/widget/textwidhet.dart';
import 'package:provider/provider.dart';

import '../const/firebaseconst.dart';
import '../provider/darkthemeprovider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController addressTextController = TextEditingController();
  String? _email;
  String? _name;
  String? _address;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    addressTextController.dispose();
    super.dispose();
  }

  final User? user = authinstance.currentUser;

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final _uid = user!.uid;
      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();

      if (userDoc == null) {
        setState(() {
          _isLoading = false;
        });

        return;
      } else {
        _email = userDoc.get('email');

        _name = userDoc.get('name');
        _address = userDoc.get('shipping-address');
        addressTextController.text = userDoc.get('shipping-address');

        setState(() {
          _isLoading = false;
        });
      }
    } on FirebaseFirestore catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethod.errorDialog(ctx: context, subtitle: '$error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color colors = themeState.getDarkTheme ? Colors.white : Colors.black;
    final User? user = authinstance.currentUser;
    return Scaffold(
      body: Loadingmanager(
        isLoading: _isLoading,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        text: 'Hi,  ',
                        style: const TextStyle(
                            color: Colors.cyan,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                        children: <TextSpan>[
                          TextSpan(
                              text: _name == null ? 'User' : _name!,
                              style: TextStyle(
                                  color: colors,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('My name is');
                                }),
                        ]),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Textwidget(
                    text: _email == null ? 'Email' : _email!,
                    color: colors,
                    textsize: 22,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(height: 8),
                  _listtile(
                      title: 'Address',
                      subtitle: _address == null ? 'address 2' : _address!,
                      icon: IconlyLight.profile,
                      color: colors,
                      onpressed: () async {
                        await _showAlertDialog();
                      }),
                  _listtile(
                      title: 'Orders',
                      icon: IconlyLight.bag,
                      color: colors,
                      onpressed: () {
                        Get.toNamed(OrderScreen.routename);
                      }),
                  _listtile(
                      title: 'Wishlist',
                      icon: IconlyLight.heart,
                      color: colors,
                      onpressed: () {
                        if (user == null) {
                          GlobalMethod.errorDialog(
                              ctx: context,
                              subtitle: 'No user found,Please login first');

                          return;
                        }

                        Get.toNamed(WishlistScreen.routename);
                      }),
                  _listtile(
                      title: 'Viewed',
                      icon: IconlyLight.show,
                      color: colors,
                      onpressed: () {
                        if (user == null) {
                          GlobalMethod.errorDialog(
                              ctx: context,
                              subtitle: 'No user found,Please login first');

                          return;
                        }
                        Get.toNamed(ViewRecentlyScreen.routename);
                      }),
                  _listtile(
                      title: 'Forget password',
                      icon: IconlyLight.logout,
                      color: colors,
                      onpressed: () {
                        Get.toNamed(ForgetPassScreens.routename);
                      }),
                  SwitchListTile(
                    title: Textwidget(
                        text: themeState.getDarkTheme
                            ? 'Dark Mode'
                            : 'Light Mode',
                        color: colors,
                        textsize: 22),
                    secondary: Icon(themeState.getDarkTheme
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined),
                    onChanged: (value) {
                      setState(() {
                        themeState.setDarKTheme = value;
                      });
                    },
                    value: themeState.getDarkTheme,
                  ),
                  _listtile(
                      title: user == null ? 'Login' : 'Logout',
                      icon:
                          user == null ? IconlyLight.login : IconlyLight.logout,
                      color: colors,
                      onpressed: () {
                        if (user == null) {
                          Get.toNamed(LoginScreens.routename);
                          return;
                        }
                        GlobalMethod.warningDialog(
                            ctx: context,
                            title: 'Signout',
                            subtitle: 'Do you wanna signout',
                            onpressed: () async {
                              await authinstance.signOut();

                              Get.offAndToNamed(LoginScreens.routename);
                            });
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAlertDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update'),
            content: TextField(
              // maxLines: 5,
              // onChanged: (value) {
              //   // addressTextController.text;
              //   print('addressTextController ${addressTextController.text}');
              // },
              controller: addressTextController,
              decoration: const InputDecoration(hintText: 'Your address'),
            ),
            actions: [
              TextButton(
                  onPressed: (() async {
                    final _uid = user!.uid;

                    try {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(_uid)
                          .update({
                        'shipping-address': addressTextController.text,
                        'name': 'Alvi'
                      });

                      setState(() {
                        _address = addressTextController.text;
                      });

                      Get.back();
                    } catch (err) {
                      GlobalMethod.errorDialog(ctx: context, subtitle: '$err');
                    }
                  }),
                  child: const Text(
                    'Update',
                    style: TextStyle(fontSize: 18),
                  ))
            ],
          );
        });
  }

  Widget _listtile(
      {required String title,
      String? subtitle,
      required IconData icon,
      required Color color,
      required Function onpressed}) {
    return ListTile(
      title: Textwidget(
        text: title,
        color: color,
        textsize: 20,
      ),
      subtitle: Textwidget(
          text: subtitle == null ? '' : subtitle, color: color, textsize: 18),
      leading: Icon(icon),
      trailing: Icon(IconlyLight.arrowRight2),
      onTap: () {
        onpressed();
      },
    );
  }
}

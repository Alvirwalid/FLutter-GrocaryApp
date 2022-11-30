import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocaryapp/const/firebaseconst.dart';
import 'package:grocaryapp/providers/wishlistprovider.dart';
import 'package:grocaryapp/service/globalmethod.dart';
import 'package:provider/provider.dart';

class HeartWidget extends StatelessWidget {
  HeartWidget({super.key, required this.productid, required this.isWishlist});
  final String productid;
  bool isWishlist;

  @override
  Widget build(BuildContext context) {
    final wishlistrovider = Provider.of<WishlistProvider>(context);
    return GestureDetector(
        onTap: (() {
          final User? user = authinstance.currentUser;

          if (user == null) {
            GlobalMethod.errorDialog(
                ctx: context, subtitle: 'No user found,Please login first');

            return;
          }

          wishlistrovider.addremoveTowishlist(productid);
        }),
        child: Icon(
          isWishlist ? IconlyBold.heart : IconlyLight.heart,
          color: isWishlist ? Colors.red : null,
        ));
  }
}

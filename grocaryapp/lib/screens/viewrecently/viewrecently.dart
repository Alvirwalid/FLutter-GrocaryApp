import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocaryapp/providers/viewprovider.dart';
import 'package:grocaryapp/screens/viewrecently/viewwidget.dart';
import 'package:grocaryapp/service/globalmethod.dart';
import 'package:grocaryapp/service/utils.dart';
import 'package:grocaryapp/widget/back_widget.dart';
import 'package:grocaryapp/widget/emptycart.dart';
import 'package:grocaryapp/widget/textwidhet.dart';
import 'package:provider/provider.dart';

import '../../const/firebaseconst.dart';

class ViewRecentlyScreen extends StatelessWidget {
  const ViewRecentlyScreen({super.key});
  static const routename = '/ViewRecentlyScreen';

  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).colors;

    final viewProvider = Provider.of<Viewprovider>(context);
    final viewtitems =
        viewProvider.getviewitems.values.toList().reversed.toList();

    if (viewtitems.isEmpty) {
      return const EmptyScreen(
          imgpath: 'asset/image/history.png',
          title: 'your history is empty',
          subtitle: 'No products has been viewed yet',
          btntext: 'Shop now');
    } else {
      return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
            actions: [
              IconButton(
                  onPressed: () {
                    GlobalMethod.warningDialog(
                        ctx: context,
                        title: 'Empty your history',
                        subtitle: 'Are you sure',
                        onpressed: () {
                          viewProvider.cleanhistory();
                        });
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: color,
                  )),
            ],
            title: Textwidget(text: 'History', color: color, textsize: 22),
            centerTitle: true,
            leading: const BackWidget()),
        body: ListView.builder(
          itemCount: viewtitems.length,
          itemBuilder: (context, index) {
            return ChangeNotifierProvider.value(
                value: viewtitems[index], child: const viewrecentlywidget());
          },
        ),
      );
    }
  }
}

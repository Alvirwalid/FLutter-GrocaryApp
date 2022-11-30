import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grocaryapp/const/themedartmode.dart';
import 'package:grocaryapp/inner_screen/feedsscreen.dart';
import 'package:grocaryapp/provider/darkthemeprovider.dart';
import 'package:grocaryapp/providers/cartprovider.dart';
import 'package:grocaryapp/providers/productprovider.dart';
import 'package:grocaryapp/providers/viewprovider.dart';
import 'package:grocaryapp/providers/wishlistprovider.dart';
import 'package:grocaryapp/screens/auth/forgetpass.dart';
import 'package:grocaryapp/screens/auth/login.dart';
import 'package:grocaryapp/screens/auth/register.dart';
import 'package:grocaryapp/screens/home.dart';
import 'package:grocaryapp/screens/order/orderscreen.dart';
import 'package:grocaryapp/screens/viewrecently/viewrecently.dart';
import 'package:grocaryapp/screens/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';
import 'inner_screen/categoryscreen.dart';
import 'inner_screen/onsale_screens.dart';
import 'inner_screen/producr_detail.dart';
import 'screens/btm_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDq_5VQuv5JNYlg9tyElN701JvO6wlKwYk',
          appId: '1:738793888029:android:3cfbace1c1328b4bb7e9f4',
          messagingSenderId: '738793888029',
          projectId: 'grocary-flutterapp',
          authDomain: 'grocary-flutterapp.firebaseapp.com'));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  void getCurrentTheme() async {
    DarkThemeProvider themeChangeProvider = DarkThemeProvider();

    themeChangeProvider.setDarKTheme =
        await themeChangeProvider.darkthemePrefs.getTheme();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentTheme();
    super.initState();
  }

  final Future<FirebaseApp> firebaseinitializer = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebaseinitializer,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('An error occured'),
                ),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => Cartprovider(),
              ),
              ChangeNotifierProvider(create: (context) {
                return DarkThemeProvider();
              }),
              ChangeNotifierProvider(create: (context) {
                return ProductProviders();
              }),
              ChangeNotifierProvider(
                create: (context) => Cartprovider(),
              ),
              ChangeNotifierProvider(
                create: (context) => WishlistProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => Viewprovider(),
              )
            ],
            child: Consumer<DarkThemeProvider>(
                builder: (context, themeProvider, child) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: styles.themeData(
                    isdark: themeProvider.getDarkTheme, context: context),
                home: const BottomScreen(),
                //initialRoute: '/',
                getPages: [
                  GetPage(
                      name: BottomScreen.routename,
                      page: (() => const BottomScreen())),
                  GetPage(
                      name: OnsaleScreen.routename,
                      page: (() => const OnsaleScreen())),
                  GetPage(
                      name: FeedsScreen.routename,
                      page: () => const FeedsScreen()),
                  GetPage(
                      name: ProductDetails.routename,
                      page: () => const ProductDetails()),
                  GetPage(
                      name: WishlistScreen.routename,
                      page: (() => const WishlistScreen())),
                  GetPage(
                      name: OrderScreen.routename,
                      page: () => const OrderScreen()),
                  GetPage(
                      name: ViewRecentlyScreen.routename,
                      page: () => const ViewRecentlyScreen()),
                  GetPage(
                    name: RegisterScreens.routename,
                    page: () => const RegisterScreens(),
                  ),
                  GetPage(
                    name: LoginScreens.routename,
                    page: () {
                      return const LoginScreens();
                    },
                  ),
                  GetPage(
                    name: ForgetPassScreens.routename,
                    page: () => const ForgetPassScreens(),
                  ),
                  GetPage(
                    name: CategoryScreen.routename,
                    page: () {
                      return CategoryScreen();
                    },
                  ),
                  GetPage(
                    name: Homepage.routename,
                    page: () {
                      return const Homepage();
                    },
                  )
                ],
              );
            }),
          );
        });
  }
}

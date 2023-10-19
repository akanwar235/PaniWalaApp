import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_order/models/verify_otp_model.dart';
import 'package:water_order/screens/auth/login_page.dart';
import 'package:water_order/screens/bottomnav/bottomnav.dart';
import 'package:water_order/screens/maps/map.dart';
import 'package:water_order/services/constants/local_db_keys.dart';
import 'package:water_order/utils/colors.dart';
import 'package:water_order/utils/global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const FlutterSecureStorage storage = FlutterSecureStorage();
  final String? userDataStr = await storage.read(key: LocalDbKeys.userData);
  final String? currlati = await storage.read(key: LocalDbKeys.lati);
  final String? currlogi = await storage.read(key: LocalDbKeys.longi);
  if (currlati != null) {
    VarGlobal.currlati = double.parse(currlati);
    VarGlobal.currlongi = double.parse(currlogi!);
  }
  if (userDataStr != null && userDataStr.isNotEmpty) {
    VarGlobal.isUserSignedIn = true;
    VarGlobal.userData = verifyOtpModelFromJson(userDataStr);
  }
  await dotenv.load();
  await Firebase.initializeApp();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      color: Colors.white,
      child: SizedBox(
        child: Center(
            child: Text(
          "Something went wrong !!!",
          style: TextStyle(
              fontFamily: GoogleFonts.dmSans().fontFamily,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 20),
        )),
      ),
    );
  };

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Water Order',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: AnimatedSplashScreen(
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.rightToLeft,
        splash: Text(
          "PaniWala App",
          style: TextStyle(
            fontSize: 40,
            fontFamily: GoogleFonts.inter().fontFamily,
          ),
        ),
        duration: 2500,
        nextScreen: const RedirectPage(),
      ),
    );
  }
}

class RedirectPage extends StatefulWidget {
  const RedirectPage({super.key});

  @override
  State<RedirectPage> createState() => _RedirectPageState();
}

class _RedirectPageState extends State<RedirectPage> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
    firstTimeConnectionCheck();
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          isAlertSet = true;
        }
      },
    );

    super.initState();
  }

  firstTimeConnectionCheck() async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if (!isDeviceConnected && isAlertSet == false) {
      showDialogBox();
      isAlertSet = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: VarGlobal.isUserSignedIn == true
            ? VarGlobal.currlati != null
                ? const BottomNav()
                : const Maps()
            : const LoginPage());
  }

  showDialogBox() {
    var _style = TextStyle(
        color: Colors.white, fontFamily: GoogleFonts.dmSans().fontFamily);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black54,
            title: Text(
              'No Connection',
              style: _style,
            ),
            content: Text(
              'Please check your internet connectivity !!!',
              style: _style,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.pop(context, 'Cancel');
                  isAlertSet = false;
                  isDeviceConnected =
                      await InternetConnectionChecker().hasConnection;
                  if (!isDeviceConnected && isAlertSet == false) {
                    showDialogBox();
                    isAlertSet = true;
                  }
                },
                child: Text(
                  'Retry',
                  style: _style,
                ),
              ),
            ],
          );
        });
  }
}

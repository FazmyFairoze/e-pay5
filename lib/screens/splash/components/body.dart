import 'package:e_pay/main.dart';
import 'package:e_pay/screens/home/home_screen.dart';
import 'package:e_pay/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_pay/constants.dart';
import 'package:e_pay/screens/sign_in/sign_in_screen.dart';
import 'package:e_pay/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  //static final LocalAuthentication auth = LocalAuthentication();
  //_SupportState _supportState = _SupportState.unknown;

  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _canCheckBiometric = false;
  String _authorizedOrNot = "Not Auhtorised";
  List<BiometricType> _availableBiometricTypes = List<BiometricType>();

  Future<void> _checkBiometric() async {
    print("Checking if biometrics is available");
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
    _getListOfBiometricTypes();
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometric;
    try {
      listOfBiometric = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometricTypes = listOfBiometric;
    });
    print(listOfBiometric);
    _authorizeNow();
  }

  Future<void> _authorizeNow() async {
    print("trying biometric authentication");
    bool isAuthorized = false;
    try {
      isAuthorized = await _localAuthentication.authenticate(
        localizedReason:
            "Auhtenticate with Biometrics or click back to authenticate with pin",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      if (isAuthorized) {
        _authorizedOrNot = "Auhtorized";
        Navigator.pushNamed(context, HomeScreen.routeName);
      } else {
        _authorizedOrNot = "Not Authorized";
        Navigator.pushNamed(context, SignInScreen.routeName);
      }
    });
  }

  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to E-Pay, Let’s shop!",
      "image": "assets/images/splash_1.png"
    },
    {"text": "Simply Scan to Pay", "image": "assets/images/splash_2.png"},
    {
      "text": "We show the easy way to shop. \nJust stay at safe with us",
      "image": "assets/images/splash_3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    TextButton(
                      child: const Text("Continue"),
                      onPressed: () {
                        FirebaseAuth.instance
                            .authStateChanges()
                            .listen((User user) {
                          if (user == null) {
                            print('User is currently signed out!');
                            Navigator.pushNamed(
                                context, SignInScreen.routeName);
                            //state = false;
                          } else {
                            print('User is signed in!');
                            //state = true;
                            //REPLACE WITH BIOMETRIC AUTHENTICATION
                            _checkBiometric();
                            //print("Biometrics is Available");

                            if (_canCheckBiometric) {
                              print("Biometrics Available");
                              //code stops here!!!!
                              //_authorizeNow();
                              print("Authorizing");
                              if (_authorizedOrNot == "Auhtorized") {
                                print("Authorizd");
                                Navigator.pushNamed(
                                    context, HomeScreen.routeName);
                              } else {
                                print("Not Authorized");
                                Navigator.pushNamed(
                                    context, SignInScreen.routeName);
                              }
                            }
                          }
                        });
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

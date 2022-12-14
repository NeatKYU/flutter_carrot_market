import 'package:carrot_market_by_flutter/constants/shared_pref_keys.dart';
import 'package:carrot_market_by_flutter/provider/user_provider.dart';
import 'package:carrot_market_by_flutter/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:carrot_market_by_flutter/constants/common_size.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum VerifyStatus { none, codeSending, codeSent, verifying, done }

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // 이런 underBar변수들은 build밖에서 선언해주는게 좋은듯..
  VerifyStatus _verifyStatus = VerifyStatus.none;
  String? _verificationId;
  int? _forceResendingToken;

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController _phoneNumberController =
      TextEditingController(text: '010');
  TextEditingController _codeController = TextEditingController();

  double getContainerHeight(VerifyStatus status, String type) {
    switch (status) {
      case VerifyStatus.none:
        return 0;
      case VerifyStatus.codeSending:
      case VerifyStatus.codeSent:
      case VerifyStatus.verifying:
      case VerifyStatus.done:
        if (type == 'button') {
          return 50;
        } else {
          return 60 + common_padding_sm;
        }
    }
  }

  void changeVerify(BuildContext context) async {
    setState(() {
      _verifyStatus = VerifyStatus.verifying;
    });

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _verifyStatus = VerifyStatus.done;
    });

    try {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: _codeController.text);

      // Sign the user in (or link) with the credential
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      logger.e('verification failed!! check sms code!');
      SnackBar snackBar = new SnackBar(content: Text('코드가 맞지 않아요!'));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    // context.go('/');
  }

  _getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String address = prefs.getString(SHARED_ADDRESS) ?? "";
    double lat = prefs.getDouble(SHARED_LAT) ?? 0;
    double lon = prefs.getDouble(SHARED_LON) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;

        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              '전화번호 로그인',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
          ),
          body: IgnorePointer(
            ignoring: _verifyStatus == VerifyStatus.verifying,
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(common_padding),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // image,
                        ExtendedImage.asset(
                          'assets/images/padlock.png',
                          width: size.width * 0.16,
                          height: size.width * 0.16,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        // text
                        Text(
                            '고기 마켓은 휴대폰 번호로 가입해요\n 번호는 안전하게 보관되며\n 어디에도 공개되지 않아요.')
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        MaskedInputFormatter('000 0000 0000'),
                      ],
                      validator: (phoneNumber) {
                        if (phoneNumber != null && phoneNumber.length == 13) {
                          return null;
                        } else {
                          // error
                          return '전화번호 똑바로 입력해주세요.';
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_verifyStatus == VerifyStatus.codeSending) return;
                          // 이거 이렇게 연결 안하면 input에서 validator가 안먹네???? 왤까????
                          if (_formkey.currentState != null) {
                            bool passed = _formkey.currentState!.validate();
                            String _phoneNumber = _phoneNumberController.text
                                .replaceAll(' ', '')
                                .replaceFirst('0', '');

                            if (passed) {
                              FirebaseAuth auth = FirebaseAuth.instance;

                              setState(() {
                                VerifyStatus.codeSending;
                              });

                              // web으로 접속하려면 이 코드를 사용하면 되는데 이게 버그가 있는듯하다.
                              // ConfirmationResult confirmationResult = await auth
                              //     .signInWithPhoneNumber('+821055555555');

                              await auth.verifyPhoneNumber(
                                phoneNumber: '+82${_phoneNumber}',
                                forceResendingToken: _forceResendingToken,
                                verificationCompleted:
                                    (PhoneAuthCredential credential) async {
                                  // ANDROID ONLY!

                                  // Sign the user in (or link) with the auto-generated credential
                                  await auth.signInWithCredential(credential);
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationId) {},
                                codeSent: (String verificationId,
                                    int? forceResendingToken) async {
                                  setState(() {
                                    _verifyStatus = VerifyStatus.codeSent;
                                    _verificationId = verificationId;
                                    _forceResendingToken = forceResendingToken;
                                  });
                                },
                                verificationFailed:
                                    (FirebaseAuthException error) {
                                  logger.e(error.message);

                                  setState(() {
                                    VerifyStatus.none;
                                  });
                                },
                              );
                              // setState(() {
                              //   _verifyStatus = VerifyStatus.codeSent;
                              // });
                              logger.d(_verifyStatus);
                            }
                          }
                        },
                        child: _verifyStatus == VerifyStatus.codeSending
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text('인증문자 받기'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                        )),
                    const SizedBox(
                      height: 16.0,
                    ),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: _verifyStatus == VerifyStatus.none ? 0 : 1,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        height: getContainerHeight(_verifyStatus, 'input'),
                        child: TextFormField(
                          controller: _codeController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            MaskedInputFormatter('000000'),
                          ],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 8.0,
                    // ),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: _verifyStatus == VerifyStatus.none ? 0 : 1,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        height: getContainerHeight(_verifyStatus, 'button'),
                        child: ElevatedButton(
                            onPressed: () {
                              changeVerify(context);
                              // _confirmationResult.confirm('659484');
                            },
                            child: (_verifyStatus == VerifyStatus.verifying)
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text('인증번호 확인'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(50),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

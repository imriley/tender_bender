import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tender_bender/screens/HomeScreen.dart';
import 'package:tender_bender/utils/fire_auth.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoginPage = false;
  bool showPassword = false;
  bool termsAccepted = false;
  bool keepMeLoggedIn = false;
  bool isProcessing = false;
  bool isFormInvalid = true;
  bool isInvalidName = false;
  bool isInvalidEmail = false;
  bool isInvalidPassword = false;
  bool isChecked = true;
  bool isFirebaseError = false;
  String fireBaseErrorMsg = "";
  final FocusNode _focusName = FocusNode();
  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPassword = FocusNode();
  late SharedPreferences loginData;
  late bool newUser;

  void switchPage() {
    setState(() {
      isLoginPage = !isLoginPage;
      isFirebaseError = false;
      isInvalidName = false;
      isInvalidEmail = false;
      isInvalidPassword = false;
      passwordController.clear();
    });
  }

  void validate(bool registerUser) {
    if (registerUser) {
      isInvalidName =
          !RegExp(r"^([A-z]){2,40}\w+").hasMatch(nameController.text);
      isChecked = termsAccepted;
    } else {
      isInvalidName = false;
      isChecked = true;
    }
    isInvalidEmail = !RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(emailController.text);
    isInvalidPassword = !RegExp(
            r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,19}$")
        .hasMatch(passwordController.text);
    if (!isInvalidName && !isInvalidEmail && !isInvalidPassword && isChecked) {
      isFormInvalid = false;
    } else {
      isFormInvalid = true;
    }
  }

  void check_if_already_login() async {
    loginData = await SharedPreferences.getInstance();
    newUser = (loginData.getBool('login') ?? true);
    if (newUser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(247, 246, 251, 1),
        body: Center(
          child: isLoginPage ? getSignInScreen() : getSignUpScreen(),
        ),
      ),
    );
  }

  Widget getSignInScreen() {
    return isProcessing
        ? const CircularProgressIndicator(
            color: Color(0xffFF7853),
          )
        : Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Address',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: isInvalidEmail
                              ? const Color(0xFFF43F5E)
                              : const Color(0xFF6B7280)),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(31, 41, 55, 0.08),
                            blurRadius: 2,
                            offset: Offset(0, 1))
                      ]),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          focusNode: _focusEmail,
                          controller: emailController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  borderSide: BorderSide(
                                      color: isInvalidEmail
                                          ? const Color(0xFFF43F5E)
                                          : const Color.fromARGB(
                                              255, 229, 231, 235))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  borderSide: BorderSide(
                                      color: isInvalidEmail
                                          ? const Color(0xFFF43F5E)
                                          : const Color.fromARGB(
                                              255, 229, 231, 235)))),
                        ),
                      ),
                    ),
                    if (isInvalidEmail) ...[
                      const Text(
                        "Please enter a valid email",
                        style: TextStyle(color: Color(0xFFF43F5E)),
                      )
                    ],
                    const SizedBox(
                      height: 16,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: isInvalidPassword
                              ? const Color(0xFFF43F5E)
                              : const Color(0xFF6B7280)),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(31, 41, 55, 0.08),
                            blurRadius: 2,
                            offset: Offset(0, 1))
                      ]),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          focusNode: _focusPassword,
                          controller: passwordController,
                          obscureText: !showPassword,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            filled: true,
                            hintText: "8+ characters",
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 209, 213, 219)),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(
                                    color: isInvalidPassword
                                        ? const Color(0xFFF43F5E)
                                        : const Color.fromARGB(
                                            255, 229, 231, 235))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                borderSide: BorderSide(
                                    color: isInvalidPassword
                                        ? const Color(0xFFF43F5E)
                                        : const Color.fromARGB(
                                            255, 229, 231, 235))),
                            suffixIcon: IconButton(
                              color: const Color.fromARGB(255, 156, 163, 175),
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              icon: Icon(showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (isInvalidPassword) ...[
                      const Text(
                        "Your password must have atleast 8 and maximum of 20 characters, at least one uppercase letter, one lowercase letter, one number and one special character",
                        style: TextStyle(color: Color(0xFFF43F5E)),
                      )
                    ],
                  ],
                ),
                if (isFirebaseError) ...[
                  Container(
                    decoration: const BoxDecoration(color: Color(0xFFFFE4E6)),
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    height: 40,
                    margin: const EdgeInsets.only(top: 16),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.warning,
                            color: Color(0xFFE11D48),
                            size: 20,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            fireBaseErrorMsg,
                            style: const TextStyle(color: Color(0xFF374151)),
                          ),
                        ]),
                  )
                ],
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 16,
                            width: 16,
                            child: Checkbox(
                                activeColor: const Color(0xffFF7853),
                                value: keepMeLoggedIn,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    side: const BorderSide(
                                        color: Color(0xFFD1D5DB))),
                                onChanged: (newValue) {
                                  setState(() {
                                    keepMeLoggedIn = !keepMeLoggedIn;
                                  });
                                }),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            "Keep me logged in",
                            style: TextStyle(
                                color: Color(0xff374151), fontSize: 15),
                          )
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero, minimumSize: Size.zero),
                        child: const Text(
                          "Forgot Password?",
                          style:
                              TextStyle(fontSize: 15, color: Color(0xFF5048E5)),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  width: double.infinity,
                  height: 36,
                  child: ElevatedButton(
                    onPressed: () async {
                      _focusName.unfocus();
                      _focusEmail.unfocus();
                      _focusPassword.unfocus();
                      setState(() {
                        isProcessing = true;
                      });
                      validate(false);
                      if (!isFormInvalid) {
                        var data = await FireAuth.signInUsingEmailPassword(
                            email: emailController.text,
                            password: passwordController.text);
                        if (data.runtimeType == String) {
                          setState(() {
                            fireBaseErrorMsg = data;
                            isFirebaseError = true;
                          });
                        } else {
                          loginData.setBool('login', !keepMeLoggedIn);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        }
                      }
                      setState(() {
                        isProcessing = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFF7853),
                    ),
                    child: const Text("Log In",
                        style:
                            TextStyle(color: Color(0xffE7E4E7), fontSize: 14)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  width: double.infinity,
                  height: 36,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isProcessing = true;
                      });
                      dynamic data = await FireAuth.signInWithGoogle();
                      if (data.runtimeType == String || data == null) {
                        setState(() {
                          fireBaseErrorMsg = data;
                          isFirebaseError = true;
                        });
                      } else {
                        loginData.setBool('login', false);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                      }
                      setState(() {
                        isProcessing = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        shadowColor: const Color.fromRGBO(31, 41, 55, 0.08),
                        elevation: 2,
                        padding: const EdgeInsets.only(top: 8, bottom: 8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Logo(
                          Logos.google,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text("Log in with Google",
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff374151))),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Row(children: [
                    const Text(
                      "Not a member?",
                      style: TextStyle(color: Color(0xff374151), fontSize: 15),
                    ),
                    const SizedBox(width: 3),
                    TextButton(
                      onPressed: () {
                        switchPage();
                      },
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero, minimumSize: Size.zero),
                      child: const Text(
                        "Sign up",
                        style:
                            TextStyle(fontSize: 15, color: Color(0xFF5048E5)),
                      ),
                    )
                  ]),
                )
              ],
            ),
          );
  }

  Widget getSignUpScreen() {
    return isProcessing
        ? const CircularProgressIndicator(
            color: Color(0xffFF7853),
          )
        : Container(
            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isProcessing = true;
                    });
                    dynamic data = await FireAuth.signInWithGoogle();
                    if (data.runtimeType == String || data == null) {
                      setState(() {
                        fireBaseErrorMsg = data;
                        isFirebaseError = true;
                      });
                    } else {
                      loginData.setBool('login', false);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    }
                    setState(() {
                      isProcessing = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      shadowColor: const Color.fromRGBO(31, 41, 55, 0.08),
                      elevation: 2,
                      padding: const EdgeInsets.only(top: 8, bottom: 8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Logo(
                        Logos.google,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text("Sign up with Google",
                          style: TextStyle(
                              fontSize: 14, color: Color(0xff374151))),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 24, bottom: 24),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          color: Color(0xff9CA3AF),
                          endIndent: 16,
                        ),
                      ),
                      Text(
                        "or use your email",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff9CA3AF),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Color(0xff9CA3AF),
                          indent: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full Name',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: isInvalidName
                            ? const Color(0xFFF43F5E)
                            : const Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(31, 41, 55, 0.08),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        )
                      ]),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          focusNode: _focusName,
                          controller: nameController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  borderSide: BorderSide(
                                      color: isInvalidName
                                          ? const Color(0xFFF43F5E)
                                          : const Color.fromARGB(
                                              255, 229, 231, 235))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  borderSide: BorderSide(
                                      color: isInvalidName
                                          ? const Color(0xFFF43F5E)
                                          : const Color.fromARGB(
                                              255, 229, 231, 235)))),
                        ),
                      ),
                    ),
                    if (isInvalidName) ...[
                      const Text(
                        "Please enter your name",
                        style: TextStyle(color: Color(0xFFF43F5E)),
                      )
                    ],
                    const SizedBox(
                      height: 16,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Address',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: isInvalidEmail
                              ? const Color(0xFFF43F5E)
                              : const Color(0xFF6B7280)),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(31, 41, 55, 0.08),
                            blurRadius: 2,
                            offset: Offset(0, 1))
                      ]),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          focusNode: _focusEmail,
                          controller: emailController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  borderSide: BorderSide(
                                      color: isInvalidEmail
                                          ? const Color(0xFFF43F5E)
                                          : const Color.fromARGB(
                                              255, 229, 231, 235))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  borderSide: BorderSide(
                                      color: isInvalidEmail
                                          ? const Color(0xFFF43F5E)
                                          : const Color.fromARGB(
                                              255, 229, 231, 235)))),
                        ),
                      ),
                    ),
                    if (isInvalidEmail) ...[
                      const Text(
                        "Please enter a valid email",
                        style: TextStyle(color: Color(0xFFF43F5E)),
                      )
                    ],
                    const SizedBox(
                      height: 16,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: isInvalidPassword
                              ? const Color(0xFFF43F5E)
                              : const Color(0xFF6B7280)),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(31, 41, 55, 0.08),
                            blurRadius: 2,
                            offset: Offset(0, 1))
                      ]),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          focusNode: _focusPassword,
                          controller: passwordController,
                          obscureText: !showPassword,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              filled: true,
                              hintText: "8+ characters",
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 209, 213, 219)),
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  borderSide: BorderSide(
                                      color: isInvalidPassword
                                          ? const Color(0xFFF43F5E)
                                          : const Color.fromARGB(
                                              255, 229, 231, 235))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  borderSide: BorderSide(
                                      color: isInvalidPassword
                                          ? const Color(0xFFF43F5E)
                                          : const Color.fromARGB(
                                              255, 229, 231, 235))),
                              suffixIcon: IconButton(
                                  color:
                                      const Color.fromARGB(255, 156, 163, 175),
                                  onPressed: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  icon: Icon(showPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility))),
                        ),
                      ),
                    ),
                    if (isInvalidPassword) ...[
                      const Text(
                        "Your password must have atleast 8 and maximum of 20 characters, at least one uppercase letter, one lowercase letter, one number and one special character",
                        style: TextStyle(color: Color(0xFFF43F5E)),
                      )
                    ],
                  ],
                ),
                if (isFirebaseError) ...[
                  Container(
                    decoration: const BoxDecoration(color: Color(0xFFFFE4E6)),
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    height: 40,
                    margin: const EdgeInsets.only(top: 16),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.warning,
                            color: Color(0xFFE11D48),
                            size: 20,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            "An account with that email exists!",
                            style: TextStyle(color: Color(0xFF374151)),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          TextButton(
                            onPressed: () {
                              switchPage();
                            },
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero),
                            child: const Text(
                              "Sign In?",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF374151),
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ]),
                  )
                ],
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  width: double.infinity,
                  height: 36,
                  child: ElevatedButton(
                    onPressed: () async {
                      _focusName.unfocus();
                      _focusEmail.unfocus();
                      _focusPassword.unfocus();
                      setState(() {
                        isProcessing = true;
                      });
                      validate(true);
                      if (!isFormInvalid) {
                        User? user = await FireAuth.registerUsingEmailPassword(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text);
                        if (user == null) {
                          setState(() {
                            isFirebaseError = true;
                          });
                        } else {
                          loginData.setBool('login', false);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                          setState(() {
                            isFirebaseError = false;
                          });
                        }
                      }
                      setState(() {
                        isProcessing = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFF7853),
                    ),
                    child: const Text("Create an account",
                        style:
                            TextStyle(color: Color(0xffE7E4E7), fontSize: 14)),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 24),
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16,
                              width: 16,
                              child: Checkbox(
                                  activeColor: const Color(0xffFF7853),
                                  value: termsAccepted,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      side: const BorderSide(
                                          color: Color(0xffffcccb))),
                                  onChanged: (newValue) {
                                    setState(() {
                                      termsAccepted = newValue ?? false;
                                    });
                                  }),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Expanded(
                              child: Text(
                                "I agree to the Terms of Service and Privacy Policy",
                                style: TextStyle(
                                    color: Color(0xff374151), fontSize: 15),
                              ),
                            )
                          ],
                        ),
                        if (!isChecked) ...[
                          const Text(
                            "Please check this box before proceeding",
                            style: TextStyle(color: Color(0xFFF43F5E)),
                          )
                        ],
                      ],
                    )),
                Row(children: [
                  const Text(
                    "Already a member?",
                    style: TextStyle(color: Color(0xff374151), fontSize: 15),
                  ),
                  const SizedBox(width: 3),
                  TextButton(
                    onPressed: () {
                      switchPage();
                    },
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero, minimumSize: Size.zero),
                    child: const Text(
                      "Sign in",
                      style: TextStyle(fontSize: 15, color: Color(0xFF5048E5)),
                    ),
                  )
                ])
              ],
            ),
          );
  }
}

import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;
  bool termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 246, 251, 1),
      body: Center(
        child: getSignInScreen(),
      ),
    );
  }

  Widget getSignInScreen() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Email Address',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280)),
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
                      controller: emailController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 229, 231, 235))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 229, 231, 235)))),
                    )),
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Password',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280)),
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
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        filled: true,
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 209, 213, 219)),
                        fillColor: Colors.white,
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 229, 231, 235))),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 229, 231, 235))),
                        suffixIcon: IconButton(
                            color: const Color.fromARGB(255, 156, 163, 175),
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
              )
            ],
          ),
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
                          value: termsAccepted,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(color: Color(0xFFD1D5DB))),
                          onChanged: (newValue) {
                            setState(() {
                              termsAccepted = newValue ?? false;
                            });
                          }),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      "Keep me logged in",
                      style: TextStyle(color: Color(0xff374151), fontSize: 15),
                    )
                  ],
                ),
                Container(
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero, minimumSize: Size.zero),
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(fontSize: 15, color: Color(0xFF5048E5)),
                    ),
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
              onPressed: () {
                print("done");
              },
              // onPressed: termsAccepted
              //     ? () {
              //         print("done");
              //       }
              //     : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFF7853),
              ),
              child: const Text("Log In",
                  style: TextStyle(color: Color(0xffE7E4E7), fontSize: 14)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            width: double.infinity,
            height: 36,
            child: ElevatedButton(
              onPressed: () {
                print("Hello");
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
                  const Text("Log in with Google",
                      style: TextStyle(fontSize: 14, color: Color(0xff374151))),
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
                onPressed: () {},
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, minimumSize: Size.zero),
                child: const Text(
                  "Sign up",
                  style: TextStyle(fontSize: 15, color: Color(0xFF5048E5)),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  Widget getSignUpScreen() {
    return Container(
      margin: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          ElevatedButton(
            onPressed: () {
              print("Hello");
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
                    style: TextStyle(fontSize: 14, color: Color(0xff374151))),
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
                  style: TextStyle(fontSize: 16, color: Color(0xff9CA3AF)),
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
              const Text(
                'Full Name',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280)),
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
                    controller: nameController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 229, 231, 235))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 229, 231, 235)))),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Email Address',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280)),
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
                      controller: emailController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 229, 231, 235))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 229, 231, 235)))),
                    )),
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Password',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280)),
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
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        filled: true,
                        hintText: "8+ characters",
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 209, 213, 219)),
                        fillColor: Colors.white,
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 229, 231, 235))),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 229, 231, 235))),
                        suffixIcon: IconButton(
                            color: const Color.fromARGB(255, 156, 163, 175),
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
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 24),
            width: double.infinity,
            height: 36,
            child: ElevatedButton(
              onPressed: termsAccepted
                  ? () {
                      print("done");
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFF7853),
              ),
              child: Text("Create an account",
                  style: TextStyle(
                      color: termsAccepted
                          ? const Color(0xffE7E4E7)
                          : const Color(0xFF6B7280),
                      fontSize: 14)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 24),
            padding: EdgeInsets.zero,
            child: Row(
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
                          side: const BorderSide(color: Color(0xFFD1D5DB))),
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
                  style: TextStyle(color: Color(0xff374151), fontSize: 15),
                ))
              ],
            ),
          ),
          Row(children: [
            const Text(
              "Already a member?",
              style: TextStyle(color: Color(0xff374151), fontSize: 15),
            ),
            const SizedBox(width: 3),
            TextButton(
              onPressed: () {},
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

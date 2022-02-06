import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 110.0),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Hello',
                          style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: const [
                          Text(
                            'There',
                            style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '.',
                            style: TextStyle(
                              fontSize: 80.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
                padding: const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 5.0),
                    Container(
                      alignment: const Alignment(1.0, 0.0),
                      padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                      child: const InkWell(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    SizedBox(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: const Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      height: 40.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Center(
                              child: Icon(FontAwesomeIcons.facebook),
                            ),
                            SizedBox(width: 10.0),
                            Center(
                              child: Text(
                                'Log in with facebook',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'New to Spotify ?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                const SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.green,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}

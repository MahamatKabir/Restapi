import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:restapi/model/post.dart';
import 'package:restapi/screens/auth/registerscreen.dart';
import 'package:restapi/services/fetchapp.dart';
import 'package:restapi/services/global_methods.dart';
import 'package:restapi/view/home_page.dart';
import 'package:restapi/view/restaurant.dart';
import 'package:restapi/widgets/auth_button.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _obscureText = false;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  void _submitFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      LoginData loginData = LoginData(
        email: _emailTextController.text.trim(),
        password: _passTextController.text.trim(),
      );

      try {
        bool loginSuccess = await loginUser(loginData);

        if (loginSuccess) {
          List<Restaurant> restaurantData = await fetchRestaurantData();

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) =>
                  RestaurantListPage(restaurantData: restaurantData),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('La connexion a échoué. Veuillez réessayer.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } catch (error) {
        print('Erreur lors de la connexion : $error');
        // Gérer les erreurs ici si nécessaire
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xffFC4401),
              Color.fromARGB(255, 247, 204, 188),
            ]),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 60.0, left: 22),
            child: Text(
              'Hello\nSign in!',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Colors.white,
            ),
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(_passFocusNode),
                        controller: _emailTextController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email address';
                          } else {
                            return null;
                          }
                        },
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          hintStyle:
                              TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffFC4401),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffFC4401),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () {
                          _submitFormOnLogin();
                        },
                        controller: _passTextController,
                        focusNode: _passFocusNode,
                        obscureText: _obscureText,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 7) {
                            return 'Please enter a valid password';
                          } else {
                            return null;
                          }
                        },
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color.fromARGB(255, 0, 0, 0),
                              )),
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0)),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffFC4401),
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffFC4401),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            GlobalMethods.navigateTo(
                                ctx: context, routeName: Homepage.routeName);
                          },
                          child: const Text(
                            'Forget password?',
                            maxLines: 1,
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 68, 0),
                                fontSize: 18,
                                decoration: TextDecoration.underline,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(colors: [
                            Color(0xffFC4401),
                            Color.fromARGB(255, 247, 204, 188),
                          ]),
                        ),
                        child: AuthButton(
                          fct: _submitFormOnLogin,
                          buttonText: 'Login',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                          text: TextSpan(
                              text: 'Don\'t have an account?',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 18),
                              children: [
                            TextSpan(
                                text: '  Sign up',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 68, 0),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    GlobalMethods.navigateTo(
                                        ctx: context,
                                        routeName: RegScreen.routeName);
                                  }),
                          ]))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:restapi/inner_screens/categories.dart';
import 'package:restapi/screens/auth/forget_pass.dart';
import 'package:restapi/screens/auth/loginscreen.dart';
import 'package:restapi/services/global_methods.dart';
import 'package:restapi/view/home_page.dart';
import 'package:restapi/widgets/auth_button.dart';

class RegScreen extends StatefulWidget {
  static const routeName = '/RegScreen';
  const RegScreen({Key? key}) : super(key: key);

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _addressTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  bool _obscureText = true;
  @override
  void dispose() {
    _fullNameController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _addressTextController.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  void _submitFormOnRegister() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      //thanks for watching
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xffB81736),
              Color(0xff281537),
            ]),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 60.0, left: 22),
            child: Text(
              'Create Your\nAccount',
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const TextField(
                    //   decoration: InputDecoration(
                    //       suffixIcon: Icon(Icons.check,color: Colors.grey,),
                    //       label: Text('Full Name',style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         color:Color(0xffB81736),
                    //       ),)
                    //   ),
                    // ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_emailFocusNode),
                      keyboardType: TextInputType.name,
                      controller: _fullNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This Field is missing";
                        } else {
                          return null;
                        }
                      },
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      decoration: const InputDecoration(
                        hintText: 'Full name',
                        hintStyle:
                            TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 185, 34, 34)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 189, 34, 34)),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      focusNode: _emailFocusNode,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(_passFocusNode),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTextController,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains("@")) {
                          return "Please enter a valid Email adress";
                        } else {
                          return null;
                        }
                      },
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        hintStyle:
                            TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 176, 15, 15)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 185, 44, 44)),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //Password
                    TextFormField(
                      focusNode: _passFocusNode,
                      obscureText: _obscureText,
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passTextController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return "Please enter a valid password";
                        } else {
                          return null;
                        }
                      },
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_addressFocusNode),
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
                          ),
                        ),
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 202, 31, 31)),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 155, 23, 23)),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          GlobalMethods.navigateTo(
                              ctx: context,
                              routeName: CategoriesScreen.routeName);
                        },
                        child: const Text(
                          'Forget password?',
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    AuthButton(
                      buttonText: 'Sign up',
                      fct: () {
                        _submitFormOnRegister();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'Already a user?',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Sign in',
                                style: const TextStyle(
                                    color: Colors.lightBlue, fontSize: 18),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacementNamed(
                                        context, LoginScreen.routeName);
                                  }),
                          ]),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

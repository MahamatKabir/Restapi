import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restapi/inner_screens/categories.dart';
import 'package:restapi/provider/dark_theme_provider.dart';
import 'package:restapi/screens/auth/loginscreen.dart';
import 'package:restapi/screens/auth/registerscreen.dart';
import 'package:restapi/view/home_page.dart';
import 'package:restapi/welcomeScreen.dart';
import 'consts/theme_data.dart';
import 'screens/auth/forget_pass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        })
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: const WelcomeScreen(),
            routes: {
              //Homepage.routeName: (ctx) => const Homepage(),
              CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
              RegScreen.routeName: (ctx) => const RegScreen(),
              LoginScreen.routeName: (ctx) => const LoginScreen(),
              ForgetPasswordScreen.routeName: (ctx) =>
                  const ForgetPasswordScreen(),
            });
      }),
    );
  }
}

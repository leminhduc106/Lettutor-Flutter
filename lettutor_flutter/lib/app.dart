import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:lettutor_flutter/provider/navigation_index.dart';
import 'package:lettutor_flutter/provider/setting.dart';
import 'package:lettutor_flutter/provider/user_provider.dart';
import 'package:lettutor_flutter/views/authenticate/login_page.dart';
import 'package:provider/provider.dart';
import 'package:lettutor_flutter/routes/routes.dart' as routes;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NavigationIndex(),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingProvider(),
        )
      ],
      child: MaterialApp(
        useInheritedMediaQuery: true,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: routes.controller,
        // showPerformanceOverlay: true,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue, primaryColor: const Color(0xff007CFF)),
        home: const AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: LoginPage(),
        ),
      ),
    );
  }
}

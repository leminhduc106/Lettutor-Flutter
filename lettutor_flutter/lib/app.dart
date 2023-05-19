import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor_flutter/cubit/chat/chat_cubit.dart';
import 'package:lettutor_flutter/global_state/app_provider.dart';
import 'package:lettutor_flutter/global_state/auth_provider.dart';
import 'package:lettutor_flutter/global_state/navigation_index.dart';
import 'package:lettutor_flutter/views/authenticate/login_page.dart';
import 'package:provider/provider.dart';
import 'package:lettutor_flutter/routes/routes.dart' as routes;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => NavigationIndex(),
          ),
          ChangeNotifierProvider(
            create: (_) => AuthProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => AppProvider(),
          ),
        ],
        child: MaterialApp(
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: routes.controller,
          // showPerformanceOverlay: true,
          title: 'Lettutor',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: const Color(0xff007CFF)),
          home: const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            child: LoginPage(),
          ),
        ),
      ),
    );
  }
}

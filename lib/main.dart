import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopit/common/widgets/bottom_bar.dart';
import 'package:shopit/constants/global_variables.dart';
import 'package:shopit/features/admin/screens/admin.screen.dart';
import 'package:shopit/features/auth/screens/auth.screen.dart';
import 'package:shopit/features/auth/services/auth.service.dart';
import 'package:shopit/providers/user.provider.dart';
import 'package:shopit/router.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const Shopit()));
}

class Shopit extends StatefulWidget {
  const Shopit({Key? key}) : super(key: key);

  @override
  State<Shopit> createState() => _ShopitState();
}

class _ShopitState extends State<Shopit> {
  // This widget is the root of your application.

  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopit',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == "user"
              ? const BottomBar()
              : const AdminScreen()
          : const AuthScreen(),
    );
  }
}

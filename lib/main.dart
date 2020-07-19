import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/provider/user_provider.dart';
import 'package:shopping_app_flutter/resource/colors.dart';
import 'package:shopping_app_flutter/views/content_page/content_page.dart';
import 'package:shopping_app_flutter/views/login_page/login_page.dart';
import 'package:shopping_app_flutter/views/widget/loading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
//    ChangeNotifierProvider.value(value: ProductsProvider()),/
  ] ,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: mainColor,
        ),
        home: ScreensController(),
      )));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    switch(user.status){
      case Status.Uninitialized:
        return LoadingWidget();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginPage();
      case Status.Authenticated:
        return ContentPage(user: user,);
      default: return LoginPage();
    }
  }
}




import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'Bloc/User/user_cubit.dart';
import 'Getx Injection/getx_dependenci_injection.dart' as di;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'Config/text_style.dart';
import 'Constants/Colors/app_colors.dart';
import 'Dependenci Injection/injection.dart';
import 'Route/app_route.dart';
import 'custom_assets/assets.gen.dart';


/// Assets.images.somriddhiSvg.svg(height: 10),

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ///dp path
  var databasePath = await getApplicationDocumentsDirectory();
  ///Hydrate bloc Init
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory(),
  );
  HttpOverrides.global =await  MyHttpOverrides();
  Hive.init(databasePath.path);


  // Hive.registerAdapter(CourseDbAdapter());
  ///dependenci injection
  await injection();

  ///Getx dependenci injection
  Map<String, Map<String, String>> _languages = await di.init();
  ///status bar style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  statusBarColor: Colors.transparent, // transparent status bar
  systemNavigationBarColor: Colors.black, // navigation bar color
  statusBarIconBrightness: Brightness.dark, // status bar icons' color
  systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icons' color
  ));

  runApp(
  MyApp(router: AppRouter())
  );
}

class MyApp extends StatelessWidget {
  final AppRouter router;
  const MyApp({super.key, required this.router});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<UserCubit>(
            create: (context) => UserCubit(),
          ),
        ],
        child:ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            useInheritedMediaQuery: true,
            splitScreenMode: true,
            builder: (context, child) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Trending',
                theme: ThemeData(
                  primaryColor: kPrimaryColorx,
                  colorScheme: ColorScheme.light(primary: const Color(0xFF00934C)),
                  fontFamily: "Inter",
                  appBarTheme: AppBarTheme(
                      elevation: 0,
                      backgroundColor: whiteBackground,
                      centerTitle: true,
                      iconTheme: IconThemeData(
                          color: textColor,
                          size: 32
                      ),
                      titleTextStyle: semiBoldText(18,color: textColor)
                  ),

                ),
                onGenerateRoute: router.generateRoute,

              );
            })
    );
  }
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context) {

    return super.createHttpClient(context) ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
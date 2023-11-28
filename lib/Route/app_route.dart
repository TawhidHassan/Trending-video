import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/User/user_cubit.dart';
import '../Constants/Strings/app_strings.dart';

import '../Presentation/Pages/SplashScreen/spalash_screen.dart';
import '../Presentation/Pages/Trending/main_screen.dart';
import '../Presentation/Pages/Trending/video_details_page.dart';
import '../Presentation/Pages/channel_page.dart';
import '../Presentation/Pages/comment_page.dart';


class AppRouter {

  Route? generateRoute(RouteSettings settings) {
    // final ScreenArguments? arguments = settings.arguments as ScreenArguments;
    final Map? args = settings.arguments as Map?;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => SpalashScreen());
      case MAIN_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>MainScreen()
        );
      case VIDEO_DETAILS_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>VideoDetailsPage(video: args!["video"],)
        );
      case CHANNEL_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>ChannelPage()
        );
      case COMMENT_PAGE:
        return MaterialPageRoute(
            builder: (BuildContext context) =>CommentPage()
        );



    // case HOME_PAGE:
    //   return MaterialPageRoute(builder: (_) => Home());


      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider(
              create: (context) => UserCubit(),
              child: SpalashScreen(),
            ));
    }
  }
}

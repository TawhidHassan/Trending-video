
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Constants/Strings/app_strings.dart';


import '../Dependenci Injection/injection.dart';
import '../GetX Controller/TrendingController/TrendingController.dart';
import '../Network/api_client.dart';
import '../Repository/TrendingRepository/trending_repository.dart';
import '../Service/LocalDataBase/localdata.dart';



Future<Map<String, Map<String, String>>> init() async {

  // var apiclient=getIt<ApiClient>();
  // var localDb=getIt<LocalDataGet>();
  // print("calll get x");
  // final sharedPreferences = await SharedPreferences.getInstance();
  // Get.lazyPut(() => sharedPreferences);
  // Get.lazyPut(() => ApiClient(appBaseUrl: BASE_URL));


  Get.lazyPut(()=>LocalDataGet());
  Get.lazyPut(() => ApiClient(appBaseUrl: BASE_URL));

  // Repository
  Get.lazyPut(() => TrendingRepository(apiClient: getIt<ApiClient>()));


  // Controller
  Get.lazyPut(() => TrendingController(trendingRepository:Get.find<TrendingRepository>() ));
  // Get.lazyPut(() => ChatController());
  // Get.lazyPut(() => ChefController(chefRepository:  Get.find<ChefRepository>()));
  // Get.lazyPut(() => MenuControllerx(chefRepository:  Get.find<ChefRepository>()));


  // Retrieving localized data
  Map<String, Map<String, String>> _languages = Map();

  return _languages;
}
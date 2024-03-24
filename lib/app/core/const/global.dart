
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'storage_services.dart';




class Global {
  static late StorageServices storageServices;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    //app updates
    // Initialize the In-App Update check

    storageServices = await StorageServices().init();
  }
}

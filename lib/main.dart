import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_catalog/app/routes/app_router.dart';
import 'package:smart_catalog/core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_catalog/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_catalog/features/auth/data/auth_repository_impl.dart';
import 'package:smart_catalog/features/auth/domain/auth_repository.dart';
import 'package:smart_catalog/features/catalog/data/repositories/catalog_repository_impl.dart';
import 'package:smart_catalog/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:smart_catalog/features/cart/domain/repositories/cart_repository.dart';
import 'package:smart_catalog/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:smart_catalog/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:smart_catalog/features/splash/domain/repositories/splash_repository.dart';
import 'package:hive/hive.dart';
import 'package:smart_catalog/core/constants/hive_constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_catalog/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:smart_catalog/features/settings/domain/repositories/settings_repository.dart';
import 'package:smart_catalog/features/profile/domain/repositories/user_profile_repository.dart';
import 'package:smart_catalog/features/profile/data/repositories/user_profile_repository_impl.dart';
import 'package:smart_catalog/features/profile/data/source/firebase_storage_datasource.dart';
import 'package:smart_catalog/core/data/repositories/user_repository_impl.dart';
import 'package:smart_catalog/core/domain/repositories/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  await initHive();
  setup();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('es')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: SmartCatalogApp(),
    ),
  );
}

class SmartCatalogApp extends StatelessWidget {
  const SmartCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Smart Catalog',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
    );
  }
}

final getIt = GetIt.instance;

Future<void> initHive() async {
  final directory = await getApplicationDocumentsDirectory();
  final storageDatasource = FirebaseStorageDatasource(
    storage: FirebaseStorage.instance,
  );
  Hive.init(directory.path);
  await Hive.openBox<Map>(HiveBoxes.cart);
  await Hive.openBox<bool>(HiveBoxes.appSettings);
  await Hive.openBox<Map>(HiveBoxes.orders);
  await Hive.openBox<Map>(HiveBoxes.user);

  getIt.registerSingleton<UserProfileRepository>(
    UserProfileRepositoryImpl(
      firebaseStorageDatasource: storageDatasource,
      firestore: FirebaseFirestore.instance,
    ),
  );
}

void setup() {
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      cartBox: Hive.box<Map>(HiveBoxes.cart),
      ordersBox: Hive.box<Map>(HiveBoxes.orders),
      auth: FirebaseAuth.instance,
      db: FirebaseFirestore.instance,
    ),
  );
  getIt.registerSingleton<CatalogRepository>(
    CatalogRepositoryImpl(
      db: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
      cartBox: Hive.box<Map>(HiveBoxes.cart),
    ),
  );
  getIt.registerSingleton<CartRepository>(
    CartRepositoryImpl(
      cartBox: Hive.box<Map>(HiveBoxes.cart),
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
      ordersBox: Hive.box<Map>(HiveBoxes.orders),
    ),
  );
  getIt.registerSingleton<SplashRepository>(
    SplashRepositoryImpl(
      cartBox: Hive.box<Map>(HiveBoxes.cart),
      appSettingsBox: Hive.box<bool>(HiveBoxes.appSettings),
      db: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
      ordersBox: Hive.box<Map>(HiveBoxes.orders),
    ),
  );
  getIt.registerSingleton<UserRepository>(
    UserRepositoryImpl(
      firestore: FirebaseFirestore.instance,
      userBox: Hive.box<Map>(HiveBoxes.user),
    ),
  );
  getIt.registerSingleton<SettingsRepository>(
    SettingsRepositoryImpl(
      auth: FirebaseAuth.instance,
      cartBox: Hive.box<Map>(HiveBoxes.cart),
      ordersBox: Hive.box<Map>(HiveBoxes.orders),
      userBox: Hive.box<Map>(HiveBoxes.user),
    ),
  );
}

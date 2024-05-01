import 'package:firebasebasitprovider/repo/database_repository.dart';
import 'package:firebasebasitprovider/servis/firestoreServis/firestore_servis.dart';
import 'package:firebasebasitprovider/servis/sqfliteServis/sqfLiteServis.dart';
import 'package:get_it/get_it.dart';

GetIt locator=GetIt.instance;

setUpLocator(){
  locator.registerLazySingleton(() => DatabaseRepository());
  locator.registerLazySingleton(() => FirestoreServis());
  locator.registerLazySingleton(() => SqfLiteServis());
}
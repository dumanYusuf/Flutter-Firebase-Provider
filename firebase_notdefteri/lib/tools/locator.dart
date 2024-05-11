
import 'package:firebase_notdefteri/repo/databaseRepo.dart';
import 'package:firebase_notdefteri/servis/firestoreServis.dart';
import 'package:get_it/get_it.dart';

GetIt locator=GetIt.instance;

setUpLocator(){
  locator.registerLazySingleton(() => DatabaseRepository());
  locator.registerLazySingleton(() => FirestoreServis());
}
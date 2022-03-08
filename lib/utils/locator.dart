
import 'package:gmail_alarm/View_Model/gmail_label_view_model.dart';
import 'package:gmail_alarm/View_Model/home_view_model.dart';
import 'package:gmail_alarm/View_Model/settings_view_model.dart';
import 'package:gmail_alarm/View_Model/sign_in_view_model.dart';
import 'package:gmail_alarm/model/google_auth_client.dart';
import 'package:get_it/get_it.dart';


GetIt locator = GetIt.instance;

void setLocator(){
  locator.registerLazySingleton(() => SignInViewModel());
  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerLazySingleton(() => SettingsViewModel());
  locator.registerLazySingleton(() => GoogleAuthClient());
  locator.registerLazySingleton(() => GmailLabelViewModel());
}
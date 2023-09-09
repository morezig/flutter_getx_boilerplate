import 'package:get/get.dart';

class Config {
  static var appName = 'Flutter BoilerPlate';

  static String termsAndCondition = "https://www.technource.com/terms-conditions/";
  static String privacyPolicyUrl = "https://technource.com/privacy-policy/";
  static String aboutUsUrl = "https://www.technource.com/services/";

  static RxString setLocale = 'en'.obs;

  static String langCodeEn = 'en';
  static String langCodeRu = 'ru';
  static String langCodeFr = 'fr';

  static String langCountryCodeEn = 'US';
  static String langCountryCodeRu = 'RU';
  static String langCountryCodeFr = 'CA';
  static String githubRepoLink = 'https://github.com/TechnourceOfficial/Flutter-Getx-Boilerplate';

  static String cmsPrivacyPolicy = "privacy-policy";
  static String cmsTermsCondition = "terms-conditions";
  static String cmsAboutUsUrl = "about-us";

  //Arguments
  static const String argSlug = "argCms";

  static const String apiBaseUrl = "http://192.168.1.121:2999/cct";
}

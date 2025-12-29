import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In ar, this message translates to:
  /// **'URL مشغل'**
  String get appTitle;

  /// No description provided for @pasteLink.
  ///
  /// In ar, this message translates to:
  /// **'لصق الرابط'**
  String get pasteLink;

  /// No description provided for @play.
  ///
  /// In ar, this message translates to:
  /// **'تشغيل'**
  String get play;

  /// No description provided for @videos.
  ///
  /// In ar, this message translates to:
  /// **'الفيديوهات'**
  String get videos;

  /// No description provided for @history.
  ///
  /// In ar, this message translates to:
  /// **'السجل'**
  String get history;

  /// No description provided for @settings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settings;

  /// No description provided for @theme.
  ///
  /// In ar, this message translates to:
  /// **'المظهر'**
  String get theme;

  /// No description provided for @darkMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الليلي'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع النهاري'**
  String get lightMode;

  /// No description provided for @about.
  ///
  /// In ar, this message translates to:
  /// **'حول التطبيق'**
  String get about;

  /// No description provided for @version.
  ///
  /// In ar, this message translates to:
  /// **'الإصدار'**
  String get version;

  /// No description provided for @privacyPolicy.
  ///
  /// In ar, this message translates to:
  /// **'سياسة الخصوصية'**
  String get privacyPolicy;

  /// No description provided for @contactUs.
  ///
  /// In ar, this message translates to:
  /// **'اتصل بنا'**
  String get contactUs;

  /// No description provided for @shareApp.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة التطبيق'**
  String get shareApp;

  /// No description provided for @rateApp.
  ///
  /// In ar, this message translates to:
  /// **'قيم التطبيق'**
  String get rateApp;

  /// No description provided for @exit.
  ///
  /// In ar, this message translates to:
  /// **'خروج'**
  String get exit;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get confirm;

  /// No description provided for @delete.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get edit;

  /// No description provided for @save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get save;

  /// No description provided for @linkCopied.
  ///
  /// In ar, this message translates to:
  /// **'تم نسخ الرابط'**
  String get linkCopied;

  /// No description provided for @invalidUrl.
  ///
  /// In ar, this message translates to:
  /// **'رابط غير صالح'**
  String get invalidUrl;

  /// No description provided for @error.
  ///
  /// In ar, this message translates to:
  /// **'خطأ'**
  String get error;

  /// No description provided for @success.
  ///
  /// In ar, this message translates to:
  /// **'نجاح'**
  String get success;

  /// No description provided for @loading.
  ///
  /// In ar, this message translates to:
  /// **'جاري التحميل...'**
  String get loading;

  /// No description provided for @noLinksFound.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد روابط'**
  String get noLinksFound;

  /// No description provided for @search.
  ///
  /// In ar, this message translates to:
  /// **'بحث'**
  String get search;

  /// No description provided for @clearHistory.
  ///
  /// In ar, this message translates to:
  /// **'مسح السجل'**
  String get clearHistory;

  /// No description provided for @clearHistoryConfirmation.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من مسح السجل؟'**
  String get clearHistoryConfirmation;

  /// No description provided for @linkAdded.
  ///
  /// In ar, this message translates to:
  /// **'تم إضافة الرابط'**
  String get linkAdded;

  /// No description provided for @linkUpdated.
  ///
  /// In ar, this message translates to:
  /// **'تم تحديث الرابط'**
  String get linkUpdated;

  /// No description provided for @linkDeleted.
  ///
  /// In ar, this message translates to:
  /// **'تم حذف الرابط'**
  String get linkDeleted;

  /// No description provided for @enterLinkName.
  ///
  /// In ar, this message translates to:
  /// **'أدخل اسم الرابط'**
  String get enterLinkName;

  /// No description provided for @enterLinkUrl.
  ///
  /// In ar, this message translates to:
  /// **'أدخل عنوان الرابط'**
  String get enterLinkUrl;

  /// No description provided for @addLink.
  ///
  /// In ar, this message translates to:
  /// **'إضافة رابط'**
  String get addLink;

  /// No description provided for @retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry;

  /// No description provided for @updateLink.
  ///
  /// In ar, this message translates to:
  /// **'تحديث الرابط'**
  String get updateLink;

  /// No description provided for @saveLink.
  ///
  /// In ar, this message translates to:
  /// **'حفظ الرابط'**
  String get saveLink;

  /// No description provided for @deleteLink.
  ///
  /// In ar, this message translates to:
  /// **'حذف الرابط'**
  String get deleteLink;

  /// No description provided for @requiredTitle.
  ///
  /// In ar, this message translates to:
  /// **'الرجاء إدخال العنوان'**
  String get requiredTitle;

  /// No description provided for @requiredUrl.
  ///
  /// In ar, this message translates to:
  /// **'الرجاء إدخال الرابط'**
  String get requiredUrl;

  /// No description provided for @validUrl.
  ///
  /// In ar, this message translates to:
  /// **'الرجاء إدخال رابط صحيح'**
  String get validUrl;

  /// No description provided for @searchHint.
  ///
  /// In ar, this message translates to:
  /// **'بحث عن روابط...'**
  String get searchHint;

  /// No description provided for @language.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get language;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

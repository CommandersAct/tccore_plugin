import 'dart:collection';

import 'package:tccore_plugin/tccore.dart';
import 'package:tccore_plugin/utils/TCCoreConstants.dart';
import 'package:tccore_plugin/utils/TCSchemesAdditionalProperties.dart';

class TCUser extends TCSchemesAdditionalProperties
{
  static final TCUser _sharedInstance = TCUser._internal();
  late String? _ID;
  late String? _email;
  late String? _email_md5;
  late String? _email_sha256;
  late String? _consentID;
  late String? _phoneNumber;
  late String? _firstName;
  late String? _lastName;
  late String? _gender;
  late String? _birthdate;
  late String? _city;
  late String? _state;
  late String? _zipcode;
  late String? _country;
  late String? _anonymous_id;
  Map _consent_categories = {};
  Map _external_consent = {};
  Map _consent_vendors =  {};

  factory TCUser()
  {
    return _sharedInstance;
  }

  TCUser._internal();

  factory TCUser.fromJson(Map map)
  {
    _sharedInstance._consentID = map["consentID"];
    _sharedInstance._anonymous_id = map["consistent_anonymous_id"];
    _sharedInstance._consent_categories = (map["consent_categories"] ?? const {});
    _sharedInstance._external_consent = (map["external_consent"] ?? const {});
    _sharedInstance._consent_vendors = (map["consent_vendors"] ?? const {});
    return _sharedInstance;
  }

  resetConsent()
  {
    _sharedInstance._consent_categories.clear();
    _sharedInstance._external_consent.clear();
    _sharedInstance._consent_vendors.clear();
  }

  setFullConsent(Map<String, String> consent)
  {
    for (String cat in consent.keys)
    {
      String? value = consent[cat];
      if (value == null)
      {
        continue;
      }

      if (cat.startsWith(TCCoreConstants.kTCCategoryPrefix) || cat.startsWith(TCCoreConstants.kTCFeaturePrefix))
      {
        _sharedInstance._consent_categories[cat] = value;
      }
      else if (cat.startsWith(TCCoreConstants.kTCVendorPrefix) || cat.startsWith(TCCoreConstants.kTCGoogleVendorPrefix))
      {
        _sharedInstance._consent_vendors[cat] = value;
      }
    }

    TCCore.tcChannel.invokeMethod("setUserConsent", {"consent_categories" : _consent_categories, "external_consent" : _external_consent, "consent_vendors" : _consent_vendors});
  }

  set ID(String? value) {
    _ID = value;
    TCCore.tcChannel.invokeMethod("setValue", {"key" : "ID", "value" : _ID, "class" : runtimeType.toString()});
  }

  set email(String? value) {
    _email = value;
    TCCore.tcChannel.invokeMethod("setValue", {"key" : "email", "value" : _email, "class" : runtimeType.toString()});
  }

  set email_md5(String? value) {
    _email_md5 = value;
    TCCore.tcChannel.invokeMethod("setValue", {"key" : "email_md5", "value" : _email_md5, "class" : runtimeType.toString()});
  }

  set email_sha256(String? value) {
    _email_sha256 = value;
    TCCore.tcChannel.invokeMethod("setValue", {"key" : "email_sha256", "value" : _email_sha256, "class" : runtimeType.toString()});
  }

  set consentID(String? value) {
    _consentID = value;
    TCCore.tcChannel.invokeMethod("setValue", {"key" : "consentID", "value" : _consentID, "class" : runtimeType.toString()});
  }

  set phoneNumber(String? value) {
    _phoneNumber = value;
    TCCore.tcChannel.invokeMethod("setValue", {"key" : "phoneNumber", "value" : _phoneNumber, "class" : runtimeType.toString()});
  }

  set firstname(String? value) {
    _firstName = value;
    TCCore.tcChannel.invokeMethod("setValue", {"key" : "firstName", "value" : _firstName, "class" : runtimeType.toString()});
  }

  set lastname(String? value) {
    _lastName = value;
    TCCore.tcChannel.invokeMethod("setValue", {"key" : "lastName", "value" : _lastName, "class" : runtimeType.toString()});
  }

  set gender(String? value) {
    _gender = value;
    TCCore.tcChannel.invokeMethod("setValue", {"key" : "gender", "value" : _gender, "class" : runtimeType.toString()});
  }

  set birthdate(String? value) {
    _birthdate = value;
    TCCore.tcChannel.invokeMethod("setValue", {"key" : "birthdate", "value" : _birthdate, "class" : runtimeType.toString()});
  }

  set city(String? value) {
    _city = value;
    TCCore.tcChannel.invokeMethod("setValue", {"key" : "city", "value" : _city, "class" : runtimeType.toString()});
  }

  set state(String? value) {
    _state = value;
    TCCore.tcChannel.invokeMethod("setValue", {"key" : "state", "value" : _state, "class" : runtimeType.toString()});
  }

  set zipcode(String? value) {
    _zipcode = value;
    TCCore.tcChannel.invokeMethod("setValue", {"key" : "zipcode", "value" : _zipcode, "class" : runtimeType.toString()});
  }

  set country(String? value) {
    _country = value;
    TCCore.tcChannel.invokeMethod("setValue", {"key" : "country", "value" : _country, "class" : runtimeType.toString()});
  }

  set anonymous_id(String? value) {
    _anonymous_id = value;
    TCCore.tcChannel.invokeMethod("setValue", {"key" : "anonymous_id", "value" : _anonymous_id, "class" : runtimeType.toString()});
  }

  set consent_categories(Map<String, String> value) {
    _consent_categories = value;
    TCCore.tcChannel.invokeMethod("setConsentCategories", {"consent_categories" : _consent_categories});
  }

  set external_consent(Map<String, String> value) {
    _external_consent = value;
    TCCore.tcChannel.invokeMethod("setExternalConsent", {"external_consent" : _external_consent});
  }

  set consent_vendors(Map<String, String> value) {
    _consent_vendors = value;
    TCCore.tcChannel.invokeMethod("setConsentVendors", {"consent_vendors" : _consent_vendors});
  }

  String? get ID => _ID;

  String? get email => _email;

  String? get email_md5 => _email_md5;

  String? get email_sha256 => _email_sha256;

  String? get consentID => _consentID;

  String? get phoneNumber => _phoneNumber;

  String? get firstname => _firstName;

  String? get lastname => _lastName;

  String? get gender => _gender;

  String? get birthdate => _birthdate;

  String? get city => _city;

  String? get state => _state;

  String? get zipcode => _zipcode;

  String? get country => _country;

  String? get anonymous_id => _anonymous_id;
}
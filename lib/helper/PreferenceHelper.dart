import 'dart:convert';
import 'package:croma_brokrage/model/NumberApiResponse.dart';
import 'package:croma_brokrage/utils/PrefUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {



  static SharedPreferences? _preferences;
  static Future<SharedPreferences> get _instance async => _preferences = await SharedPreferences.getInstance();

  static Future<SharedPreferences?> init() async {
    _preferences = await _instance;
    return _preferences;
  }

  void saveIsUserNew(bool isLoggedIn) {
    _preferences!.setBool(PrefUtils.IS_USERNEW, isLoggedIn);
  }

  bool getIsUserNew() {
    return _preferences!.getBool(PrefUtils.IS_USERNEW) ?? true;
  }


  void saveIsFingerPrintAvailable(bool isLoggedIn) {
    _preferences!.setBool(PrefUtils.IS_PINGERPRINT_AVAILABLE, isLoggedIn);
  }

  bool getIsFingerPrintAvailable() {
    return _preferences!.getBool(PrefUtils.IS_PINGERPRINT_AVAILABLE) ?? false;
  }

  void saveFirebaseToken(String token) {
    _preferences!.setString(PrefUtils.FB_TOKEN, token);
  }

  String getFirebaseToken() {
    return _preferences!.getString(PrefUtils.FB_TOKEN) ?? "";
  }
  void savePinKey(final String pinkey) {
    _preferences!.setString(PrefUtils.KEY_PIN_IDENTIFIER, pinkey);
  }

  String GetPinKey() {
    return _preferences!.getString(PrefUtils.KEY_PIN_IDENTIFIER) ?? "";
  }

  void saveChangePinKey(final String pinkey) {
    _preferences!.setString(PrefUtils.KEY_PIN_CHANGE, pinkey);
  }

  String GetChangePinKey() {
    return _preferences!.getString(PrefUtils.KEY_PIN_CHANGE) ?? "";
  }

  void removePinChange() {
    _preferences!.remove(PrefUtils.KEY_PIN_CHANGE);
  }


  void saveSecurityLockType(int type) {
    _preferences!.setInt(PrefUtils.APP_Security_Lock, type);
  }

  int getSecurityLockType() {
    return _preferences!.getInt(PrefUtils.APP_Security_Lock) ?? 0;
  }


  void saveSelectedCurrency(String type) {
    _preferences!.setString(PrefUtils.SELECT_CURRENCY, type);
  }

  String getSelectedCurrency() {
    return _preferences!.getString(PrefUtils.SELECT_CURRENCY) ?? "euro";
  }


  void savePatternLockList(List<int> type) {
    List<String> stringsList;
    if(type!= []){
      stringsList=  type.map((i)=>i.toString()).toList();
    }else{
      stringsList= [];
    }
    _preferences!.setStringList(PrefUtils.Pattern_Lock, stringsList);

  }
  List<int> getPatternLockType() {
    List<int> mOriginaList = [];
    if( _preferences!.getStringList(PrefUtils.Pattern_Lock)==null){

      mOriginaList = [];
    }else{
      mOriginaList = _preferences!.getStringList(PrefUtils.Pattern_Lock)!.map((i)=> int.parse(i)).toList();
    }
    return mOriginaList;
  }

  NumberApiResponse getUserData() {
    final parsed = json.decode(_preferences!.getString(PrefUtils.USER_DATA) ?? "{}");
    return NumberApiResponse.fromJson(parsed);
  }

  void saveUserData(NumberApiResponse userData) {
    _preferences!.setString(PrefUtils.USER_DATA, json.encode(userData));
  }

  void saveIsUserLoggedIn(bool isLoggedIn) {
    _preferences!.setBool(PrefUtils.IS_LOGGED_IN, isLoggedIn);
  }

  bool getIsUserLoggedIn() {
    return _preferences!.getBool(PrefUtils.IS_LOGGED_IN) ?? false;
  }

  bool getIsUserLogFirst() {
    return _preferences!.getBool(PrefUtils.IS_FIRST) ?? false;
  }
  void saveIsUserLogFirst(bool isLoggedIn) {
    _preferences!.setBool(PrefUtils.IS_FIRST, isLoggedIn);
  }


  void saveSelectedCurrencyPrefix(String currency) {
    _preferences!.setString(PrefUtils.SP_PREFIX, currency);
  }

  String getSelectedCurrencyPrefix() {
    return _preferences!.getString(PrefUtils.SP_PREFIX) ?? "EURO ANIL KUMAR";
  }

  void saveSelectedCurrencyPrice(String currency) {
    _preferences!.setString(PrefUtils.SELECT_CURRENCY_PRICE, currency);
  }

  String getSelectedCurrencyPrice() {
    return _preferences!.getString(PrefUtils.SELECT_CURRENCY_PRICE) ?? "0";
  }

  void saveBalance(String token) {
    _preferences!.setString(PrefUtils.BALANCE, token);
  }

  String getBalance() {
    return _preferences!.getString(PrefUtils.BALANCE) ?? "0";
  }



  void clearAllData(){
    _preferences!.clear();
  }


  void clearOnlySession() {
    _preferences!.remove(PrefUtils.USER_DATA);
    _preferences!.remove(PrefUtils.IS_LOGGED_IN);
    _preferences!.remove(PrefUtils.IS_FIRST);
    _preferences!.remove(PrefUtils.IS_USERNEW);
    _preferences!.remove(PrefUtils.USER_BALANCE);
    _preferences!.remove(PrefUtils.FB_TOKEN);
    _preferences!.remove(PrefUtils.PASSWORD);
    _preferences!.remove(PrefUtils.COIN_ID);
    _preferences!.remove(PrefUtils.BALANCE);
    _preferences!.remove(PrefUtils.KEY_PIN_CHANGE);
    _preferences!.remove(PrefUtils.KEY_PIN_IDENTIFIER);
    _preferences!.remove(PrefUtils.SP_PREFIX);
    _preferences!.remove(PrefUtils.SELECT_CURRENCY);
    _preferences!.remove(PrefUtils.Private_Key);
    _preferences!.remove(PrefUtils.SELECT_CURRENCY_PRICE);
    _preferences!.remove(PrefUtils.Pattern_Lock);
    _preferences!.remove(PrefUtils.APP_Security_Lock);
    _preferences!.remove(PrefUtils.IS_RESTORE_WALLET);
    _preferences!.remove(PrefUtils.IS_AUTO_LOGOUT);
    _preferences!.remove(PrefUtils.SP_CURRENT_PIN);
    _preferences!.remove(PrefUtils.APP_Security_Lock);
    PreferenceHelper().clearAllData();
    PreferenceHelper().saveIsUserLoggedIn(false);
    PreferenceHelper().saveIsUserLogFirst(false);
    PreferenceHelper().saveIsUserNew(true);

  }
}

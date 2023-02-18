import 'dart:convert';

import 'package:blowfish_ecb/blowfish_ecb.dart';
import 'package:http/http.dart' as http;

class Leaf {
  static const _apiEndpoint = 'gdcportalgw.its-mo.com';
  static const _defaultPath = "/api_v210707_NE/gdc/";
  static const _initialAppStr = "9s5rfKVuMrT03RtzajWNcA";
  static const _regionCode = "NE";
  static const _locale = "en-US";
  static const regionCodes = ['NE', 'NCI', 'NNA', 'NMA', 'NML'];

  Leaf._();

  static login(String username, String password) async {
    var initialUrl = _buildUrl("InitialApp_v2");
    var initialResponse = await http.post(initialUrl, body: {
      "initial_app_str": _initialAppStr,
      "RegionCode": _regionCode,
      "lg": _locale,
    });
    var baseprm = jsonDecode(initialResponse.body)['baseprm'];

    var loginUrl = _buildUrl("UserLoginRequest");
    var loginReponse = await http.post(loginUrl, body: {
      "initial_app_str": _initialAppStr,
      "RegionCode": _regionCode,
      "lg": _locale,
      "UserId": username,
      "Password": _encryptPassword(baseprm, password)
    });
    // return Leaf._(baseprm);
  }

  static Uri _buildUrl(String path) {
    return Uri.https(_apiEndpoint, "$_defaultPath$path.php");
    // "gdcportalgw.its-mo.com/api_v210707_NE/gdc/UserLoginRequest.php"
  }

  static String _encryptPassword(key, code) {
    final blowfish = BlowfishECB(key);
    final encryptedData = blowfish.encode(code);
    return String.fromCharCodes(encryptedData);
  }
}


// ACRemoteStartRequest
// BatteryStatusRecordsRequest
// CheckCabinTemp
// GetInteriorTemperatureRequestForNsp
// GetInteriorTemperatureResultForNsp
// GetUserTemperatureInfoRequest
// GetVehicleInfoRequest
// InitialApp_v2
// RemoteACRecordsRequest
// UserLoginRequest
// UserLoginRequestSimple
// auth-encrypt
// auth-redirect
// ACRemoteNewRequest
// ACRemoteUpdateRequest
// ACRemoteRequest
// ACRemoteResult
// ACRemoteOffRequest
// ACRemoteOffResult
// ACRemoteCancelRequest
// GetNotificationHistory
// GetContactNumberResponse
// GetScheduledACRemoteRequest
// BatteryRemoteChargingRequest
// CarKarteRegisterDrivingNoteRequest
// CarKarteDetailInfoRequest
// CarKarteGraphInfoRequest
// NationalRankingBasicScreenRequest
// WorldRankingRegisterEntryCodeRequest
// WorldRankingTopInfoRequest
// PriceSimulatorRegisterElectricPriceRequest
// DriveAnalysisBasicScreenRequestEx
// WorldRankingTop100InfoRequestEx
// GetPreferenceNotification
// PriceSimulatorDetailInfoRequest
// RegisterPreferenceNotification
// RemoteBatteryChargingRecordsRequest
// BatteryStatusCheckForSPAppsRequest
// BatteryStatusCheckForSPAppsResultRequest
// BatteryStatusCheckRequest
// BatteryStatusCheckResultRequest
// PriceSimulatorGetMapDataInfoRequest
// GetRegionSetting
// PluginMissingRecordsRequest
// BatteryChargingCompletionRecordsRequest
// GetCountrySetting
// EcoForestResetRequest
// EcoForestGraphInfoRequest
// DriveAnalysisDetailRequest
// CarKarteDetailCalendarRequest
// start-charge-state-req-request
// MyCarFinderRequest
// MyCarFinderResultRequest
// MyCarFinderLatLng
// world_eco_forest
// car_karte_graph
// national_ranking_info
// national_ranking_graph
// dateformat
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_analytics_piwik/model/custom_variable_scope.dart';
import 'package:flutter_analytics_piwik/model/ecommerce_transaction_item.dart';

class FlutterPiwikPro {
  static const configureTrackerName = 'configure_Tracker';
  static const trackScreenName = 'track_screen';
  static const setAnonymizationStatenName = 'set_anonymization_state';
  static const trackCustomEventName = 'track_custom_event';
  static const trackExceptionName = 'track_exception';
  static const trackSocialInteractionName = 'track_social_interaction';
  static const trackDownloadName = 'track_download';
  static const trackOutlinkName = 'track_outlink';
  static const trackSearchName = 'track_search';
  static const trackAppInstallName = "track_app_install";
  static const trackContentImpressionName = 'track_content_impression';
  static const trackContentInteractionName = 'track_content_interaction';
  static const trackGoalName = 'track_goal';
  static const trackEcommerceTransactionName = 'track_ecommerce_transaction';
  static const trackCampaignName = 'track_campaign';
  static const trackCustomVariableName = 'track_custom_variable';
  static const trackCustomDimensionName = 'track_custom_dimension';
  static const trackProfileAttributeName = 'track_profile_attribute';
  static const readUserProfileAttributesName = 'read_user_profile_attributes';
  static const checkAudienceMembershipName = 'check_audience_membership';
  static const setUserIdName = 'set_user_id';
  static const setUserEmailName = 'set_user_email';
  static const setVisitorIdName = 'set_visitor_id';
  static const setSessionTimeoutName = 'set_session_timeout';
  static const setDispatchIntervalName = 'set_dispatch_interval';
  static const dispatchName = 'dispatch';
  static const setIncludeDefaultVariablesName = 'set_include_default_variables';
  static const optOutName = "opt_out";
  static const dryRunName = "dry_run";

  static const _channel = MethodChannel('piwik_flutter');

  FlutterPiwikPro._internal();
  static final FlutterPiwikPro _instance = FlutterPiwikPro._internal();
  static FlutterPiwikPro get sharedInstance {
    return _instance;
  }

  Future<String> configureTracker({required String baseURL, required String siteId}) async {
    var arguments = <String, dynamic>{};
    arguments['baseURL'] = baseURL;
    arguments['siteId'] = siteId;
    final result = await _channel.invokeMethod(configureTrackerName, arguments);
    return result;
  }

  //title parameter available only on android
  Future<String> trackScreen({required String screenName, String? title}) async {
    var arguments = <String, dynamic>{};
    arguments['screenName'] = screenName;
    arguments['title'] = title;
    final result = await _channel.invokeMethod(trackScreenName, arguments);
    return result;
  }

  Future<String> setAnonymizationState(bool shouldAnonymize) async {
    var arguments = <String, dynamic>{};
    arguments['shouldAnonymize'] = shouldAnonymize;
    final result = await _channel.invokeMethod(setAnonymizationStatenName, arguments);
    return result;
  }

  //path parameter available only on android
  Future<String> trackCustomEvent(
      {required String category, required String action, String? name, double? value, String? path}) async {
    var arguments = <String, dynamic>{};
    arguments['category'] = category;
    arguments['action'] = action;
    arguments['name'] = name;
    arguments['value'] = value;
    arguments['path'] = path;

    final result = await _channel.invokeMethod(trackCustomEventName, arguments);
    return result;
  }

  Future<String> trackException({required String description, bool? isFatal}) async {
    var arguments = <String, dynamic>{};
    arguments['description'] = description;
    arguments['isFatal'] = isFatal;

    final result = await _channel.invokeMethod(trackExceptionName, arguments);
    return result;
  }

  Future<String> trackSocialInteraction({required String interaction, required String network, String? target}) async {
    var arguments = <String, dynamic>{};
    arguments['network'] = network;
    arguments['interaction'] = interaction;
    arguments['target'] = target;

    final result = await _channel.invokeMethod(trackSocialInteractionName, arguments);
    return result;
  }

  Future<String> trackDownload(String url) async {
    var arguments = <String, dynamic>{};
    arguments['url'] = url;

    final result = await _channel.invokeMethod(trackDownloadName, arguments);
    return result;
  }

  Future<String> trackAppInstall() async {
    final result = await _channel.invokeMethod(trackAppInstallName);
    return result;
  }

  Future<String> trackOutlink(String url) async {
    var arguments = <String, dynamic>{};
    arguments['url'] = url;

    final result = await _channel.invokeMethod(trackOutlinkName, arguments);
    return result;
  }

  Future<String> trackSearch({required String keyword, String? category, int? numberOfHits}) async {
    var arguments = <String, dynamic>{};
    arguments['keyword'] = keyword;
    arguments['category'] = category;
    arguments['numberOfHits'] = numberOfHits;

    final result = await _channel.invokeMethod(trackSearchName, arguments);
    return result;
  }

  Future<String> trackContentImpression({required String contentName, String? piece, String? target}) async {
    var arguments = <String, dynamic>{};
    arguments['contentName'] = contentName;
    arguments['piece'] = piece;
    arguments['target'] = target;

    final result = await _channel.invokeMethod(trackContentImpressionName, arguments);
    return result;
  }

  Future<String> trackContentInteraction({
    required String contentName,
    required String contentInteraction,
    String? piece,
    String? target,
  }) async {
    var arguments = <String, dynamic>{};
    arguments['contentName'] = contentName;
    arguments['contentInteraction'] = contentInteraction;
    arguments['piece'] = piece;
    arguments['target'] = target;

    final result = await _channel.invokeMethod(trackContentInteractionName, arguments);
    return result;
  }

  Future<String> trackGoal({required int goal, double? revenue}) async {
    var arguments = <String, dynamic>{};
    arguments['goal'] = goal;
    arguments['revenue'] = revenue;

    final result = await _channel.invokeMethod(trackGoalName, arguments);
    return result;
  }

  Future<String> trackEcommerceTransaction({
    required String identifier,
    required int grandTotal,
    int? subTotal,
    int? tax,
    int? shippingCost,
    int? discount,
    List<EcommerceTransactionItem>? transactionItems,
  }) async {
    var arguments = <String, dynamic>{};
    arguments['identifier'] = identifier;
    arguments['grandTotal'] = grandTotal;
    arguments['subTotal'] = subTotal;
    arguments['tax'] = tax;
    arguments['shippingCost'] = shippingCost;
    arguments['discount'] = discount;

    final items = [];

    transactionItems?.forEach((item) {
      final itemMap = <String, dynamic>{};
      itemMap['sku'] = item.sku;
      itemMap['name'] = item.name;
      itemMap['category'] = item.category;
      itemMap['price'] = item.price;
      itemMap['quantity'] = item.quantity;
      items.add(itemMap);
    });
    arguments['transactionItems'] = items;

    final result = await _channel.invokeMethod(trackEcommerceTransactionName, arguments);
    return result;
  }

  Future<String> trackCampaign(String url) async {
    var arguments = <String, dynamic>{};
    arguments['url'] = url;

    final result = await _channel.invokeMethod(trackCampaignName, arguments);
    return result;
  }

  Future<String> trackCustomVariable(
      {required int index, required String name, required String value, required CustomVariableScope scope}) async {
    var arguments = <String, dynamic>{};
    arguments['index'] = index;
    arguments['name'] = name;
    arguments['value'] = value;
    if (scope == CustomVariableScope.action) {
      arguments['scope'] = 'action';
    } else if (scope == CustomVariableScope.visit) {
      arguments['scope'] = 'visit';
    }

    final result = await _channel.invokeMethod(trackCustomVariableName, arguments);
    return result;
  }

  Future<String> trackCustomDimension({required int index, required String value}) async {
    var arguments = <String, dynamic>{};
    arguments['index'] = index;
    arguments['value'] = value;

    final result = await _channel.invokeMethod(trackCustomDimensionName, arguments);
    return result;
  }

  Future<String> trackProfileAttribute({required String name, required String value}) async {
    var arguments = <String, dynamic>{};
    arguments['name'] = name;
    arguments['value'] = value;

    final result = await _channel.invokeMethod(trackProfileAttributeName, arguments);
    return result;
  }

  Future<Map<String, String>> readUserProfileAttributes() async {
    final result = await _channel.invokeMapMethod(readUserProfileAttributesName);
    final castedResult = Map<String, String>.from(result!);
    return castedResult;
  }

  Future<bool> checkAudienceMembership(String audienceId) async {
    var arguments = <String, dynamic>{};
    arguments['audienceId'] = audienceId;

    final result = await _channel.invokeMethod(checkAudienceMembershipName, arguments);
    return result;
  }

  Future<String> setUserId(String? id) async {
    var arguments = <String, dynamic>{};
    arguments['id'] = id;

    final result = await _channel.invokeMethod(setUserIdName, arguments);
    return result;
  }

  Future<String> setUserEmail(String email) async {
    var arguments = <String, dynamic>{};
    arguments['email'] = email;

    final result = await _channel.invokeMethod(setUserEmailName, arguments);
    return result;
  }

  Future<String> setVisitorId(String id) async {
    var arguments = <String, dynamic>{};
    arguments['id'] = id;

    final result = await _channel.invokeMethod(setVisitorIdName, arguments);
    return result;
  }

  Future<String> setSessionTimeout(int timeoutInMilliseconds) async {
    var arguments = <String, dynamic>{};
    arguments['timeoutInMilliseconds'] = timeoutInMilliseconds;

    final result = await _channel.invokeMethod(setSessionTimeoutName, arguments);
    return result;
  }

  Future<String> setDispatchInterval(int intervalInMilliseconds) async {
    var arguments = <String, dynamic>{};
    arguments['intervalInMilliseconds'] = intervalInMilliseconds;

    final result = await _channel.invokeMethod(setDispatchIntervalName, arguments);
    return result;
  }

  Future<String> dispatch() async {
    final result = await _channel.invokeMethod(dispatchName);
    return result;
  }

  Future<String> setIncludeDefaultVariables(bool shouldInclude) async {
    var arguments = <String, dynamic>{};
    arguments['shouldInclude'] = shouldInclude;

    final results = await _channel.invokeMethod(setIncludeDefaultVariablesName, arguments);
    return results;
  }

  Future<String> optOut(bool shouldOptOut) async {
    var arguments = <String, dynamic>{};
    arguments['shouldOptOut'] = shouldOptOut;

    final results = await _channel.invokeMethod(optOutName, arguments);
    return results;
  }

  Future<String> dryRun(bool shouldDryRun) async {
    var arguments = <String, dynamic>{};
    arguments['shouldDryRun'] = shouldDryRun;

    final results = await _channel.invokeMethod(dryRunName, arguments);
    return results;
  }
}

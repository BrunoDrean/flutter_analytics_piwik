import 'package:flutter/services.dart';
import 'package:flutter_analytics_piwik/flutter_piwikpro.dart';
import 'package:flutter_analytics_piwik/model/custom_variable_scope.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('piwik_flutter');
  TestWidgetsFlutterBinding.ensureInitialized();

  const configureTrackerResult = 'configured the tracker';
  const sendViewResult = 'sent a view';
  const setAnonymizationStateResult = 'set anonymization';
  const trackCustomEventResult = 'sent a custom event';
  const trackExceptionResult = 'tracked an exception';
  const trackSocialInteractionResult = 'tracked a social interaction';
  const trackDownloadResult = 'tracker a download';
  const trackAppInstallResult = 'tracked an app install';
  const trackOutlinkResult = 'tracked an outlink';
  const trackSearchResult = 'tracked a search';
  const trackContentImpressionResult = 'tracked a content impression';
  const trackContentInteractionResult = 'tracked a content interaciton';
  const trackGoalResult = 'tracked a goal';
  const trackEcommerceTransactionResult = 'tracked an ecommerce transaction';
  const trackCampaignResult = 'tracked a campaign';
  const trackCustomVariableResult = 'tracked a custom variable';
  const trackCustomDimensionResult = 'tracked a custom dimension';
  const trackProfileAttributeResult = 'tracked a profile attribute';
  const readUserProfileAttributesResult = {'testName': 'testValue'};
  const checkAudienceMembershipResult = true;
  const setUserIdResult = 'set a user id';
  const setUserEmailResult = 'set a user email';
  const setVisitorIdResult = 'set a visitorId';
  const setSessionTimeoutResult = 'set a session timeout';
  const setDispatchIntervalResult = 'set a dispatch interval';
  const dispatchResult = 'dispatched all events from the queue';
  const setIncludeDefaultVariablesResult = 'set whether default variables should be included';
  const optOutResult = 'opted out';
  const dryRunResult = 'dry run enabled';

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case FlutterPiwikPro.configureTrackerName:
          return configureTrackerResult;
        case FlutterPiwikPro.trackScreenName:
          return sendViewResult;
        case FlutterPiwikPro.setAnonymizationStatenName:
          return setAnonymizationStateResult;
        case FlutterPiwikPro.trackCustomEventName:
          return trackCustomEventResult;
        case FlutterPiwikPro.trackExceptionName:
          return trackExceptionResult;
        case FlutterPiwikPro.trackSocialInteractionName:
          return trackSocialInteractionResult;
        case FlutterPiwikPro.trackOutlinkName:
          return trackOutlinkResult;
        case FlutterPiwikPro.trackSearchName:
          return trackSearchResult;
        case FlutterPiwikPro.trackDownloadName:
          return trackDownloadResult;
        case FlutterPiwikPro.trackAppInstallName:
          return trackAppInstallResult;
        case FlutterPiwikPro.trackContentImpressionName:
          return trackContentImpressionResult;
        case FlutterPiwikPro.trackContentInteractionName:
          return trackContentInteractionResult;
        case FlutterPiwikPro.trackGoalName:
          return trackGoalResult;
        case FlutterPiwikPro.trackEcommerceTransactionName:
          return trackEcommerceTransactionResult;
        case FlutterPiwikPro.trackCampaignName:
          return trackCampaignResult;
        case FlutterPiwikPro.trackCustomVariableName:
          return trackCustomVariableResult;
        case FlutterPiwikPro.trackCustomDimensionName:
          return trackCustomDimensionResult;
        case FlutterPiwikPro.trackProfileAttributeName:
          return trackProfileAttributeResult;
        case FlutterPiwikPro.readUserProfileAttributesName:
          return readUserProfileAttributesResult;
        case FlutterPiwikPro.checkAudienceMembershipName:
          return checkAudienceMembershipResult;
        case FlutterPiwikPro.setUserIdName:
          return setUserIdResult;
        case FlutterPiwikPro.setUserEmailName:
          return setUserEmailResult;
        case FlutterPiwikPro.setVisitorIdName:
          return setVisitorIdResult;
        case FlutterPiwikPro.setSessionTimeoutName:
          return setSessionTimeoutResult;
        case FlutterPiwikPro.setDispatchIntervalName:
          return setDispatchIntervalResult;
        case FlutterPiwikPro.dispatchName:
          return dispatchResult;
        case FlutterPiwikPro.setIncludeDefaultVariablesName:
          return setIncludeDefaultVariablesResult;
        case FlutterPiwikPro.optOutName:
          return optOutResult;
        case FlutterPiwikPro.dryRunName:
          return dryRunResult;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('configureTracker - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.configureTracker(baseURL: 'baseURL', siteId: 'siteId');
    expect(result, equals(configureTrackerResult));
  });

  test('setAnonymizationState - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.setAnonymizationState(true);
    expect(result, equals(setAnonymizationStateResult));
  });

  test('trackScreen - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.trackScreen(screenName: 'screenName');
    expect(result, equals(sendViewResult));
  });

  test('trackCustomEvent - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.trackCustomEvent(action: 'action', category: 'category');
    expect(result, equals(trackCustomEventResult));
  });

  test('trackException - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.trackException(description: 'description', isFatal: false);
    expect(result, equals(trackExceptionResult));
  });

  test('trackSocialInteraction - correct method is called', () async {
    final result =
        await FlutterPiwikPro.sharedInstance.trackSocialInteraction(interaction: 'interaction', network: 'network');
    expect(result, equals(trackSocialInteractionResult));
  });

  test('trackOutlink - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.trackOutlink('https://testurl.com');
    expect(result, equals(trackOutlinkResult));
  });

  test('trackSearch - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance
        .trackSearch(keyword: 'Keyword', category: 'Best category', numberOfHits: 10);
    expect(result, equals(trackSearchResult));
  });

  test('trackDownload - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.trackDownload('https://averyniceurl.com');
    expect(result, equals(trackDownloadResult));
  });

  test('trackAppInstall - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.trackAppInstall();
    expect(result, equals(trackAppInstallResult));
  });

  test('trackContentImpression - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.trackContentImpression(contentName: 'best content');
    expect(result, equals(trackContentImpressionResult));
  });

  test('trackContentInteraction - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance
        .trackContentInteraction(contentName: 'bestContent', contentInteraction: 'clicked');
    expect(result, equals(trackContentInteractionResult));
  });

  test('trackGoal - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.trackGoal(goal: 10, revenue: 100.0);
    expect(result, equals(trackGoalResult));
  });

  test('trackEcommerceTransaction - correct method is called', () async {
    final result =
        await FlutterPiwikPro.sharedInstance.trackEcommerceTransaction(identifier: 'testID', grandTotal: 100);
    expect(result, equals(trackEcommerceTransactionResult));
  });

  test('trackCampaign - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance
        .trackCampaign("http://example.org/offer.html?pk_campaign=Email-SummerDeals&pk_keyword=LearnMore");
    expect(result, equals(trackCampaignResult));
  });

  test('trackCustomVariable - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance
        .trackCustomVariable(index: 1, name: 'good name', value: 'best value', scope: CustomVariableScope.action);
    expect(result, equals(trackCustomVariableResult));
  });

  test('trackCustomDimension - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.trackCustomDimension(index: 5, value: 'best value');
    expect(result, equals(trackCustomDimensionResult));
  });

  test('trackProfileAttribute - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.trackProfileAttribute(name: 'testName', value: 'testValue');
    expect(result, equals(trackProfileAttributeResult));
  });

  test('readProfileAttributes - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.readUserProfileAttributes();
    expect(result, equals(readUserProfileAttributesResult));
  });

  test('checkAudienceMembership - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.checkAudienceMembership('testId');
    expect(result, equals(checkAudienceMembershipResult));
  });

  test('setUserId - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.setUserId('testId');
    expect(result, equals(setUserIdResult));
  });

  test('setUserEmail - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.setUserEmail('testEmail@test.test');
    expect(result, equals(setUserEmailResult));
  });

  test('setVisitorId - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.setVisitorId('testVisitorId');
    expect(result, equals(setVisitorIdResult));
  });

  test('setSessionTimeout - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.setSessionTimeout(1800);
    expect(result, equals(setSessionTimeoutResult));
  });

  test('setDispatchInterval - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.setDispatchInterval(1800);
    expect(result, equals(setDispatchIntervalResult));
  });

  test('dispatch - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.dispatch();
    expect(result, equals(dispatchResult));
  });

  test('setIncludeDefaultVariables - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.setIncludeDefaultVariables(false);
    expect(result, equals(setIncludeDefaultVariablesResult));
  });

  test('optOut - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.optOut(true);
    expect(result, equals(optOutResult));
  });

  test('dryRun - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.dryRun(true);
    expect(result, equals(dryRunResult));
  });
}

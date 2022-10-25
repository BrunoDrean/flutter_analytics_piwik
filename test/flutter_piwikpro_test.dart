import 'package:flutter/services.dart';
import 'package:flutter_piwikpro/model/custom_variable_scope.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_piwikpro/flutter_piwikpro.dart';

void main() {
  const MethodChannel channel = MethodChannel('piwik_flutter');
  TestWidgetsFlutterBinding.ensureInitialized();

  const _configureTrackerResult = 'configured the tracker';
  const _sendViewResult = 'sent a view';
  const _setAnonymizationStateResult = 'set anonymization';
  const _trackCustomEventResult = 'sent a custom event';
  const _trackExceptionResult = 'tracked an exception';
  const _trackSocialInteractionResult = 'tracked a social interaction';
  const _trackDownloadResult = 'tracker a download';
  const _trackAppInstallResult = 'tracked an app install';
  const _trackOutlinkResult = 'tracked an outlink';
  const _trackSearchResult = 'tracked a search';
  const _trackContentImpressionResult = 'tracked a content impression';
  const _trackContentInteractionResult = 'tracked a content interaciton';
  const _trackGoalResult = 'tracked a goal';
  const _trackEcommerceTransactionResult = 'tracked an ecommerce transaction';
  const _trackCampaignResult = 'tracked a campaign';
  const _trackCustomVariableResult = 'tracked a custom variable';
  const _trackCustomDimensionResult = 'tracked a custom dimension';
  const _trackProfileAttributeResult = 'tracked a profile attribute';
  const _readUserProfileAttributesResult = {'testName': 'testValue'};
  const _checkAudienceMembershipResult = true;
  const _setUserIdResult = 'set a user id';
  const _setUserEmailResult = 'set a user email';
  const _setVisitorIdResult = 'set a visitorId';
  const _setSessionTimeoutResult = 'set a session timeout';
  const _setDispatchIntervalResult = 'set a dispatch interval';
  const _dispatchResult = 'dispatched all events from the queue';
  const _setIncludeDefaultVariablesResult = 'set whether default variables should be included';
  const _optOutResult = 'opted out';
  const _dryRunResult = 'dry run enabled';

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case FlutterPiwikPro.configureTrackerName:
          return _configureTrackerResult;
        case FlutterPiwikPro.trackScreenName:
          return _sendViewResult;
        case FlutterPiwikPro.setAnonymizationStatenName:
          return _setAnonymizationStateResult;
        case FlutterPiwikPro.trackCustomEventName:
          return _trackCustomEventResult;
        case FlutterPiwikPro.trackExceptionName:
          return _trackExceptionResult;
        case FlutterPiwikPro.trackSocialInteractionName:
          return _trackSocialInteractionResult;
        case FlutterPiwikPro.trackOutlinkName:
          return _trackOutlinkResult;
        case FlutterPiwikPro.trackSearchName:
          return _trackSearchResult;
        case FlutterPiwikPro.trackDownloadName:
          return _trackDownloadResult;
        case FlutterPiwikPro.trackAppInstallName:
          return _trackAppInstallResult;
        case FlutterPiwikPro.trackContentImpressionName:
          return _trackContentImpressionResult;
        case FlutterPiwikPro.trackContentInteractionName:
          return _trackContentInteractionResult;
        case FlutterPiwikPro.trackGoalName:
          return _trackGoalResult;
        case FlutterPiwikPro.trackEcommerceTransactionName:
          return _trackEcommerceTransactionResult;
        case FlutterPiwikPro.trackCampaignName:
          return _trackCampaignResult;
        case FlutterPiwikPro.trackCustomVariableName:
          return _trackCustomVariableResult;
        case FlutterPiwikPro.trackCustomDimensionName:
          return _trackCustomDimensionResult;
        case FlutterPiwikPro.trackProfileAttributeName:
          return _trackProfileAttributeResult;
        case FlutterPiwikPro.readUserProfileAttributesName:
          return _readUserProfileAttributesResult;
        case FlutterPiwikPro.checkAudienceMembershipName:
          return _checkAudienceMembershipResult;
        case FlutterPiwikPro.setUserIdName:
          return _setUserIdResult;
        case FlutterPiwikPro.setUserEmailName:
          return _setUserEmailResult;
        case FlutterPiwikPro.setVisitorIdName:
          return _setVisitorIdResult;
        case FlutterPiwikPro.setSessionTimeoutName:
          return _setSessionTimeoutResult;
        case FlutterPiwikPro.setDispatchIntervalName:
          return _setDispatchIntervalResult;
        case FlutterPiwikPro.dispatchName:
          return _dispatchResult;
        case FlutterPiwikPro.setIncludeDefaultVariablesName:
          return _setIncludeDefaultVariablesResult;
        case FlutterPiwikPro.optOutName:
          return _optOutResult;
        case FlutterPiwikPro.dryRunName:
          return _dryRunResult;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('configureTracker - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance
        .configureTracker(baseURL: 'baseURL', siteId: 'siteId');
    expect(result, equals(_configureTrackerResult));
  });

  test('setAnonymizationState - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.setAnonymizationState(true);
    expect(result, equals(_setAnonymizationStateResult));
  });

  test('trackScreen - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.trackScreen(screenName: 'screenName');
    expect(result, equals(_sendViewResult));
  });

  test('trackCustomEvent - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance
        .trackCustomEvent(action: 'action', category: 'category');
    expect(result, equals(_trackCustomEventResult));
  });

  test('trackException - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance
        .trackException(description: 'description', isFatal: false);
    expect(result, equals(_trackExceptionResult));
  });

  test('trackSocialInteraction - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance
        .trackSocialInteraction(interaction: 'interaction', network: 'network');
    expect(result, equals(_trackSocialInteractionResult));
  });

  test('trackOutlink - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.trackOutlink('https://testurl.com');
    expect(result, equals(_trackOutlinkResult));
  });

  test('trackSearch - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance
        .trackSearch(keyword: 'Keyword', category: 'Best category', numberOfHits: 10);
    expect(result, equals(_trackSearchResult));
  });

  test('trackDownload - correct method is called', () async {
    final result =
        await FlutterPiwikPro.sharedInstance.trackDownload('https://averyniceurl.com');
    expect(result, equals(_trackDownloadResult));
  });

  test('trackAppInstall - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.trackAppInstall();
    expect(result, equals(_trackAppInstallResult));
  });

  test('trackContentImpression - correct method is called', () async {
    final result =
        await FlutterPiwikPro.sharedInstance.trackContentImpression(contentName: 'best content');
    expect(result, equals(_trackContentImpressionResult));
  });

  test('trackContentInteraction - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance
        .trackContentInteraction(contentName: 'bestContent', contentInteraction: 'clicked');
    expect(result, equals(_trackContentInteractionResult));
  });

  test('trackGoal - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.trackGoal(goal: 10, revenue: 100.0);
    expect(result, equals(_trackGoalResult));
  });

  test('trackEcommerceTransaction - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance
        .trackEcommerceTransaction(identifier: 'testID', grandTotal: 100);
    expect(result, equals(_trackEcommerceTransactionResult));
  });

  test('trackCampaign - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.trackCampaign(
        "http://example.org/offer.html?pk_campaign=Email-SummerDeals&pk_keyword=LearnMore");
    expect(result, equals(_trackCampaignResult));
  });

  test('trackCustomVariable - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.trackCustomVariable(
        index: 1, name: 'good name', value: 'best value', scope: CustomVariableScope.action);
    expect(result, equals(_trackCustomVariableResult));
  });

  test('trackCustomDimension - correct method is called', () async {
    final result =
        await FlutterPiwikPro.sharedInstance.trackCustomDimension(index: 5, value: 'best value');
    expect(result, equals(_trackCustomDimensionResult));
  });

  test('trackProfileAttribute - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance
        .trackProfileAttribute(name: 'testName', value: 'testValue');
    expect(result, equals(_trackProfileAttributeResult));
  });

  test('readProfileAttributes - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.readUserProfileAttributes();
    expect(result, equals(_readUserProfileAttributesResult));
  });

  test('checkAudienceMembership - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.checkAudienceMembership('testId');
    expect(result, equals(_checkAudienceMembershipResult));
  });

  test('setUserId - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.setUserId('testId');
    expect(result, equals(_setUserIdResult));
  });

  test('setUserEmail - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.setUserEmail('testEmail@test.test');
    expect(result, equals(_setUserEmailResult));
  });

  test('setVisitorId - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.setVisitorId('testVisitorId');
    expect(result, equals(_setVisitorIdResult));
  });

  test('setSessionTimeout - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.setSessionTimeout(1800);
    expect(result, equals(_setSessionTimeoutResult));
  });

  test('setDispatchInterval - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.setDispatchInterval(1800);
    expect(result, equals(_setDispatchIntervalResult));
  });

  test('dispatch - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.dispatch();
    expect(result, equals(_dispatchResult));
  });

  test('setIncludeDefaultVariables - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.setIncludeDefaultVariables(false);
    expect(result, equals(_setIncludeDefaultVariablesResult));
  });

  test('optOut - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.optOut(true);
    expect(result, equals(_optOutResult));
  });

  test('dryRun - correct method is called', () async {
    final result = await FlutterPiwikPro.sharedInstance.dryRun(true);
    expect(result, equals(_dryRunResult));
  });
}

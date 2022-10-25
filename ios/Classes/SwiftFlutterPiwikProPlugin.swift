import Flutter
import PiwikPROSDK

public class SwiftFlutterPiwikProPlugin: NSObject, FlutterPlugin {
    var tracker: PiwikTracker?
    
    static let configureTrackerName = "configure_Tracker"
    static let trackScreenName = "track_screen"
    static let setAnonymizationStateName = "set_anonymization_state"
    static let trackCustomEventName = "track_custom_event"
    static let trackExceptionName = "track_exception"
    static let trackSocialInteractionName = "track_social_interaction"
    static let trackDownloadName = "track_download"
    static let trackOutlinkName = "track_outlink"
    static let trackSearchName = "track_search"
    static let trackAppInstallName = "track_app_install"
    static let trackContentImpressionName = "track_content_impression"
    static let trackContentInteractionName = "track_content_interaction"
    static let trackGoalName = "track_goal"
    static let trackEcommerceTransactionName = "track_ecommerce_transaction"
    static let trackCampaignName = "track_campaign"
    static let trackCustomVariableName = "track_custom_variable"
    static let trackCustomDimensionName = "track_custom_dimension"
    static let trackProfileAttributeName = "track_profile_attribute"
    static let readUserProfileAttributesName = "read_user_profile_attributes"
    static let checkAudienceMembershipName = "check_audience_membership"
    static let setUserIdName = "set_user_id"
    static let setUserEmailName = "set_user_email"
    static let setVisitorId = "set_visitor_id"
    static let setSessionTimeoutName = "set_session_timeout"
    static let setDispatchIntervalName = "set_dispatch_interval"
    static let dispatchName = "dispatch"
    static let setIncludeDefaultVariablesName = "set_include_default_variables"
    static let optOutName = "opt_out"
    static let dryRunName = "dry_run"
    
    static let flutterSourceTrafficName = "Flutter"
    static let flutterSourceTrafficVersion = "0.0.1"
    
    static let sdkName = "FlutterPiwikPro"

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "piwik_flutter", binaryMessenger: registrar.messenger())
        let delegate = SwiftFlutterPiwikProPlugin()
        registrar.addMethodCallDelegate(delegate, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.configureTrackerName) {
            handleConfigureTracker(call, result: result)
            return
        }
        else if !validateTracker() {
            result(FlutterError.notInitializedError(errorMessage: "\(call.method) failed"))
            return
        }
        
        if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.trackScreenName) {
            handleTrackScreen(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.setAnonymizationStateName) {
            handleSetAnonymizationState(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.trackCustomEventName){
            handleTrackCustomEvent(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.trackExceptionName) {
            handleTrackException(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.trackSocialInteractionName) {
            handleTrackSocialInteraction(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.trackDownloadName) {
            handleTrackDownload(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.trackOutlinkName) {
            handleTrackOutlink(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.trackSearchName) {
            handleTrackSearch(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.trackAppInstallName) {
            handleTrackAppInstall(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.trackContentImpressionName) {
            handleTrackContentImpression(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.trackContentInteractionName) {
            handleTrackContentInteraction(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.trackGoalName) {
            handleTrackGoal(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.trackEcommerceTransactionName) {
            handleTrackEcommerceTransaction(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.trackCampaignName) {
            handleTrackCampaign(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.trackCustomVariableName) {
            handleTrackCustomVariable(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.trackCustomDimensionName) {
            handleTrackCustomDimension(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.trackProfileAttributeName) {
            handleTrackProfileAttribute(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.readUserProfileAttributesName) {
            handleReadUserProfileAttributes(result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.checkAudienceMembershipName) {
            handleCheckAudienceMembership(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.setUserIdName) {
            handleSetUserId(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.setUserEmailName) {
            handleSetUserEmail(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.setVisitorId) {
            handleSetVisitorId(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.setSessionTimeoutName) {
            handleSetSessionTimeout(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.setDispatchIntervalName) {
            handleSetDispatchInterval(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.dispatchName) {
            handleDispatch(result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.setIncludeDefaultVariablesName) {
            handleSetIncludeDefaultVariables(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.optOutName) {
            handleOptOut(call, result: result)
        }
        else if call.method.elementsEqual(SwiftFlutterPiwikProPlugin.dryRunName) {
            handleDryRun(call, result: result)
        }
        else {
            result(FlutterError(code: SwiftFlutterPiwikProPlugin.sdkName, message: "\(call.method) failed", details: "Not implemented"))
        }
    }
    
    private func validateTracker() -> Bool {
        return tracker != nil
    }
    
    private func handleConfigureTracker(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        let siteId = arguments?["siteId"] as? String;
        let baseURL = arguments?["baseURL"] as? String;
        
        guard let siteId = siteId, let baseURL = baseURL, !siteId.isEmpty, !baseURL.isEmpty
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "configureTracker failed", errorDetails: "Missing either baseURL or siteId parameters"))
            return
        }
        
        tracker = PiwikTracker.sharedInstance(siteID: siteId, baseURL: URL(string: baseURL)!)
        tracker?.sourceTrafficName = NSString(string: SwiftFlutterPiwikProPlugin.flutterSourceTrafficName)
        tracker?.sourceTrafficVesion = NSString(string: SwiftFlutterPiwikProPlugin.flutterSourceTrafficVersion)
        
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - configureTracker completed with parameters: baseURL: \(baseURL), siteId: \(siteId)")
    }
    
    private func handleTrackScreen(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let screenName = arguments?["screenName"] as? String
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "trackScreen failed", errorDetails: "Missing the screenName parameter"))
            return
        }
        tracker?.sendView(view: screenName)
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - trackScreen completed with parameters: screenName: \(screenName)")
    }
    
    private func handleSetAnonymizationState(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let shouldAnonymize = arguments?["shouldAnonymize"] as? Bool
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "setAnonymizationState failed", errorDetails: "Missing the shouldAnonymize parameter"))
            return
        }
        
        tracker?.isAnonymizationEnabled = shouldAnonymize
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - setAnonymization completed with parameters: shouldAnonymize: \(shouldAnonymize)")
    }
    
    private func handleTrackCustomEvent(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let category = arguments?["category"] as? String,
              let action = arguments?["action"] as? String
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "trackCustomEvent failed", errorDetails: "Missing either category or action parameters"))
            return
        }
        let name = arguments?["name"] as? String
        let value = arguments?["value"] as? NSNumber
        let path = arguments?["path"] as? String
        
        tracker?.sendEvent(category: category, action: action, name: name, value: value, path: path)
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - trackCustomEvent completed with parameters: category: \(category), action: \(action), name: \(String(describing: name)), value: \(String(describing: value))")
    }
    
    private func handleTrackException(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let description = arguments?["description"] as? String
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "trackException failed",errorDetails: "Missing the description parameter"))
            return
        }
        let isFatal = arguments?["isFatal"] as? Bool ?? false
        
        tracker?.sendException(description: description, isFatal: isFatal)
        result("\(SwiftFlutterPiwikProPlugin.sdkName) -  trackException completed with parameters: description: \(description), isFatal: \(isFatal)")
    }
    
    private func handleTrackSocialInteraction(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let interaction = arguments?["interaction"] as? String,
              let network = arguments?["network"] as? String
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "trackSocialInteracion failed", errorDetails: "Missing either interaction or network parameters"))
            return
        }

        let target = arguments?["target"] as? String
        tracker?.sendSocialInteraction(action: interaction, target: target, network: network)
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - trackSocialInteraction completed with parameters: interaction: \(interaction), network: \(network), target: \(String(describing: target))")
    }
    
    private func handleTrackDownload(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let url = arguments?["url"] as? String
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "trackDownload failed", errorDetails: "Missing the url parameter"))
            return
        }
        tracker?.sendDownload(url: url)
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - trackDownload completed with parameters: url: \(url)")
    }
    
    private func handleTrackOutlink(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let url = arguments?["url"] as? String
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "trackOutlink failed", errorDetails: "Missing the url parameter"))
            return
        }
        tracker?.sendOutlink(url: url)
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - trackOutlink completed with parameters: url: \(url)")
    }
    
    private func handleTrackSearch(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let keyword = arguments?["keyword"] as? String
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "trackSearch failed", errorDetails: "Missing the keyword parameter"))
            return
        }
        let category = arguments?["category"] as? String
        let numberOfHits = arguments?["numberOfHits"] as? NSNumber
        tracker?.sendSearch(keyword: keyword, category: category, numberOfHits: numberOfHits)
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - trackSearch completed with parameters: keyword: \(keyword), category: \(String(describing: category)), numberOfHits: \(String(describing: numberOfHits))")
    }
    
    private func handleTrackAppInstall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        tracker?.sendApplicationDownload()
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - Track App Install event sent")
    }
    
    private func handleTrackContentImpression(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let contentName = arguments?["contentName"] as? String
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "trackContentImpression failed", errorDetails: "Missing the contentName parameter"))
            return
        }
        let piece = arguments?["piece"] as? String
        let target = arguments?["target"] as? String
        
        tracker?.sendContentImpression(name: contentName, piece: piece, target: target)
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - trackContentImpression completed with parameters: contentName: \(contentName), piece: \(String(describing: piece)), target: \(String(describing: target))")
    }
    
    private func handleTrackContentInteraction(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let contentName = arguments?["contentName"] as? String,
              let contentInteraction = arguments?["contentInteraction"] as? String
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "trackContentInteraction failed", errorDetails: "Missing one of the contentName parameter"))
            return
        }
        
        let piece = arguments?["piece"] as? String
        let target = arguments?["target"] as? String
        tracker?.sendContentInteraction(name: contentName, interaction: contentInteraction, piece: piece, target: target)
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - trackContentInteraction completed with parameters: contentName: \(contentName), piece: \(String(describing: piece)), target: \(String(describing: target)), contentInteraction: \(contentInteraction)")
    }
    
    private func handleTrackGoal(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let goal = arguments?["goal"] as? Int
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "trackGoal failed", errorDetails: "Missing the goal parameter"))
            return
        }
        guard goal >= 0 else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "trackGoal failed", errorDetails: "goal parameter has a negative value"))
            return
        }
        let revenue = arguments?["revenue"] as? NSNumber
        tracker?.sendGoal(ID: UInt(goal), revenue: revenue)
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - trackGoal completed with parameters: goal: \(goal), revenue: \(String(describing: revenue))")
    }
    
    private func handleTrackEcommerceTransaction(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let identifier = arguments?["identifier"] as? String,
              let grandTotal = arguments?["grandTotal"] as? NSNumber
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "trackEcommerceTransaction failed", errorDetails: "Missing either identifier or grandTotal parameters"))
            return
        }
        let subTotal = arguments?["subTotal"] as? NSNumber
        let tax = arguments?["tax"] as? NSNumber
        let shippingCost = arguments?["shippingCost"] as? NSNumber
        let discount = arguments?["discount"] as? NSNumber
        
        let transactionItems = arguments?["transactionItems"] as? NSArray
        
        tracker?.sendTransaction(transaction: PiwikTransaction(block: { builder in
            builder.identifier = identifier
            builder.grandTotal = grandTotal
            builder.subTotal = subTotal
            builder.tax = tax
            builder.shippingCost = shippingCost
            builder.discount = discount
            
            transactionItems?.forEach({ item in
                let item = item as! NSDictionary
                let sku = item["sku"] as! String
                let price = item["price"] as! NSNumber
                let quantity = item["quantity"] as! NSNumber
                let name = item["name"] as? String
                let category = item["category"] as? String

                builder.addItem(sku: sku, name: name, category: category, price: price, quantity: quantity)
            })
        })!)
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - trackEcommerceTransaction completed with parameters: identifier: \(identifier), grandTotal: \(String(describing: grandTotal)), subTotal: \(String(describing: subTotal)), tax: \(String(describing: tax)), shippingCost: \(String(describing: shippingCost)), discount: \(String(describing: discount)), transactionitems: \(String(describing: transactionItems))")
    }
    
    private func handleTrackCampaign(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let url = arguments?["url"] as? String
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "trackCampaign failed", errorDetails: "Missing the url parameter"))
            return
        }
        
        tracker?.sendCampaign(url: url)
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - trackCampaign completed with parameters: url: \(url)")
    }
    
    private func handleTrackCustomVariable(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let scope = arguments?["scope"] as? String,
              let index = arguments?["index"] as? Int,
              let name = arguments?["name"] as? String,
              let value = arguments?["value"] as? String
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "trackCustomVariable failed", errorDetails: "Missing at least one of the required parameters - scope, index, name or value"))
            return
        }
        var customVariableScope: CustomVariableScope?
        
        if scope == "action" {
            customVariableScope = CustomVariableScope.action
        }
        else if scope == "visit" {
            customVariableScope = CustomVariableScope.visit
        }
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "trackCustomVariable failed", errorDetails: "unknown type of scope: \(scope)"))
            return
        }
        
        guard index >= 0 else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "trackCustomVariable failed", errorDetails: "index can't have a negative value \(index)"))
            return
        }
        
        tracker?.setCustomVariable(index: UInt(index), name: name, value: value, scope: customVariableScope!)
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - trackCustomVariable completed with parameters: index: \(index), name: \(name), value: \(value), scope: \(scope)")
    }
    
    private func handleTrackCustomDimension(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let index = arguments?["index"] as? Int,
              let value = arguments?["value"] as? String
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "trackCustomDimension failed", errorDetails: "Missing at least one of the required parameters - id or value"))
            return
        }
        guard index >= 0 else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "trackCustomDimension failed", errorDetails: "index parameter has a negative value"))
            return
        }
        tracker?.setCustomDimension(identifier: UInt(index), value: value)
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - trackCustomDimension completed with parameters: index: \(String(describing: index)), value: \(value))")
    }
    
    private func handleTrackProfileAttribute(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let name = arguments?["name"] as? String,
              let value = arguments?["value"] as? String
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "trackProfileAttribute failed", errorDetails: "Missing at least one of the required parameters - name or value"))
            return
        }
        
        tracker?.sendAudienceManagerAttribute(name: name, value: value)
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - trackProfileAttribute completed with parameters: name: \(name), value: \(value)")
    }
    
    private func handleReadUserProfileAttributes(result: @escaping FlutterResult) {
        tracker?.audienceManagerGetProfileAttributes({ attributes, error in
            guard error == nil else {
                result(FlutterError.flutterPiwikSdkError(errorMessage: "readProfileAttributes failed", errorDetails: error!.localizedDescription))
                return
            }
            return result(attributes)
        })
    }
    
    private func handleCheckAudienceMembership(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let audienceId = arguments?["audienceId"] as? String
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "checkAudienceMembership failed", errorDetails: "Missing the required parameter: audienceId"))
            return
        }
        tracker?.checkMembership(withAudienceID: audienceId, completionBlock: { membershipResult, error in
            guard error == nil else {
                result(FlutterError.flutterPiwikSdkError(errorMessage: "checkAudienceMembership failed", errorDetails: error!.localizedDescription))
                return
            }
            result(membershipResult)
        })
    }
    
    private func handleSetUserId(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        let id = arguments?["id"] as? String
        
        tracker?.userID = id
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - setUserId completed with parameters: id: \(String(describing: id))")
    }
    
    private func handleSetUserEmail(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let email = arguments?["email"] as? String
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "setUserEmail failed", errorDetails: "Missing the required parameter: email"))
            return
        }
        
        tracker?.userEmail = email
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - setUserEmail completed with parameters: email: \(email)")
    }
    
    private func handleSetVisitorId(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let id = arguments?["id"] as? String
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "setVisitorId failed", errorDetails: "Missing the required parameter: id"))
            return
        }
        
        tracker?.setVisitorID(newVisitorID: id)
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - setVisitorId completed with parameters: id: \(id)")
    }
    
    private func handleSetSessionTimeout(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let timeoutInMilliseconds = arguments?["timeoutInMilliseconds"] as? Int
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "setUserEmail failed", errorDetails: "Missing the required parameter: email"))
            return
        }
        
        tracker?.sessionTimeout = Double(timeoutInMilliseconds) / 1000.0
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - setSessionTimeout completed with parameters: timeoutInMilliseconds: \(timeoutInMilliseconds)")
    }
    
    private func handleSetDispatchInterval(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let intervalInMilliseconds = arguments?["intervalInMilliseconds"] as? Int
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "setDispatchInterval failed", errorDetails: "Missing the required parameter: interval"))
            return
        }
        
        tracker?.dispatchInterval = Double(intervalInMilliseconds) / 1000.0
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - setDispatchInterval completed with parameters: intervalInMilliseconds: \(intervalInMilliseconds)")
    }
    
    private func handleDispatch(result: @escaping FlutterResult) {
        tracker?.dispatch()
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - dispatch completed")
    }
    
    private func handleSetIncludeDefaultVariables(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let shouldInclude = arguments?["shouldInclude"] as? Bool
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "setIncludeDefaultVariables failed", errorDetails: "Missing the required parameter: shouldInclude"))
            return
        }
        
        tracker?.includeDefaultCustomVariable = shouldInclude
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - setIncludeDefaultVariables completed with parameters: shouldInclude: \(shouldInclude)")
    }
    
    private func handleOptOut(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let shouldOptOut = arguments?["shouldOptOut"] as? Bool
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "optOut failed", errorDetails: "Missing the required parameter: shouldOptOut"))
            return
        }
        
        tracker?.optOut = shouldOptOut
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - optOut completed with parameters: shouldOptOut: \(shouldOptOut)")
    }
    
    private func handleDryRun(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? NSDictionary
        guard let shouldDryRun = arguments?["shouldDryRun"] as? Bool
        else {
            result(FlutterError.flutterPiwikSdkError(errorMessage: "dryRun failed", errorDetails: "Missing the required parameter: shouldDryRun"))
            return
        }
        
        tracker?.dryRun = shouldDryRun
        result("\(SwiftFlutterPiwikProPlugin.sdkName) - dryRun completed with parameters: shouldDryRun: \(shouldDryRun)")
    }
}

extension FlutterError {
    static func notInitializedError(errorMessage: String) -> FlutterError {
        return FlutterError(code: SwiftFlutterPiwikProPlugin.sdkName, message: errorMessage, details: "Tracker was not initialized")
    }
    
    static func flutterPiwikSdkError(errorMessage: String, errorDetails: String) -> FlutterError {
        return FlutterError(code: SwiftFlutterPiwikProPlugin.sdkName, message: errorMessage, details: errorDetails)
    }
}

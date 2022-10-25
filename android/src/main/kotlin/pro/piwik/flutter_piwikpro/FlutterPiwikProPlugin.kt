package pro.piwik.flutter_piwikpro

import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import pro.piwik.sdk.TrackerConfig
import pro.piwik.sdk.Piwik
import pro.piwik.sdk.Tracker
import pro.piwik.sdk.Tracker.OnCheckAudienceMembership
import pro.piwik.sdk.extra.EcommerceItems
import pro.piwik.sdk.extra.TrackHelper
import java.net.URL
import pro.piwik.sdk.Tracker.OnGetProfileAttributes
import pro.piwik.sdk.dispatcher.Packet
import java.util.*
import kotlin.collections.ArrayList

/** FlutterPiwikProPlugin */
class FlutterPiwikProPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var context: Context
    private lateinit var channel: MethodChannel
    private lateinit var tracker: Tracker
    private val configureTrackerName = "configure_Tracker"
    private val trackScreenName = "track_screen"
    private val setAnonymizationStateName = "set_anonymization_state"
    private val trackCustomEventName = "track_custom_event"
    private val trackExceptionName = "track_exception"
    private val trackSocialInteractionName = "track_social_interaction"
    private val trackDownloadName = "track_download"
    private val trackOutlinkName = "track_outlink"
    private val trackSearchName = "track_search"
    private val trackAppInstallName = "track_app_install"
    private val trackContentImpressionName = "track_content_impression"
    private val trackContentInteractionName = "track_content_interaction"
    private val trackGoalName = "track_goal"
    private val trackEcommerceTransactionName = "track_ecommerce_transaction"
    private val trackCampaignName = "track_campaign"
    private val trackCustomVariableName = "track_custom_variable"
    private val trackCustomDimensionName = "track_custom_dimension"
    private val trackProfileAttributeName = "track_profile_attribute"
    private val readUserProfileAttributesName = "read_user_profile_attributes"
    private val checkAudienceMembershipName = "check_audience_membership"
    private val setUserIdName = "set_user_id"
    private val setUserEmailName = "set_user_email"
    private val setVisitorIdName = "set_visitor_id"
    private val setSessionTimeoutName = "set_session_timeout"
    private val setDispatchIntervalName = "set_dispatch_interval"
    private val dispatchName = "dispatch"
    private val setIncludeDefaultVariablesName = "set_include_default_variables"
    private val optOutName = "opt_out"
    private val dryRunName = "dry_run"
    private val flutterTrafficSourceName = "Flutter"
    private val flutterTrafficSourceVersion = "0.0.1"

    private val sdkName = "FlutterPiwikPro"

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "piwik_flutter")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == configureTrackerName) {
            handleConfigureTracker(call, result)
            return
        } else if (!validateTracker()) {
            result.notInitializedError("${call.method} failed")
            return
        }

        when (call.method) {
            trackScreenName -> {
                handleTrackScreen(call, result)
            }
            setAnonymizationStateName -> {
                handleSetAnonymizationState(call, result)
            }
            trackCustomEventName -> {
                handleTrackCustomEvent(call, result)
            }
            trackExceptionName -> {
                handleTrackException(call, result)
            }
            trackSocialInteractionName -> {
                handleTrackSocialInteraction(call, result)
            }
            trackDownloadName -> {
                handleTrackDownload(call, result)
            }
            trackOutlinkName -> {
                handleTrackOutlink(call, result)
            }
            trackSearchName -> {
                handleTrackSearch(call, result)
            }
            trackAppInstallName -> {
                handleTrackAppInstall(result)
            }
            trackContentImpressionName -> {
                handleTrackContentImpression(call, result)
            }
            trackContentInteractionName -> {
                handleTrackContentInteraction(call, result)
            }
            trackGoalName -> {
                handleTrackGoal(call, result)
            }
            trackEcommerceTransactionName -> {
                handleTrackEcommerceTransaction(call, result)
            }
            trackCampaignName -> {
                handleTrackCampaign(call, result)
            }
            trackCustomVariableName -> {
                handleTrackCustomVariable(call, result)
            }
            trackCustomDimensionName -> {
                handleTrackCustomDimension(call, result)
            }
            trackProfileAttributeName -> {
                handleTrackProfileAttribute(call, result)
            }
            readUserProfileAttributesName -> {
                handleReadUserProfileAttributes(result)
            }
            checkAudienceMembershipName -> {
                handleCheckAudienceMembership(call, result)
            }
            setUserIdName -> {
                handleSetUserId(call, result)
            }
            setUserEmailName -> {
                handleSetUserEmail(call, result)
            }
            setVisitorIdName -> {
                handleSetVisitorId(call, result)
            }
            setSessionTimeoutName -> {
                handleSetSessionTimeout(call, result)
            }
            setDispatchIntervalName -> {
                handleSetDispatchInterval(call, result)
            }
            dispatchName -> {
                handleDispatch(result)
            }
            setIncludeDefaultVariablesName -> {
                handleSetIncludeDefaultVariables(call, result)
            }
            optOutName -> {
                handleOptOut(call, result)
            }
            dryRunName -> {
                handleDryRun(call, result)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun validateTracker(): Boolean {
        return this::tracker.isInitialized
    }

    private fun handleConfigureTracker(
        call: MethodCall,
        result: Result
    ) {
        val baseURL = call.argument<String>("baseURL")
        val siteId = call.argument<String>("siteId")
        if (baseURL != null && siteId != null && baseURL.isNotEmpty() && siteId.isNotEmpty()) {
            tracker = Piwik.getInstance(context).newTracker(
                TrackerConfig.createDefault(
                    baseURL,
                    siteId,
                )
            )
            tracker.trafficSourceName = flutterTrafficSourceName
            tracker.trafficSourceVersion = flutterTrafficSourceVersion
            result.success("$sdkName - configureTracker completed with parameters: baseURL: $baseURL, siteId: $siteId")
        } else {
            result.flutterPiwikSDKError(
                "configureTracker failed",
                "Missing either baseURL or siteId parameters"
            )
        }
    }

    private fun handleTrackScreen(call: MethodCall, result: Result) {
        val screenName = call.argument<String>("screenName")
        val title = call.argument<String>("title")
        if (screenName != null) {
            TrackHelper.track().screen(screenName).title(title).with(tracker)
            result.success("$sdkName - trackScreen completed with parameters: screenName: $screenName, title: $title")
        } else {
            result.flutterPiwikSDKError("trackScreen failed", "Missing the screenName parameter")
        }
    }

    private fun handleSetAnonymizationState(call: MethodCall, result: Result) {
        val shouldAnonymize = call.argument<Boolean>("shouldAnonymize")
        if (shouldAnonymize != null) {
            tracker.setAnonymizationState(shouldAnonymize)
            result.success("$sdkName - setAnonymizationState completed with parameters: shouldAnonymize $shouldAnonymize")
        } else {
            result.flutterPiwikSDKError(
                "setAnonymizationState failed",
                "Missing the shouldAnonymize parameter"
            )
        }
    }

    private fun handleTrackCustomEvent(call: MethodCall, result: Result) {
        val category = call.argument<String>("category")
        val action = call.argument<String>("action")
        val name = call.argument<String>("name")
        val value = call.argument<Double>("value")?.toFloat()
        val path = call.argument<String>("path")

        if (category != null && action != null) {
            TrackHelper.track().event(category, action).path(path).name(name).value(value)
                .with(tracker)
            result.success("$sdkName - trackCustomEvent completed with parameters: category: $category, action: $action, name: $name, value: $value, path: $path")
        } else {
            result.flutterPiwikSDKError(
                "trackCustomEvent failed",
                "Missing either category or action parameters"
            )
        }
    }

    private fun handleTrackException(call: MethodCall, result: Result) {
        val isFatal = call.argument<Boolean>("isFatal")
        val description = call.argument<String>("description")

        TrackHelper.track().exception().description(description).fatal(isFatal ?: false)
            .with(tracker)
        result.success("$sdkName - trackException completed with parameters: isFatal: $isFatal, description: $description")
    }

    private fun handleTrackSocialInteraction(call: MethodCall, result: Result) {
        val interaction = call.argument<String>("interaction")
        val network = call.argument<String>("network")
        if (network != null && interaction != null) {
            val target = call.argument<String>("target")
            TrackHelper.track().socialInteraction(interaction, network).target(target)
                .with(tracker)
            result.success("$sdkName - trackSocialInteraction completed with parameters: interaction: $interaction, network: $network, target: $target")
        } else {
            result.flutterPiwikSDKError(
                "trackSocialInteraction failed",
                "Missing either network or interaction parameters"
            )
        }
    }

    private fun handleTrackDownload(call: MethodCall, result: Result) {
        val url = call.argument<String>("url")
        if (url != null) {
            TrackHelper.track().sendDownload(url).with(tracker)
            result.success("$sdkName - trackDownload completed with parameters: url: $url")
        } else {
            result.flutterPiwikSDKError("trackDownload failed", "Missing the url parameter")
        }
    }

    private fun handleTrackOutlink(call: MethodCall, result: Result) {
        val url = call.argument<String>("url")
        if (url != null) {
            TrackHelper.track().outlink(URL(url)).with(tracker)
            result.success("$sdkName - trackOutlink completed with parameters: url: $url")
        } else {
            result.flutterPiwikSDKError("trackOutlink failed", "Missing the url parameter")
        }
    }

    private fun handleTrackSearch(call: MethodCall, result: Result) {
        val keyword = call.argument<String>("keyword")
        if (keyword != null) {
            val category = call.argument<String>("category")
            val numberOfHits = call.argument<Int>("numberOfHits")
            TrackHelper.track().search(keyword).category(category).count(numberOfHits)
                .with(tracker)
            result.success("$sdkName - trackSearch completed with parameters: keyword: $keyword, category: $category, numberOfHits: $numberOfHits")
        } else {
            result.flutterPiwikSDKError("trackSearch failed", "Missing the keyword parameter")
        }
    }

    private fun handleTrackAppInstall(result: Result) {
        TrackHelper.track().sendApplicationDownload().with(tracker)
        result.success("$sdkName - trackAppInstall completed ")
    }

    private fun handleTrackContentImpression(call: MethodCall, result: Result) {
        val contentName = call.argument<String>("contentName")
        if (contentName != null) {
            val piece = call.argument<String>("piece")
            val target = call.argument<String>("target")

            TrackHelper.track().impression(contentName).piece(piece).target(target).with(tracker)
            result.success("$sdkName - trackContentImpression completed with parameters: contentName: $contentName, piece: $piece, target: $target")
        } else {
            result.flutterPiwikSDKError(
                "trackContentImpression failed",
                "Missing the contentName parameter"
            )
        }
    }

    private fun handleTrackContentInteraction(call: MethodCall, result: Result) {
        val contentName = call.argument<String>("contentName")
        val contentInteraction = call.argument<String>("contentInteraction")
        if (contentName != null && contentInteraction != null) {
            val piece = call.argument<String>("piece")
            val target = call.argument<String>("target")

            TrackHelper.track().interaction(contentName, contentInteraction).piece(piece)
                .target(target).with(tracker)
            result.success("$sdkName - trackContentInteraction completed with parameters: contentName: $contentName, piece: $piece, target: $target, contentInteraction: $contentInteraction")
        } else {
            result.flutterPiwikSDKError(
                "trackContentInteraction failed",
                "Missing either contentName or contentInteraction parameters"
            )
        }
    }

    private fun handleTrackGoal(call: MethodCall, result: Result) {
        val goal = call.argument<Int>("goal")
        if (goal != null) {
            if (goal < 0) {
                result.flutterPiwikSDKError(
                    "trackGoal failed",
                    "goal parameter has a negative value"
                )
                return
            }
            val revenue = call.argument<Double>("revenue")?.toFloat()
            TrackHelper.track().goal(goal).revenue(revenue).with(tracker)
            result.success("$sdkName - trackGoal completed with parameters: goal: $goal, revenue: $revenue")
        } else {
            result.flutterPiwikSDKError(
                "trackGoal failed",
                "Missing the goal parameter"
            )
        }
    }

    private fun handleTrackEcommerceTransaction(
        call: MethodCall,
        result: Result
    ) {
        val identifier = call.argument<String>("identifier")
        val grandTotal = call.argument<Int>("grandTotal")
        if (identifier != null && grandTotal != null) {
            val subTotal = call.argument<Int>("subTotal")
            val tax = call.argument<Int>("tax")
            val shippingCost = call.argument<Int>("shippingCost")
            val discount = call.argument<Int>("discount")
            val transactionItems = call.argument<List<Map<String, Any>>>("transactionItems")

            val ecommerceItems = EcommerceItems()
            transactionItems?.forEach {
                val sku = it["sku"] as String
                val name = it["name"] as? String
                val category = it["category"] as? String
                val price = it["price"] as Int
                val quantity = it["quantity"] as Int
                val ecommerceItem =
                    EcommerceItems.Item(sku).name(name).category(category).price(price)
                        .quantity(quantity)
                ecommerceItems.addItem(ecommerceItem)
            }
            TrackHelper.track().order(identifier, grandTotal).subTotal(subTotal).tax(tax)
                .shipping(shippingCost)
                .discount(discount).items(ecommerceItems).with(tracker)
            result.success("$sdkName - trackEcommerceTransaction completed with parameters: identifier: $identifier, grandTotal: $grandTotal, subTotal: $subTotal, tax: $tax, shippingCost: $shippingCost, discount: $discount, transactionItems: $transactionItems")
        } else {
            result.flutterPiwikSDKError(
                "trackEcommerceTransaction failed",
                "Missing either identifier or grandTotal parameters"
            )
        }
    }

    private fun handleTrackCampaign(
        call: MethodCall, result: Result
    ) {
        val url = call.argument<String>("url")
        if (url != null) {
            TrackHelper.track()
                .campaign(URL(url))
                .with(tracker)
            result.success("$sdkName - trackCampaign completed with parameters: url: $url")
        } else {
            result.flutterPiwikSDKError(
                "trackCampaign failed",
                "Missing the url parameter"
            )
        }
    }

    private fun handleTrackCustomVariable(call: MethodCall, result: Result) {
        val index = call.argument<Int>("index")
        val name = call.argument<String>("name")
        val value = call.argument<String>("value")
        val scope = call.argument<String>("scope")
        if (index != null && name != null && value != null && scope != null) {
            when (scope) {
                "action" -> {
                    TrackHelper.track().variable(index, name, value)
                    result.success("$sdkName - trackCustomVariable completed with parameters: index: $index, name: $name, value: $value, scope: $scope")
                }
                "visit" -> {
                    TrackHelper.track().visitVariables(index, name, value)
                    result.success("$sdkName - trackCustomVariable completed with parameters: index: $index, name: $name, value: $value, scope: $scope")
                }
                else -> {
                    result.flutterPiwikSDKError(
                        "trackCustomVariable failed",
                        "scope parameter must have a value of `visit` or `action`"
                    )
                }
            }
        } else {
            result.flutterPiwikSDKError(
                "trackCustomVariable failed",
                "Missing at least one of the required parameters: index, name, value or scope"
            )
        }
    }

    private fun handleTrackCustomDimension(call: MethodCall, result: Result) {
        val index = call.argument<Int>("index")
        val value = call.argument<String>("value")
        if (index != null && value != null) {
            TrackHelper.track().dimension(index, value)
            result.success("$sdkName - trackCustomDimension completed with parameters: index: $index, value: $value")
        } else {
            result.flutterPiwikSDKError(
                "trackCustomDimension failed",
                "Missing at least one of the required parameters: index or value"
            )
        }
    }

    private fun handleTrackProfileAttribute(call: MethodCall, result: Result) {
        val name = call.argument<String>("name")
        val value = call.argument<String>("value")
        if (name != null && value != null) {
            TrackHelper.track().audienceManagerSetProfileAttribute(name, value).with(tracker)
            result.success("$sdkName - trackProfileAttribute completed with parameters: name: $name, value: $value")
        } else {
            result.flutterPiwikSDKError(
                "trackProfileAttribute failed",
                "Missing at least one of the required parameters: name or value"
            )
        }
    }

    private fun handleReadUserProfileAttributes(result: Result) {
        tracker
            .audienceManagerGetProfileAttributes(object : OnGetProfileAttributes {
                override fun onAttributesReceived(attributes: Map<String, String>) {
                    result.success(attributes)
                }

                override fun onError(errorData: String) {
                    result.flutterPiwikSDKError("trackProfileAttribute failed", errorData)
                }
            })
    }

    private fun handleCheckAudienceMembership(call: MethodCall, result: Result) {
        val audienceId = call.argument<String>("audienceId")
        if (audienceId != null) {
            tracker
                .checkAudienceMembership(audienceId, object : OnCheckAudienceMembership {
                    override fun onChecked(isMember: Boolean) {
                        result.success(isMember)
                    }

                    override fun onError(errorData: String) {
                        result.flutterPiwikSDKError("trackProfileAttribute failed", errorData)
                    }
                })
        } else {
            result.flutterPiwikSDKError(
                "trackProfileAttribute failed",
                "Missing the required parameter: audienceId"
            )
        }
    }

    private fun handleSetUserId(call: MethodCall, result: Result) {
        val id = call.argument<String>("id")
        tracker.userId = id
        result.success("$sdkName - setUserId completed with parameters: id: $id")
    }

    private fun handleSetUserEmail(call: MethodCall, result: Result) {
        val email = call.argument<String>("email")
        if (email != null) {
            tracker.userMail = email
            result.success("$sdkName - setUserEmail completed with parameters: email: $email")
        } else {
            result.flutterPiwikSDKError(
                "setUserEmail failed",
                "Missing the required parameter: email"
            )
        }
    }

    private fun handleSetVisitorId(call: MethodCall, result: Result) {
        val id = call.argument<String>("id")
        if (id != null) {
            tracker.visitorId = id
            result.success("$sdkName - setVisitorId completed with parameters: id: $id")
        } else {
            result.flutterPiwikSDKError(
                "setVisitorId failed",
                "Missing the required parameter: id"
            )
        }
    }

    private fun handleSetSessionTimeout(call: MethodCall, result: Result) {
        val timeoutInMilliseconds = call.argument<Int>("timeoutInMilliseconds")
        if (timeoutInMilliseconds != null) {
            tracker.setSessionTimeout(timeoutInMilliseconds)
            result.success("$sdkName - setSessionTimeout completed with parameters: timeoutInMilliseconds: $timeoutInMilliseconds")
        } else {
            result.flutterPiwikSDKError(
                "setSessionTimeout failed",
                "Missing the required parameter: timeout"
            )
        }
    }

    private fun handleSetDispatchInterval(call: MethodCall, result: Result) {
        val intervalInMilliseconds = call.argument<Int>("intervalInMilliseconds")
        if (intervalInMilliseconds != null) {
            tracker.setSessionTimeout(intervalInMilliseconds)
            result.success("$sdkName - setDispatchInterval completed with parameters: intervalInMilliseconds: $intervalInMilliseconds")
        } else {
            result.flutterPiwikSDKError(
                "setDispatchInterval failed",
                "Missing the required parameter: interval"
            )
        }
    }

    private fun handleDispatch(result: Result) {
        tracker.dispatch()
        result.success("$sdkName - dispatch completed")
    }

    private fun handleSetIncludeDefaultVariables(call: MethodCall, result: Result) {
        val shouldInclude = call.argument<Boolean>("shouldInclude")
        if (shouldInclude != null) {
            tracker.includeDefaultCustomVars = shouldInclude
            result.success("$sdkName - setIncludeDefaultVariables completed with parameters: shouldInclude: $shouldInclude")
        } else {
            result.flutterPiwikSDKError(
                "setIncludeDefaultVariables failed",
                "Missing the required parameter: shouldInclude"
            )
        }
    }

    private fun handleOptOut(call: MethodCall, result: Result) {
        val shouldOptOut = call.argument<Boolean>("shouldOptOut")
        if (shouldOptOut != null) {
            tracker.isOptOut = shouldOptOut
            result.success("$sdkName - optOut completed with parameters: shouldOptOut: $shouldOptOut")
        } else {
            result.flutterPiwikSDKError(
                "optOut failed",
                "Missing the required parameter: shouldOptOut"
            )
        }
    }

    private fun handleDryRun(call: MethodCall, result: Result) {
        val shouldDryRun = call.argument<Boolean>("shouldDryRun")
        if (shouldDryRun != null) {
            tracker.dryRunTarget =
                if (shouldDryRun) Collections.synchronizedList(ArrayList<Packet>()) else null
            result.success("$sdkName - dryRun completed with parameters: shouldDryRun: $shouldDryRun")
        } else {
            result.flutterPiwikSDKError(
                "dryRun failed",
                "Missing the required parameter: shouldDryRun"
            )
        }
    }

    private fun Result.notInitializedError(errorMessage: String) {
        error(
            sdkName,
            errorMessage,
            "Tracker was not configured"
        )
    }

    private fun Result.flutterPiwikSDKError(errorMessage: String, errorDetails: String) {
        error(
            sdkName,
            errorMessage,
            errorDetails
        )
    }
}

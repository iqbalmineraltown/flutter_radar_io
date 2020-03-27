package com.iqbalmineraltown.flutter_radar_io

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.radar.sdk.Radar
import io.radar.sdk.Radar.RadarTrackingOffline
import io.radar.sdk.Radar.RadarTrackingPriority
import io.radar.sdk.Radar.RadarTrackingSync
import io.radar.sdk.RadarTrackingOptions
import org.json.JSONObject


/** FlutterRadarIoPlugin */
public class FlutterRadarIoPlugin: FlutterPlugin, MethodCallHandler {
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_radar_io")
    channel.setMethodCallHandler(FlutterRadarIoPlugin());
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_radar_io")
      channel.setMethodCallHandler(FlutterRadarIoPlugin())
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

    when(call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "initialize" -> {
        val key = call.argument<String>("publishableKey")
        initialize(key!!)
      }
      "setUserId" -> {
        val userId = call.argument<String>("userId")
        setUserId(userId!!)
      }
      "setMetadata" -> {
        val metadata = call.argument<HashMap<Any,Any>>("metadata")
        setMetadata(metadata!!)
      }
      "setDescription" -> {
        val description = call.argument<String>("description")
        setDescription(description!!)
      }
      "startBackgroundTracking" -> {
        startBackgroundTracking()
      }
      "stopBackgroundTracking" -> {
        stopBackgroundTracking()
      }
      "isBackgroundTracking" -> {
        result.success(isBackgroundTracking())
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun initialize(key: String) {
    Radar.initialize(key)
  }

  private fun setUserId(userId: String) {
    Radar.userId = userId
  }

  private fun setMetadata(metadata: HashMap<Any,Any>) {
    val data = JSONObject(metadata)
    Radar.metadata = data
  }

  private fun setDescription(description: String) {
    Radar.description = description
  }

  private fun startBackgroundTracking(){
    val trackingOptions = RadarTrackingOptions.Builder()
            .priority(RadarTrackingPriority.RESPONSIVENESS) // use EFFICIENCY instead to reduce location update frequency
            .offline(RadarTrackingOffline.REPLAY_STOPPED) // use REPLAY_OFF instead to disable offline replay
            .sync(RadarTrackingSync.POSSIBLE_STATE_CHANGES) // use ALL instead to sync all location updates
            .build()

    Radar.startTracking(trackingOptions)
  }

  private fun stopBackgroundTracking() {
      Radar.stopTracking()
  }

  private fun isBackgroundTracking() : Boolean {
    return Radar.isTracking()
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
  }
}

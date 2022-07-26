package com.gaurav.firebase_cloud_messaging

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin


//class Application : FlutterApplication(),PluginRegistry.PluginRegistrantCallback {
//
//    override fun onCreate() {
//        super.onCreate()
//        FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this);
//    }
//
//    override fun registerWith(registry: PluginRegistry?) {
//        FirebaseCloudMessagingPlugin.registerWith(registry!!)
//    }
//}


class Application() : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {
    override fun registerWith(registry: PluginRegistry?) {
        val key: String? = FlutterFirebaseMessagingPlugin::class.java.canonicalName
        if (!registry?.hasPlugin(key)!!) {
        }
    }
}
package com.quansoft.url_player


import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    private var methodChannel: MethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "intent_channel")

        methodChannel?.setMethodCallHandler { call, result ->
            if (call.method == "getIntentData") {
                val streams = intent.getStringExtra("streams") ?: "[]"
                result.success(mapOf("streams" to streams))
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)

        val streams = intent.getStringExtra("streams") ?: "[]"
        methodChannel?.invokeMethod("newIntentReceived", mapOf("streams" to streams))
    }
}

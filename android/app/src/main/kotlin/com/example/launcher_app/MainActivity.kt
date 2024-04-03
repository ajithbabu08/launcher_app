package com.example.launcher_app

import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import android.app.Activity


class MainActivity : FlutterActivity() {

    private val CHANNEL = "launcher_settings"



    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "openSettings" -> {
                    val launcher = call.argument<String>("launcher")
                    if (launcher == "fl_live_launcher") {
                        openWelcomeScreen()
                    } else {
                        openLauncher()
                    }
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == LAUNCHER_SELECTION_REQUEST_CODE && resultCode == Activity.RESULT_OK) {
            // Get the launcher selected from the intent
            val launcher = data?.getStringExtra("launcher")
            if (launcher == "fl_live_launcher") {
                // If fl_live_launcher was selected, send a method call to Flutter to trigger application retrieval
                val channel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, "launcher_settings")
                channel.invokeMethod("retrieveApplications", null)
            }
        }
    }


    private fun openWelcomeScreen() {
        val intent = Intent(this, WelcomeActivity::class.java)
        intent.putExtra("launcher", "fl_live_launcher")
        startActivityForResult(intent, LAUNCHER_SELECTION_REQUEST_CODE)
    }

    // Define a constant for the request code
    private val LAUNCHER_SELECTION_REQUEST_CODE = 123


    private fun openLauncher() {
        val intent = Intent(android.provider.Settings.ACTION_HOME_SETTINGS)
        startActivity(intent)
    }
}


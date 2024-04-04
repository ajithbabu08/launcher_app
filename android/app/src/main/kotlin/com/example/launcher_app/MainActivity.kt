package com.example.launcher_app

import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.pm.PackageManager
import com.example.launcher_app.InstalledAppsActivity




class MainActivity : FlutterActivity() {

    private val CHANNEL = "launcher_settings"



   override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)

    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
        when (call.method) {
            "openSettings" -> {
                val launcher = call.argument<String>("launcher")
                if (launcher == "fl_live_launcher") {
                    openInstalledApps()
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



private fun openInstalledApps() {
    val packageManager = packageManager

    val apps = packageManager.getInstalledApplications(PackageManager.GET_META_DATA)
    val packageNames = apps.map { app -> app.packageName }

    val intent = Intent(this, InstalledAppsActivity::class.java)
    intent.putStringArrayListExtra("packageNames", ArrayList<String>(packageNames))
    startActivity(intent)
}




    private fun openLauncher() {
        val intent = Intent(android.provider.Settings.ACTION_HOME_SETTINGS)
        startActivity(intent)
    }
}


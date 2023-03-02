package com.example.test_plugin

import android.content.Context
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraManager
import android.os.Build
import android.os.Bundle
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.flutter.epic/epic"
    var flashLightStatus: Boolean = false
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if(call.method == "Printy") {
                result.success("Hello from the Kotlin World")
            }
            if(call.method == "TurnFlashLightOn") {
                openFlashLight()
            }
        }
    }
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    private fun openFlashLight() {
        val cameraManager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
        val cameraId = cameraManager.cameraIdList[0]
        if (!flashLightStatus) {
            try {
                cameraManager.setTorchMode(cameraId, true)
                flashLightStatus = true

            } catch (e: CameraAccessException) {
            }
        } else {
            try {
                cameraManager.setTorchMode(cameraId, false)
                flashLightStatus = false
            } catch (e: CameraAccessException) {
            }
        }

    }
}

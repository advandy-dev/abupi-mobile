# Keep Flutter engine/embedding
-keep class io.flutter.** { *; }
-dontwarn io.flutter.embedding.**

# Suppress missing Android 14 predictive-back types
-dontwarn android.window.BackEvent
-dontwarn android.window.BackNavigationEvent
-dontwarn android.window.PredictiveBack
-dontwarn android.window.OnBackInvokedCallback
-dontwarn android.window.OnBackInvokedDispatcher

# (Optional) keep any android.window types so R8 won't remove references it expects
-keep class android.window.** { *; }
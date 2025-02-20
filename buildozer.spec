[app]
title = MyApp
package.name = myapp
package.domain = org.example
source.dir = .
source.include_exts = py,png,jpg,kv,atlas

requirements = python3,kivy
orientation = portrait
fullscreen = 0
version = 1.0.0

[buildozer]
log_level = 2
warn_on_root = 1

[app_android]
android.api = 33
android.ndk = 23b
android.build_tools_version = 33.0.2
android.minapi = 21

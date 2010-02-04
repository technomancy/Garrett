# Garrett

Garrett is a playground for Duby exploration on Android.

## Compilation

Copy local.properties.example to local.properties and edit it to point
to your SDK. If you're not targeting Android 2.1, you might need to
edit default.properties too.

You'll need [Duby](http://github.com/headius/duby) checked out,
compiled, and on your path. At the time of this writing, the
"super_fixes" branch must be used.

Then you should be set to do "ant debug", and an .apk file should be
generated in the bin/ directory. You should then be able to install it
using "adb install" or by putting it on a public web server and
navigating to that URL from your device.

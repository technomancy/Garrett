# Garrett

Garrett is a playground for Mirah exploration on Android.

Garrett is named after Garrett P. Serviss, the hero of Edison's
Conquest of Mars, a ridiculous late 19th-century space opera novel by
Garrett P. Serviss.

## Compilation

Copy local.properties.example to local.properties and edit it to point
to your SDK. If you're not targeting Android 2.1, you might need to
edit default.properties too.

You'll need [Mirah](http://github.com/headius/mirah) checked out
and compiled with bin/mirahc on your path.

Then you should be set to do "ant debug", and an .apk file should be
generated in the bin/ directory. You should then be able to install it
using "adb install" or by putting it on a public web server and
navigating to that URL from your device.

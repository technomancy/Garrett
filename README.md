# Garrett

Garrett is an example application for Mirah development on Android.

Garrett is named after Garrett P. Serviss, the hero of Edison's
Conquest of Mars, a ridiculous late 19th-century space opera novel by
Garrett P. Serviss.

## Compilation

Install [JRuby](http://jruby.org) and then
[pindah](http://github.com/mirah/pindah). If your gem and rake are not
from from JRuby, prefix the commands with jruby -S:

    $ gem install pindah

Then you should be able to build the apk with rake:

    $ rake debug
    
This places <tt>Garrett-debug.apk</tt> in the <tt>bin/</tt>
directory. You can install it to a connected device or emulator with
<tt>rake install</tt> or distribute for HTTP download or whatever.

## License

Released under the Apache 2.0 license.

Copyright (C) 2010-2011 Phil Hagelberg, Charles Nutter

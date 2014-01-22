bloatmap
========

A one-script tool to visualise what is causing bloat in your binaries and
libraries.

The idea for this was from [bloat-blame](https://github.com/wmanley/bloat-blame)
but for now this is a meta-project using the [bloat](https://github.com/martine/bloat)
and [webtreemap](https://github.com/martine/webtreemap) tools, where all the
clever work is done.

Getting Started
---------------

If you're on a relatively recent version of git (~1.7+), you can get going
like this:

    git clone --recursive https://github.com/darrengarvey/bloatmap.git
    cd bloatmap
    ./bloat.sh /path/to/binary/or/library

If you're on an old version of git, you won't be able to run
`git clone --recursive`. Instead you should:

    git clone https://github.com/darrengarvey/bloatmap.git
    cd bloatmap
    git submodule init
    git submodule update
    ./bloat.sh /path/to/binary/or/library

The bash script `bloat.sh` creates a webpage that'll show what objects are
using space in your binaries or libraries and opens the webpage in the
browser of your choice. It uses `xdg-open` which should use your system-wide
default viewer for html files.

A sample of the output is below. Clicking on individual boxes drills into
that box to give a better view.

![alt tag](https://raw.github.com/darrengarvey/bloatmap/master/example/images/boost_date_time_1_49_0.png)
![alt tag](https://raw.github.com/darrengarvey/bloatmap/master/example/images/boost_regex_1_49_0.png)

Supported Platforms
-------------------

This has been tested on various Linux distributions. It's not been explicitly
tested on Windows, but it may Just Work in a cygwin or git-bash shell. Note
that the binutils tool `nm` and `objdump` are needed.

TODO
----

- Use addr2line as in [bloat-blame](https://github.com/wmanley/bloat-blame) to
  give more detail about where in source code the symbols come from.


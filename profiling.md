Motivation
----------
In order to make Calabash run faster
I want to figure out what's taking the most time
So I can prioritize where I do performance improvement work

Install sweet tool to navigate profile data

    brew install qcachegrind --with-graphviz

Run cucumbers, modified to output code profiles.
See https://github.com/ruby-prof/ruby-prof for how you might do this.

    BRIAR_PROFILE_CALABASH=1 be cucumber

Then analyze the profiling data

    qcachegring profile.grind.dat

There are a lot of ways to view this data, and getting value of it
depends on your application.

Analysis
--------

90% of our test suite run time is in "Kernel#sleep". So what calls
Kernel.sleep?
 % inside | call count | method name                              | notes
----------+------------+------------------------------------------+------
20.44%    | 33303      | IO#gets                                  | talking to calabash server?
12.44%    | 246        | RunLoop::ProcessWaiter#wait_for_any      | overlapping with launch_simulator?
10.32%    | 1031       | Calabash::Cucumber::WaitHelpers#wait_for | used by all(?) calabash steps. not surprised that it's expensive
 4.76%    | 3955       | Kernel#\`                                | I think this is shell exec
 8.01%    | 374        | Briar::Core#step\_pause                  | I'm sure this has been carefully calibrated, right?
 5.22%    | 123        | RunLoop::Simctl::Bridge#launch_simulator | can we avoid launching the simulator every scenario?
 5.71%    | 244        | RunLoop::SimControl#quit_sim             | Why is this is called twice as often as launch_simulator?
 3.62%    | 123        | RunLoop::ProcessTerminator#kill_process  | This seems to be orthagonal to quit_sim. What is it?
 0.34%    | 8          | Briar::Table#touch_row                   | Large cost given the few times it's called.


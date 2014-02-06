## Briar

an iPad/iPhone to test and demonstrate the features of the briar gem:

https://github.com/jmoody/briar

briar extends the calabash-ios gem.

### motivation

#### DRY

i have several iOS projects that use calabash-cucumber and i found i was rewriting lots of steps and supporting code.

#### Testing

i want to provide an iOS app that the calabash community can use to test the calabash framework. 

a while back, i tried to port the calabash-ios-server to ARC to fix a leak that was causing one of my tests to occasionally crash.  i did my conversion and realized there was no way to see if my changes broke calabash; there was no app that comprehensively tested all the calabash features.

## License of Images

### Glyphish

some of images used are from [Glyphish.](http://www.glyphish.com/)

this is the license: http://www.glyphish.com/license.txt

i purchased these images.

please be nice - don't gank them.  

buy a copy of Glyphish for yourself.

### Recovery Warriors LLC

the emoticons are from [Recovery Warriors LLC.](http://www.recoverywarriors.org/)

please don't distribute them.

### Recipe Images

http://www.appcoda.com/ios-programming-uicollectionview-tutorial/
       
## How to Test

the default cucumber profile sets `NO_LAUNCH=1` which implies 'do not launch with instruments'.

```
# test against the simulator no launching
$ cd Briar/
$ cucumber
```

to test with `NO_LAUNCH=0` (launch with instruments)

```
# test agains the simulator - launch with Instruments (iOS 7) or sim_launcher (iOS 6)
$ cd Briar/
$ cucumber -p launch
```

### testing on devices

have a look at the `cucumber.yml` file to see how to test on devices.

```
$ cd Briar/
$ cucumber -p earp 
$ cucumber -p venus
$ cucumber -p neptune
$ cucumber -p neptune_launch
$ cucumber -p pluto
```

### calabash-ios console

open consoles using rake tasks

```
# simulator iOS 6
$ cd Briar/
$ rake sim6

# simulator iOS 7
$ cd Briar/
$ rake sim7
```

### changing the default simulator

```
$ cd Briar/
$ rake set_sim_ipad               # set the default simulator to the ipad (non retina)
$ rake set_sim_ipad_64            # set the default simulator to the ipad retina 64 bit
$ rake set_sim_ipad_r             # set the default simulator to the ipad retina
$ rake set_sim_iphone             # set the default simulator to the iphone 3.5in
$ rake set_sim_iphone_4in         # set the default simulator to the iphone 4in
$ rake set_sim_iphone_64          # set the default simulator to the iphone 4in 64bit
```

### testing on Xamarin Test Cloud

look at the `Briar/Rakefile` for details about how to use rake to submit tests to Xamarin Test Cloud.

### Tags

* `issue_*  ==> calabash github issue`
* `issues   ==> all calabash github issues`
* `fb_*     ==> internal fogbugz`
* `trello_* ==> xamarin trello`
* `@briar   ==> testing briar gem features`
* `@core    ==> calabash core`

```
$ rake tag_report
@backdoor
@bars
@briar
@buttons
@core
@date_picker
@email
@fb_168
@first_view
@flickering
@ipad_only
@issue_116
@issue_128
@issue_131
@issue_151
@issue_156
@issue_189
@issue_194
@issues
@keyboard
@no_launch
@rotation
@segmented_control
@sliders
@tabbar
@text_field
```





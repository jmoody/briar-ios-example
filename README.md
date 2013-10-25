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

### testing on Xamarin Test Cloud

not supported yet

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

## Status of Tests

* there is one test that expected to fail - `issue_132_txt_undefined_in_predefined_steps.feature:8`
* there are several pending steps around email compose views

- [x] iOS 6 iPhone 4S 
    - [report -- NO_LAUNCH=1](status/iOS6-4S-no-launch.html)
    - [report -- NO_LAUNCH=0](status/iOS6-4S-launch.html)
- [ ] iOS 7 iPhone 5C [swiping broken on iOS 7](https://github.com/calabash/calabash-ios/issues/230)
    - not tested (device unavailable)
- [x] iOS 5.1 iPad 1 [keyboard enter text cannot enter all characters](https://github.com/calabash/calabash-ios/issues/194)
    - [report -- NO_LAUNCH=1](status/iOS5-iPad1-no-launch.html)
    - `NO_LAUNCH=0` not supported on Xcode 5 + iOS 5
- [x] iOS 7.0 iPad 4  [swiping broken on iOS 7](https://github.com/calabash/calabash-ios/issues/230)
    - [report](status/i0S7-iPad4.html)
- [x] iOS Simulator
   - [x] iphone
       - [x] iOS 5
       - [x] iOS 6
       - [x] iOS 7
   - [x] ipad
       - [ ] iOS 5
       - [ ] iOS 6
       - [ ] iOS 7
       
## How to Test

the default cucumber profile sets `NO_LAUNCH=1` which implies 'do not launch with instruments'.

`$ bundle exec cucumber`

to test with `NO_LAUNCH=0` (launch with instruments)

`$ bundle exec cucumber -p launch`

### testing on devices

have a look at the cucumber.yml file to see how to test on devices.

### calabash-ios console

use the `*_console.sh` script to launch a calabash console. 

by default the consoles are configured for `iphone`.  to configure for `ipad`, just pass `ipad` as an argument

`$ 7-console.sh ipad`

### Tags

* `issue_* ==> calabash github issue`
* `issues  ==> all calabash github issues`
* `fb_*    ==> my private fogbugz`
* `@briar  ==> testing briar gem features`
* `@core   ==> calabash core`

```
$ bundle exec cucumber -d -f Cucumber::Formatter::ListTags
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





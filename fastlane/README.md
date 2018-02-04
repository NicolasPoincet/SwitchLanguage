fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
### deploy
```
fastlane deploy
```
Run before all lane

Deploy project
### deploy_develop
```
fastlane deploy_develop
```
Deployment for tests
### deploy_pod
```
fastlane deploy_pod
```
Deploy pod to Cocoapods
### new_project_version
```
fastlane new_project_version
```
Update project version to the new one

cmd: fastlane new_project_version version:"1.3.9"
### run_tests
```
fastlane run_tests
```
Called on error

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).

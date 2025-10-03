#!/bin/bash

killall Xcode

rm -rf ~/Library/Developer/Xcode/DerivedData/*

cd ~/Developer/wolt-ios-client
xcodegen

open ~/Developer/wolt-ios-client/WoltClient.xcodeproj

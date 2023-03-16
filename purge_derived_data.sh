#!/bin/bash

killall Xcode

rm -rf ~/Library/Developer/Xcode/DerivedData/*

open ~/Developer/wolt-ios-client/WoltClient.xcworkspace

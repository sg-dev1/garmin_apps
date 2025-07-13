//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application;
using Toybox.Timer;
using Toybox.Lang;


// This delegate handles input for the Menu pushed when the user
// hits the stop button
class NamasteMenuDelegate extends Ui.MenuInputDelegate {

    hidden var mController;
    hidden var mDeathTimer;

    // Constructor
    function initialize() {
        MenuInputDelegate.initialize();
        mController = Application.getApp().controller;

    }

    // Handle the menu input
    function onMenuItem(item) {
        if (item == :resume) {
            mController.start();
        } else if (item == :save) {
            mController.save();
        } else {
            mController.discard();
        }
    }


}
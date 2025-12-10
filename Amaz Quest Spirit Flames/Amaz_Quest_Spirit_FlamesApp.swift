//
//  Amaz_Quest_Spirit_FlamesApp.swift
//  Amaz Quest Spirit Flames

import SwiftUI

@main
struct Amaz_Quest_Spirit_FlamesApp: App {
    @UIApplicationDelegateAdaptor(AmazQuestAppDelegate.self) private var appDelegate
    var body: some Scene {
        WindowGroup {
            AmazQuestGameInitialView()
        }
    }
}

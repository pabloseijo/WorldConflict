//
//  AppDelegate.swift
//  WorldConflicts
//
//  Created by Pablo Seijo on 30/10/23.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusBar: NSStatusBar!
    var statusBarItem: NSStatusItem!
    var menu: NSMenu!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Crear un ícono en la barra de menús
        statusBar = NSStatusBar.system
        
        statusBarItem = statusBar.statusItem(withLength: NSStatusItem.variableLength)
        statusBarItem.button?.title = "🌍" // Puedes poner un ícono o texto
        
        // Crear un menú desplegable para el ícono
        menu = NSMenu(title: "World Conflicts")
        menu.addItem(withTitle: "Open", action: #selector(openApp), keyEquivalent: "o")
        menu.addItem(NSMenuItem.separator())
        menu.addItem(withTitle: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        
        statusBarItem.menu = menu
    }
    
    @objc func openApp() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        if let windowController = storyboard.instantiateController(withIdentifier: "MapWindowController") as? NSWindowController {
            windowController.showWindow(self)
        }
        
    }
}



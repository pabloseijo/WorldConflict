//
//  ViewController.swift
//  WorldConflicts
//
//  Created by Pablo Seijo on 30/10/23.
//

import Cocoa
import WebKit

class ViewController: NSViewController {
    
    // Reference to the NSImageView used to display the map
    @IBOutlet weak var mapView: NSImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Assume there's a function to retrieve active conflict points
        let conflicts = getActiveConflicts()
        for conflict in conflicts {
            // Add each conflict to the map view
            addConflictToMap(conflict)
        }
    }
    
    func getActiveConflicts() -> [Conflict] {
        // This function should return a list of conflicts.
        // A conflict might be a structure with coordinates and details.
        // For now, we'll just return a predefined list.
        
        let conflict1 = Conflict(x: 500, y: 800, details: "Conflict in Location A")
        let conflict2 = Conflict(x: 800, y: 1000, details: "Conflict in Location B")
        
        return [conflict1, conflict2]
    }
    
    func addConflictToMap(_ conflict: Conflict) {
        // Ensure the mapView has an image to work with
        guard let image = mapView.image else { return }
        
        // Get the size of the image and the size of the imageView's bounds
        let imageSize = image.size
        let viewSize = mapView.bounds.size
        
        // Determine the scaling factor for the image
        let xScale = viewSize.width / imageSize.width
        let yScale = viewSize.height / imageSize.height
        
        let conflictSize: CGFloat = 5.0  // Size of the conflict marker
        
        // Adjust the conflict's coordinates based on the scaled image
        let posX = conflict.x * xScale
        let posY = conflict.y * yScale
        
        // Create a view to represent the conflict point on the map
        let conflictView = NSView(frame: CGRect(x: posX - conflictSize/2, y: posY - conflictSize/2, width: conflictSize, height: conflictSize))
        conflictView.wantsLayer = true
        conflictView.layer?.backgroundColor = NSColor.red.cgColor
        conflictView.layer?.cornerRadius = conflictSize / 2  // Makes the view a circle
        
        // Add a click gesture recognizer to the view to display conflict details when clicked
        let tapGesture = NSClickGestureRecognizer(target: self, action: #selector(showDetails(_:)))
        conflictView.addGestureRecognizer(tapGesture)
        
        // Assign conflict details to the view for future use
        conflictView.identifier = NSUserInterfaceItemIdentifier(conflict.details)
        
        // Add the conflict view to the mapView
        mapView.addSubview(conflictView)
    }

    @objc func showDetails(_ sender: NSClickGestureRecognizer) {
        // Show conflict details when the conflict marker is clicked
        if let view = sender.view {
            let details = view.identifier?.rawValue ?? ""
            // Here, you can display details using an NSPopover or any other method
            print(details)
        }
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view if it's already loaded
        }
    }
}

// Struct to represent a conflict, with coordinates and details
struct Conflict {
    var x: CGFloat  // X coordinate of the conflict
    var y: CGFloat  // Y coordinate of the conflict
    var details: String  // Details about the conflict
}

//
//  MainArView.swift
//  Decorator
//
//  Created by verebes on 31/12/2020.
//

import ARKit
import RealityKit
import UIKit

final class MainARView: ARView, ARSessionDelegate/*, UIGestureRecognizerDelegate*/ {
    
    enum PaintColor {
        case red, blue
    }
    
    var selectedPaintColor: PaintColor = .red
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        configureSession()
        addTapToPaintGesture()
    }
    
    @objc required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    func configureSession() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.sceneReconstruction = .meshWithClassification
        configuration.environmentTexturing = .automatic
        configuration.planeDetection = .vertical
        
        environment.sceneUnderstanding.options = []
        environment.sceneUnderstanding.options.insert(.occlusion)
        // Display a debug visualization of the mesh.
//        debugOptions.insert(.showSceneUnderstanding)
        
        // For performance, disable render options that are not required for this app.
        renderOptions = [.disableMotionBlur]
        
        session.delegate = self
        session.run(configuration)
    }
    
    func addTapToPaintGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addPaintBox))
        tapGesture.delegate = self
        addGestureRecognizer(tapGesture)
    }
    
    func checkIfTappedSurfaceIsWall(tapLocation: CGPoint) -> Bool {
        guard let raycastQuery = makeRaycastQuery(from: tapLocation, allowing: .existingPlaneGeometry, alignment: .vertical) else {
            return false
        }
        
        let results = session.raycast(raycastQuery)
        
        guard let planeAnchor = results.first?.anchor as? ARPlaneAnchor else { return  false }
        
        switch planeAnchor.classification {
        case .wall:
            print("CLASSED AS: \(planeAnchor.classification)")
            return true
        default:
            print("NOT WALL WE ARE NOT INTERESTED")
            return false
        }
    }
    
    @objc func addPaintBox(sender: UITapGestureRecognizer) {
        let location = sender.location(in: self)
        guard checkIfTappedSurfaceIsWall(tapLocation: location) else { return }
        
        switch selectedPaintColor {
        case .red:
            let boxAnchor = try! PaintBox.loadRedBox()
            scene.anchors.append(boxAnchor)
        case .blue:
            let boxAnchor = try! PaintBox.loadBlueBox()
            scene.anchors.append(boxAnchor)
        }
    }
}

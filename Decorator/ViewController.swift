//
//  ViewController.swift
//  Decorator
//
//  Created by verebes on 29/12/2020.
//

import UIKit
import RealityKit

final class ViewController: UIViewController {
    
    @IBOutlet var arView: MainARView!
    
    let paintColorBtn = RoundedButton(title: "")
    let saveImageBtn = RoundedButton(title: "SAVE IMAGE", fontSize: 15)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addUIElements(within: view.safeAreaLayoutGuide)
    }
    
    private func addUIElements(within safeArea: UILayoutGuide) {
        addPaintColorBtn(within: safeArea)
        addSaveImageButton(within: safeArea)
    }
    
    private func addPaintColorBtn(within safeArea: UILayoutGuide) {
        view.addSubview(paintColorBtn)
        paintColorBtn.setImage(UIImage(named: "paint-bucket"), for: .normal)
        paintColorBtn.tintColor = .systemRed
        paintColorBtn.heightAnchor.constraint(equalToConstant: 80).isActive = true
        paintColorBtn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        paintColorBtn.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        paintColorBtn.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -15).isActive = true
        
        paintColorBtn.addTarget(self, action: #selector(switchPaintColor), for: .touchUpInside)
    }
    
    private func addSaveImageButton(within safeArea: UILayoutGuide) {
        view.addSubview(saveImageBtn)
        saveImageBtn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        saveImageBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        saveImageBtn.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20).isActive = true
        saveImageBtn.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        
        saveImageBtn.addTarget(self, action: #selector(saveImageToCameraRoll), for: .touchUpInside)
    }
    
    @objc func switchPaintColor() {
        switch arView.selectedPaintColor {
        case .red:
            arView.selectedPaintColor = .blue
            paintColorBtn.tintColor = .systemBlue
        case .blue:
            arView.selectedPaintColor = .red
            paintColorBtn.tintColor = .systemRed
        }
    }
    
    @objc func saveImageToCameraRoll() {
        takeScreenshot()
    }
    
    func takeScreenshot(_ shouldSave: Bool = true) {
        arView.snapshot(saveToHDR: false) { (image) in
            guard let cgImage = image?.cgImage else { return }
            let screenShot = UIImage(cgImage: cgImage)
            UIImageWriteToSavedPhotosAlbum(screenShot, nil, nil, nil)
        }
    }
}

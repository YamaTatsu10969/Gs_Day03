//
//  ViewController.swift
//  ImageTracking
//
//  Created by Jun Takahashi on 2019/05/14.
//  Copyright © 2019 Jun Takahashi. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    let hapticGenerator = UINotificationFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ①　認識したい画像をセットアップする
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        print("💬 Detection Anchor....",imageAnchor.name!)
        //取得したimageAnchorのサイズで平面を作成
        let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width,
                             height: imageAnchor.referenceImage.physicalSize.height)
        //見やすいように色を塗ってあげる
        plane.firstMaterial?.diffuse.contents = UIColor(red: 1.0, green:  0, blue: 0, alpha: 0.5)
        let planeNode = SCNNode(geometry: plane)
        
        planeNode.eulerAngles.x = -.pi / 2 //平面はXY軸で作られるのでX軸で奥倒す
        planeNode.renderingOrder = -1
        node.addChildNode(planeNode)
        print("💬 Add Plane Node....")
        //シーンを作成
        guard let zombieScene = SCNScene(named: "art.scnassets/Zombie Idle/Zombie Idle.scn") else { return }
        
        /* シーンから子ノードを取り出して新しいノードに付け替える */
        let zombieNode = SCNNode()
        for childNode in zombieScene.rootNode.childNodes {
            zombieNode.addChildNode(childNode)
        }
        
        let (min, max) = (zombieNode.boundingBox)
        let h = max.y - min.y
        let magnification = 0.15 / h
        zombieNode.scale = SCNVector3(magnification, magnification, magnification)
        node.addChildNode(zombieNode)

        //planeNodeに生やす場合
        //zombieNode.eulerAngles.x = .pi / 2 //平面にくっついてしまうのでX軸で手前に倒す
        //planeNode.addChildNode(zombieNode)

    
        print("💬 Add Zombie Node....")
        DispatchQueue.main.async {
            self.hapticGenerator.notificationOccurred(.warning)

        }

    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

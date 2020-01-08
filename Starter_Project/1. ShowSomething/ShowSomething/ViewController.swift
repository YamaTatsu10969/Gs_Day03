//
//  ViewController.swift
//  ShowSomething
//
//  Created by Jun Takahashi on 2019/05/13.
//  Copyright © 2019 Jun Takahashi. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        
        // シーンビューの設定変更
        sceneView.showsStatistics = true
        
        //① シーンの作成
        let scene = SCNScene()
        
        //② ノードの作成

        
        //④ 作ったノードをルートノードに追加して紐付ける
        
        
        
        // シーンビューに作ったシーンデータを入れる
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // VCから離れる直前にセッションを止める
        sceneView.session.pause()
    }
    
}

extension ViewController : ARSCNViewDelegate{
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    //セッションの失敗したとき
    func session(_ session: ARSession, didFailWithError error: Error) {
    }
    
    //セッションが中断した時
    func sessionWasInterrupted(_ session: ARSession) {
    }
    
    //セッションの中断が再開し、再度デバイスの位置を追跡した時
    func sessionInterruptionEnded(_ session: ARSession) {
    }
}

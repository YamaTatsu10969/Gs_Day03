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
        
        //sceneView.autoenablesDefaultLighting = true //デフォルトのライティングをつける
        //sceneView.allowsCameraControl = true //カメラのインタラクション
        
        //① シーンの作成
        let scene = SCNScene()
        //②　ノードの作成
        let node = createTextNode()
        //④ 作ったノードをルートノードに追加して紐付ける
        scene.rootNode.addChildNode(node)
        
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
    
    
    func createTextNode() -> SCNNode {
        //②-1 ジオメトリ(形状)の作成
        let textGeometry = SCNText(string: "Hello World", extrusionDepth: 1)
        //②-2 ジオメトリ(形状)の設定（マテリアル）
        textGeometry.firstMaterial?.diffuse.contents = UIColor.red //ジオメトリのマテリアル設定で「赤」を指定してあげる
        
        //③-1 ジオメトリを格納するノードを作成
        let textNode = SCNNode(geometry: textGeometry)
        //③-2 ジオメトリを格納するノードの設定
        textNode.position = SCNVector3(0, 0, -0.5) //ノードの座標を調整
        textNode.scale = SCNVector3(0.02 , 0.02, 0.02) //ノードの大きさを調整
        
        
        return textNode
    }
    
    func createBoxNode() -> SCNNode {
        //②-1 ジオメトリ(形状)の作成
        let boxGeometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0) //立方体
        //②-2 ジオメトリ(形状)の設定（マテリアル）
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.yellow
        boxGeometry.materials = [material]
        
        //③-1 ジオメトリを格納するノードを作成
        let boxNode = SCNNode(geometry: boxGeometry)
        //③-2 ジオメトリを格納するノードの設定
        boxNode.position = SCNVector3(0, 0, -0.5) //ノードの座標を調整
        
        return boxNode
    }
    
    func createSphereNode() -> SCNNode {
        //②-1 ジオメトリ(形状)の作成
        let sphereGeometry = SCNSphere(radius: 0.1) //半径を設定
        //②-2 ジオメトリ(形状)の設定（マテリアル）
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "earth")
        sphereGeometry.materials = [material]
        
        //③-1 ジオメトリを格納するノードを作成
        let sphereNode = SCNNode(geometry: sphereGeometry)
        //③-2 ジオメトリを格納するノードの設定
        sphereNode.position = SCNVector3(0, 0, -0.5) //ノードの座標を調整
        let rotateAction = SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 4)//回転
        let repeatAction = SCNAction.repeatForever(rotateAction)//繰り返し
        sphereNode.runAction(repeatAction)//回転の繰り返しをRUN

        return sphereNode
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

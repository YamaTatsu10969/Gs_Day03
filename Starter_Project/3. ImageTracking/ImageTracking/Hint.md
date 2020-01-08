# 補助テキスト

## 準備

- art から、Zombie Idle を art.scnassets に入れる

## 1. setupTrackingImages メソッドを追加

```
func setupTrackingImages() {
    // Create a session configuration
    //let configuration = ARWorldTrackingConfiguration()
    let configuration = ARImageTrackingConfiguration()
    
    let trackImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources",
                                                       bundle: nil)!
    print("💬 Set Track Image....")
    configuration.trackingImages = trackImages
    
    // Run the view's session
    sceneView.session.run(configuration)
}

```

## 2. viewWillAppear に setupTrackingImages() を追加

```
// ①　認識したい画像をセットアップする
setupTrackingImages()
```



# 補助テキスト


## 準備
- Pikachu オブジェクトを入れる

## 1. addTapGestureRecognizerAtScene メソッドを追加


```
func addTapGestureRecognizerAtScene() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:
        #selector(tapped))
    self.sceneView.addGestureRecognizer(tapGestureRecognizer)
}
```

## 2.  setupAudioPlayer メソッドを追加


```
func setupAudioPlayer(){
    guard let soundData = NSDataAsset(name: "Pikaaaa")?.data else { return }
    do {
        self.audioPlayer = try AVAudioPlayer(data: soundData, fileTypeHint: "mp3")
        self.audioPlayer.prepareToPlay()
    } catch {
        print("💬 Error")
    }
}
```


## 3. viewDidLoad の中に追加

```
// ①タップした時の反応を追加する
addTapGestureRecognizerAtScene()

// ②オーディオプレイヤーをセットする
setupAudioPlayer()
```

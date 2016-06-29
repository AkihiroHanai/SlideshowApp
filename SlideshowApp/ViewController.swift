//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 花井章宏 on 2016/06/28.
//  Copyright © 2016年 akihiro.hanai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // カウンターを宣言します。
    var countImg :Int = 0
    
    // スタート & ポーズ
    var toggleState :Int = 1
    
    // タイマー
    var timer:NSTimer!
    
    // 表示されている画像
    var currentImg:Int = 0
    
    // アニメーション中かどうかを判別するための変数
    var animationFlag :Bool = false
    
    // 画像の配列を準備する。
    let images = [
            UIImage(named: "img0.png")!,
            UIImage(named: "img1.png")!,
            UIImage(named: "img2.png")!
        ]
    
    // イメージボックスのアウトレット
    @IBOutlet weak var imgBox: UIImageView!
    
    // 進む・戻るボタンのアウトレット
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    // スタート&ポーズボタン
    @IBOutlet weak var startAndPauseButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // スタートボタンのテキスト変更
        self.startAndPauseButton.setTitle("再生", forState: .Normal)
        
        // 画像の初期設定
        self.imgBox.image = images[0]
        
        //画像番号の入力
        self.currentImg = 0
        
        // タッチイベントを可能にする。
        imgBox.userInteractionEnabled = true
        imgBox.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.imageTapped(_:))))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        // segueから遷移先のSingleImageControllerを取得する。
        let secondViewController:SingleImageController = segue.destinationViewController as! SingleImageController
        // SingleImageControllerのparamに値を渡す。
        if animationFlag == false {
            secondViewController.param = "img\(currentImg).png"
        } else {
            timer.invalidate()
            nextButton.enabled = true
            prevButton.enabled = true
            secondViewController.param = "img\(currentImg).png"
            toggleState = 1
            // スタートボタンのテキスト変更
            self.startAndPauseButton.setTitle("再生", forState: .Normal)
        }
    }
    
    // アクション　--------------------------------------------------------------------------------
    
    // 戻るボタン
    @IBAction func prev(sender: AnyObject) {
        imgPrev()
    }
    
    // 進むボタン
    @IBAction func next(sender: AnyObject) {
        imageNext()
    }
    
    // 再生 / 停止ボタン
    @IBAction func playpause(sender: AnyObject) {
        
        if toggleState == 1 {
            
            timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self,selector: #selector(ViewController.imageNextTimer(_:)), userInfo: nil, repeats: true)
            
            nextButton.enabled = false
            prevButton.enabled = false
            
            toggleState = 2
            animationFlag = true
            
            // スタートボタンのテキスト変更
            self.startAndPauseButton.setTitle("停止", forState: .Normal)
            
            print("スタート")
            
        } else {
            
            timer.invalidate()
            
            nextButton.enabled = true
            prevButton.enabled = true
            
            toggleState = 1
            animationFlag = false
            
            // スタートボタンのテキスト変更
            self.startAndPauseButton.setTitle("再生", forState: .Normal)
            
            print("ポーズ")
        }
    }
    
    
    // 関数　--------------------------------------------------------------------------------
    
    // 進む
    func imageNext(){
        if countImg == 2 {
            countImg = 0
            self.currentImg = 0
            self.imgBox.image = images[countImg]
        } else {
            countImg += 1
            self.currentImg += 1
            self.imgBox.image = images[countImg]
        }
        
        print("進む")
    }
    
    // 進む - タイマー
    func imageNextTimer(timer : NSTimer){
        imageNext()
    }
    
    // 戻る
    func imgPrev() {
        if countImg == 0 {
            countImg = 2
            self.currentImg = 2
            self.imgBox.image = images[countImg]
        } else {
            countImg -= 1
            self.currentImg -= 1
            self.imgBox.image = images[countImg]
        }
        
        print("戻る")
    }
    
    // 画像をタップ。
    func imageTapped(sender: UITapGestureRecognizer) {
        performSegueWithIdentifier("singleImage", sender: UITapGestureRecognizer())
        print("画像がタップされました。")
    }
    
    // SingleImageControllerから戻った時に実行される。
    @IBAction func unwind(segue: UIStoryboardSegue) {
        print("戻ってきました。")
    }
}

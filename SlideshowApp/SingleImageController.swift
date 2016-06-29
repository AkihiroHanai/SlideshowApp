//
//  SingleImageController.swift
//  SlideshowApp
//
//  Created by 花井章宏 on 2016/06/28.
//  Copyright © 2016年 akihiro.hanai. All rights reserved.
//

import UIKit

class SingleImageController: UIViewController {
    
    @IBOutlet weak var singleImageView: UIImageView!
    
    //パラメータ受取用プロパティ
    var param:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        //パラメータのバインド
        self.singleImageView.image = UIImage(named: param)!
    }
}
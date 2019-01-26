//
//  NavigationController.swift
//  YouTubeEx
//
//  Created by user140592 on 1/26/19.
//  Copyright © 2019 talspektor. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    static let shared = UINavigationController(rootViewController: HomeController(collectionViewLayout:  UICollectionViewFlowLayout()
))
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}

//
//  ViewController.swift
//  snapkitList
//
//  Created by Tori on 04/10/2019.
//  Copyright © 2019 Tori. All rights reserved.
//

import UIKit

/**
탭바 컨트롤러
*/

class ViewController: UITabBarController, UITabBarControllerDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate
        self.delegate = self
        
        //parnoramaListVC
        let parnoramaListVC = ParnoramaListVC()
        //item
        let parnoramaItem = UITabBarItem()
        parnoramaItem.title = "parnorama"
        parnoramaListVC.tabBarItem = parnoramaItem
        
        //thumbListVC
        let thumbListVC = ThumbListVC()
        //item
        let thumbItem = UITabBarItem()
        thumbItem.title = "thumbnail"
        thumbListVC.tabBarItem = thumbItem
        
        //set vc tab
        self.viewControllers = [parnoramaListVC, thumbListVC]
 
        
    }


}


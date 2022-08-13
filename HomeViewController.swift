//
//  ViewController.swift
//  music theory
//
//  Created by Helen Zhou on 3/25/20.
//  Copyright © 2020 Helen Zhou. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    var scroll: UIScrollView!
    var sideScroll: UIScrollView!
    @IBOutlet weak var homeTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        
        let iconImages = ["icon 1", "icon 2", "icon 3", "icon 4", "icon 5", "icon 6", "icon 7", "icon 8", "icon 9", "icon 10", "icon 11", "icon 12", "icon 13", "icon 14", "icon 15", "icon 16"]
        let darkIconImages = ["icon 1 dark", "icon 2 dark", "icon 3 dark", "icon 4 dark", "icon 5 dark", "icon 6 dark", "icon 7 dark", "icon 8 dark", "icon 9 dark", "icon 10 dark", "icon 11 dark", "icon 12 dark", "icon 13 dark", "icon 14 dark", "icon 15 dark", "icon 16 dark"]
        let lessonTitles = ["The Staff", "Key Signatures", "Rhythm", "Meter", "Intervals", "Major and Minor Scales", "Scale Degrees", "Music Modes", "Triads", "Sevenths", "Chord Inversions", "Diatonic Chords", "Aspects of Sound", "Early Period", "Common Practice Period", "Modern Period"]
        
        if traitCollection.userInterfaceStyle == .light {
            homeTitle.textColor = UIColor.black
        }else{
            homeTitle.textColor = UIColor.white
        }
        
        scroll = UIScrollView(frame: CGRect(x: 0, y: homeTitle.frame.size.height + homeTitle.frame.origin.y + 15, width: self.view.frame.size.width, height: self.view.frame.size.height - homeTitle.frame.origin.y - homeTitle.frame.size.height - 15))
        scroll.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height * 1.5)
        scroll.showsVerticalScrollIndicator = false
        self.view.addSubview(scroll)
        
        let titles = ["The Basics", "Intervals and Scales", "Chords", "History"]
        var yPosition: CGFloat = 0
        for i in 0..<4{
            let title = UILabel(frame: CGRect(x: 15, y: yPosition, width: scroll.contentSize.width, height: scroll.contentSize.height / 20))
            title.text = titles[i]
            title.font = UIFont(name: "Avenir Book", size: 24)
            if traitCollection.userInterfaceStyle == .light {
                title.textColor = UIColor.black
            }else{
                title.textColor = UIColor.white
            }
            title.textAlignment = .left
            scroll.addSubview(title)
            
            sideScroll = UIScrollView(frame: CGRect(x: 0, y: yPosition + scroll.contentSize.height / 20, width: self.view.frame.size.width, height: scroll.contentSize.height * 7 / 40))
            sideScroll.contentSize = CGSize(width: scroll.contentSize.height * 3 / 5 + self.view.frame.size.width / 10, height: scroll.contentSize.height * 7 / 40)
            sideScroll.showsHorizontalScrollIndicator = false
            scroll.addSubview(sideScroll)
            
            var buttonX: CGFloat = self.view.frame.size.width / 50
            for j in 0..<4{
                let lessonButton = UIButton(frame: CGRect(x: buttonX, y: 0, width: scroll.contentSize.height * 3 / 20, height: scroll.contentSize.height * 3 / 20))
                if traitCollection.userInterfaceStyle == .light {
                    lessonButton.setImage(UIImage(named: darkIconImages[i * 4 + j]), for: .normal)
                }else{
                    lessonButton.setImage(UIImage(named: iconImages[i * 4 + j]), for: .normal)
                }
                lessonButton.contentVerticalAlignment = .fill
                lessonButton.contentHorizontalAlignment = .fill
                lessonButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                lessonButton.tag = i * 4 + j
                lessonButton.addTarget(self, action: #selector(HomeViewController.pressed), for: .touchDown)
                sideScroll.addSubview(lessonButton)
                
                let lessonTitle = UILabel(frame: CGRect(x: buttonX + 5, y: scroll.contentSize.height * 3 / 20 + 5, width: scroll.contentSize.height * 3 / 20, height: scroll.contentSize.height * 1 / 40))
                lessonTitle.text = lessonTitles[i * 4 + j]
                if self.view.frame.size.width >= 750 {
                    lessonTitle.font = UIFont(name: "Avenir Book", size: 20)
                }else{
                    lessonTitle.font = UIFont(name: "Avenir Book", size: 12)
                }
                if traitCollection.userInterfaceStyle == .light {
                    lessonTitle.textColor = UIColor.darkGray
                }else{
                    lessonTitle.textColor = UIColor(displayP3Red: 239.0 / 255.0, green: 180.0 / 255.0, blue: 170.0 / 255.0, alpha: 1.0)
                }
                lessonTitle.textAlignment = .left
                sideScroll.addSubview(lessonTitle)
                buttonX += scroll.contentSize.height * 3 / 20 + self.view.frame.size.width / 50
            }
                
            yPosition += scroll.contentSize.height / 4
        }
    }
    
    @objc func pressed(sender: UIButton!){
        Lessons.lessonNumber = sender.tag
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "staff") as UIViewController
        navigationController?.pushViewController(vc, animated: true)
    }

}

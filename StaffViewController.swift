//
//  StaffViewController.swift
//  music theory
//
//  Created by Helen Zhou on 4/17/20.
//  Copyright © 2020 Helen Zhou. All rights reserved.
//

import Foundation
import UIKit

struct Lessons {
    public static var lessonNumber = 0
}

class StaffViewController: UIViewController {
    
    var scroll: UIScrollView!
    let lessonTitles = ["Lesson 1", "Lesson 2", "Lesson 3", "Lesson 4", "Lesson 5", "Lesson 6", "Lesson 7", "Lesson 8", "Lesson 9", "Lesson 10", "Lesson 11", "Lesson 12", "Lesson 13", "Lesson 14", "Lesson 15", "Lesson 16"]
    let lessonNames = ["The Staff", "Key Signatures", "Rhythm", "Meter", "Intervals", "Major and Minor Scales", "Scale Degrees", "Music Modes", "Triads", "Sevenths", "Chord Inversions", "Diatonic Chords", "Aspects of Sound", "The Early Period", "The Common Practice Period", "The Modern Period"]
    let lessonImages = ["lesson 1", "lesson 2", "lesson 3", "lesson 4", "lesson 5", "lesson 6", "lesson 7", "lesson 8", "lesson 9", "lesson 10", "lesson 11", "lesson 12", "lesson 13", "lesson 14", "lesson 15", "lesson 16"]
    let darkLessonImages = ["lesson 1 dark", "lesson 2 dark", "lesson 3 dark", "lesson 4 dark", "lesson 5 dark", "lesson 6 dark", "lesson 7 dark", "lesson 8 dark", "lesson 9 dark", "lesson 10 dark", "lesson 11 dark", "lesson 12 dark", "lesson 13 dark", "lesson 14 dark", "lesson 15 dark", "lesson 16 dark"]
    
    @IBOutlet weak var lessonTitle: UILabel!
    @IBOutlet weak var lessonName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        lessonTitle.text = lessonTitles[Lessons.lessonNumber]
        lessonTitle.backgroundColor = UIColor.white.withAlphaComponent(0)
        lessonTitle.textAlignment = .center
        if traitCollection.userInterfaceStyle == .light {
            lessonTitle.textColor = UIColor.black
        }else{
            lessonTitle.textColor = UIColor.white
        }
        
        lessonName.text = lessonNames[Lessons.lessonNumber]
        lessonName.backgroundColor = UIColor.white.withAlphaComponent(0)
        lessonName.textAlignment = .center
        lessonName.textColor = UIColor(displayP3Red: 239.0 / 255.0, green: 180.0 / 255.0, blue: 170.0 / 255.0, alpha: 1.0)
        
        let backArrow: UIButton
        if self.view.frame.size.width >= 750 {
            backArrow = UIButton(frame: CGRect(x: 50, y: lessonTitle.frame.origin.y + 10, width: 30, height: 40))
        }else{
            backArrow = UIButton(frame: CGRect(x: 20, y: lessonTitle.frame.origin.y + 5, width: 15, height: 25))
        }
        backArrow.addTarget(self, action: #selector(StaffViewController.pressed), for: .touchDown)
        backArrow.setImage(UIImage(named: "backarrow"), for: .normal)
        self.view.addSubview(backArrow)
        
        scroll = UIScrollView(frame: CGRect(x: 0, y: lessonTitle.frame.size.height + lessonTitle.frame.origin.y + lessonName.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height - lessonTitle.frame.size.height - lessonTitle.frame.origin.y - lessonName.frame.size.height))
        if Lessons.lessonNumber == 0 || Lessons.lessonNumber == 1 {
            scroll.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width * 2.5)
        }else if Lessons.lessonNumber == 8 || Lessons.lessonNumber == 9 {
            scroll.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width * 4)
        }else if Lessons.lessonNumber == 11 || Lessons.lessonNumber == 14 {
            scroll.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width * 4.5)
        }else if Lessons.lessonNumber == 13 || Lessons.lessonNumber == 15{
            scroll.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width * 3.5)
        }else{
            scroll.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.width * 3.125)
        }
        scroll.showsVerticalScrollIndicator = false
        self.view.addSubview(scroll)
        
        var imageView1 : UIImageView
        if self.view.frame.size.width >= 750 {
            imageView1 = UIImageView(frame: CGRect(x: self.view.frame.size.width * 0.05, y: 0, width: self.view.frame.size.width * 0.9, height: scroll.contentSize.height));
        }else{
            imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: scroll.contentSize.height));
        }
        if traitCollection.userInterfaceStyle == .light {
            imageView1.image = UIImage(named:lessonImages[Lessons.lessonNumber])
        }else{
            imageView1.image = UIImage(named:darkLessonImages[Lessons.lessonNumber])
        }
        scroll.addSubview(imageView1)
    }
    
    @objc func pressed(sender: UIButton!){
        navigationController?.popViewController(animated: true)
    }
}

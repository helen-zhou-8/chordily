//
//  PianoViewController.swift
//  music theory
//
//  Created by Helen Zhou on 3/25/20.
//  Copyright © 2020 Helen Zhou. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AudioToolbox

class PianoViewController: UIViewController {

    var midiButton: UIButton!
    var chordButton: UIButton!
    var nameButton: UIButton!
    var midiBool = false
    var chordBool = false
    var nameBool = false
    var songButton: UIButton!
    var chordView: UIView!
    
    var chordArray: [Int] = []
    var startingNote = 0
    var startingNoteTag = 0
    var typeTag = 0
    var octaveBool = false
    var noteNameBool = false
    var typeBool = false
    var interval1 = 0
    var interval2 = 0
    
    let whiteGrayShade = UIColor(displayP3Red: 200.0 / 255.0, green: 200.0 / 255.0, blue: 200.0 / 255.0, alpha: 1.0)
    let blackGrayShade = UIColor(displayP3Red: 60.0 / 255.0, green: 60.0 / 255.0, blue: 60.0 / 255.0, alpha: 1.0)
    let pinkShade = UIColor(displayP3Red: 239.0 / 255.0, green: 180.0 / 255.0, blue: 170.0 / 255.0, alpha: 1.0)
    let lightPurpleShade = UIColor(displayP3Red: 154.0 / 255.0, green: 168.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
    let darkPurpleShade = UIColor(displayP3Red: 120.0 / 255.0, green: 120.0 / 255.0, blue: 180.0 / 255.0, alpha: 1.0)
    let lightYellowShade = UIColor(displayP3Red: 235.0 / 255.0, green: 219.0 / 255.0, blue: 52.0 / 255.0, alpha: 1.0)
    let darkYellowShade = UIColor(displayP3Red: 235.0 / 255.0, green: 156.0 / 255.0, blue: 52.0 / 255.0, alpha: 1.0)
    let lightGreenShade = UIColor(displayP3Red: 52.0 / 255.0, green: 235.0 / 255.0, blue: 152.0 / 255.0, alpha: 1.0)
    let darkGreenShade = UIColor(displayP3Red: 60.0 / 255.0, green: 180.0 / 255.0, blue: 40.0 / 255.0, alpha: 1.0)
    let lightBlueShade = UIColor(displayP3Red: 52.0 / 255.0, green: 219.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0)
    let darkBlueShade = UIColor(displayP3Red: 52.0 / 255.0, green: 119.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0)
    
    var scroll: UIScrollView!
    var keyboards = [AVAudioPlayer](repeating: AVAudioPlayer(), count: 88)
    let whiteKeyNames = ["C8", "B7", "A7", "G7", "F7", "E7", "D7", "C7", "B6", "A6", "G6", "F6", "E6", "D6", "C6", "B5", "A5", "G5", "F5", "E5", "D5", "C5", "B4", "A4", "G4", "F4", "E4", "D4", "C4", "B3", "A3", "G3", "F3", "E3", "D3", "C3", "B2", "A2", "G2", "F2", "E2", "D2", "C2", "B1", "A1", "G1", "F1", "E1", "D1", "C1", "B0", "A0"]
    let blackKeyNames = ["A#7 / B♭7", "G#7 / A♭7", "F#7 / G♭7", "D#7 / E♭7", "C#7 / D♭7", "A#6 / B♭6", "G#6 / A♭6", "F#6 / G♭6", "D#6 / E♭6", "C#6 / D♭6", "A#5 / B♭5", "G#5 / A♭5", "F#5 / G♭5", "D#5 / E♭5", "C#5 / D♭5", "A#4 / B♭4", "G#4 / A♭4", "F#4 / G♭4", "D#4 / E♭4", "C#4 / D♭4", "A#3 / B♭3", "G#3 / A♭3", "F#3 / G♭3", "D#3 / E♭3", "C#3 / D♭3", "A#2 / B♭2", "G#2 / A♭2", "F#2 / G♭2", "D#2 / E♭2", "C#2 / D♭2", "A#1 / B♭1", "G#1 / A♭1", "F#1 / G♭1", "D#1 / E♭1", "C#1 / D♭1", "C#0 / D♭0"]
    
    @IBOutlet weak var pianoTitle: UILabel!
    
    //runs before autolayout --> loads the background view
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //lays out everything from storyboard and then runs
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if traitCollection.userInterfaceStyle == .light {
            pianoTitle.textColor = UIColor.black
        }else{
            pianoTitle.textColor = UIColor.white
        }
        
        midiButton = UIButton(frame: CGRect(x: 0, y: pianoTitle.frame.size.height + pianoTitle.frame.origin.y + 15, width: self.view.frame.size.width / 3, height: 40))
        midiButton.backgroundColor = pinkShade
        midiButton.setTitle("MIDI sound", for: .normal)
        midiButton.setTitleColor(UIColor.white, for: .normal)
        midiButton.tag = 1
        midiButton.addTarget(self, action: #selector(PianoViewController.midiPressed), for: .touchDown)
        self.view.addSubview(midiButton)
        
        chordButton = UIButton(frame: CGRect(x: self.view.frame.size.width / 3, y: pianoTitle.frame.size.height + pianoTitle.frame.origin.y + 15, width: self.view.frame.size.width / 3, height: 40))
        chordButton.backgroundColor = pinkShade
        chordButton.setTitle("chord builder", for: .normal)
        chordButton.setTitleColor(UIColor.white, for: .normal)
        chordButton.tag = 3
        chordButton.addTarget(self, action: #selector(PianoViewController.chordPressed), for: .touchDown)
        self.view.addSubview(chordButton)
        
        nameButton = UIButton(frame: CGRect(x: self.view.frame.size.width * 2 / 3, y: pianoTitle.frame.size.height + pianoTitle.frame.origin.y + 15, width: self.view.frame.size.width / 3, height: 40))
        nameButton.backgroundColor = pinkShade
        nameButton.setTitle("key names", for: .normal)
        nameButton.setTitleColor(UIColor.white, for: .normal)
        nameButton.tag = 5
        nameButton.addTarget(self, action: #selector(PianoViewController.namePressed), for: .touchDown)
        self.view.addSubview(nameButton)
        
        scroll = UIScrollView(frame: CGRect(x: 0, y: pianoTitle.frame.size.height + pianoTitle.frame.origin.y + 55, width: self.view.frame.size.width, height: self.view.frame.size.height - pianoTitle.frame.origin.y - pianoTitle.frame.size.height - 55))
        scroll.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height * 6)
        scroll.showsVerticalScrollIndicator = false
        scroll.bounces = false
        self.view.addSubview(scroll)
        
        var whiteHeight: CGFloat = 0
        var whiteTag = 108
        for i in 1..<53{
            let key = UIButton(frame: CGRect(x: 0, y: whiteHeight, width: scroll.contentSize.width, height: scroll.contentSize.height / 52))
            key.layer.borderWidth = 2
            key.backgroundColor = UIColor.white
            key.layer.borderColor = UIColor.black.cgColor
            key.tag = whiteTag
            key.addTarget(self, action: #selector(PianoViewController.pressed), for: .touchDown)
            key.addTarget(self, action: #selector(PianoViewController.released), for: .touchUpInside)
            scroll.addSubview(key)
            whiteHeight += scroll.contentSize.height / 52
            if(i % 7 == 1 || i % 7 == 5){
                whiteTag -= 1
            }else{
                whiteTag -= 2
            }
        }
        
        var blackHeight: CGFloat = (scroll.contentSize.height / 52) + (scroll.contentSize.height / 52 * 0.75)
        var blackTag = 106
        for i in 1..<37{
            let key2 = UIButton(frame: CGRect(x: 0, y: blackHeight, width: scroll.contentSize.width * 0.6, height: scroll.contentSize.height / 104))
            key2.layer.borderWidth = 2
            key2.backgroundColor = UIColor.black
            key2.layer.borderColor = UIColor.black.cgColor
            key2.tag = blackTag
            key2.addTarget(self, action: #selector(PianoViewController.pressed), for: .touchDown)
            key2.addTarget(self, action: #selector(PianoViewController.released), for: .touchUpInside)
            scroll.addSubview(key2)
            if(i % 5 == 3 || i % 5 == 0) {
                blackHeight += scroll.contentSize.height / 26
                blackTag -= 3
            }else{
                blackHeight += scroll.contentSize.height / 52
                blackTag -= 2
            }
        }
        
        var labelY = scroll.contentSize.height / 208
        for i in 0..<52 {
            let nameLabel = UILabel(frame: CGRect(x: 0, y: labelY, width: scroll.contentSize.width - 15, height: scroll.contentSize.height / 104))
            nameLabel.text = whiteKeyNames[i]
            nameLabel.textColor = UIColor.darkGray
            nameLabel.backgroundColor = UIColor.white.withAlphaComponent(0)
            nameLabel.font = UIFont(name: "Avenir Book", size: 20)
            nameLabel.tag = 10000
            nameLabel.alpha = 0.0
            nameLabel.textAlignment = .right
            scroll.addSubview(nameLabel)
            labelY += scroll.contentSize.height / 52
        }
        
        var label2Y = (scroll.contentSize.height / 52) + (scroll.contentSize.height / 52 * 0.75)
        for i in 1..<37 {
            let nameLabel2 = UILabel(frame: CGRect(x: 0, y: label2Y, width: scroll.contentSize.width * 0.6 - 15, height: scroll.contentSize.height / 104))
            nameLabel2.text = blackKeyNames[i - 1]
            nameLabel2.textColor = UIColor.white
            nameLabel2.backgroundColor = UIColor.white.withAlphaComponent(0)
            nameLabel2.font = UIFont(name: "Avenir Book", size: 20)
            nameLabel2.tag = 10000
            nameLabel2.alpha = 0.0
            nameLabel2.textAlignment = .right
            scroll.addSubview(nameLabel2)
            if(i % 5 == 3 || i % 5 == 0){
                label2Y += scroll.contentSize.height / 26
            }else{
                label2Y += scroll.contentSize.height / 52
            }
        }
        
        //creates the chord constructor
        chordView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        if traitCollection.userInterfaceStyle == .light {
            chordView.backgroundColor = .white
        }else{
            chordView.backgroundColor = .black
        }
        chordView.alpha = 0.0
        chordView.tag = 20000
        self.view.addSubview(chordView)
        
        let clear: UIButton
        if self.view.frame.size.width >= 750 {
            clear = UIButton(frame: CGRect(x: self.view.frame.size.width/2-self.view.frame.size.width/8, y: self.view.frame.size.height-self.view.frame.size.height/15, width: self.view.frame.size.width/4, height: self.view.frame.size.height/20))
            clear.titleLabel?.font = UIFont.systemFont(ofSize: 32.0)
        }else{
            clear = UIButton(frame: CGRect(x: self.view.frame.size.width/2-self.view.frame.size.width/6, y: self.view.frame.size.height-self.view.frame.size.height/15, width: self.view.frame.size.width/3, height: self.view.frame.size.height/20))
            clear.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        }
        clear.setTitle("clear chord", for: .normal)
        clear.backgroundColor = self.lightPurpleShade
        clear.addTarget(self, action: #selector(PianoViewController.clearPressed), for: .touchDown)
        chordView.addSubview(clear)
        
        var setWidth: CGFloat = 0.0
        var circleWidth: CGFloat = 0.0
        var typeWidth: CGFloat = 0.0
        var textFont: CGFloat = 0.0
        var distanceApart: CGFloat = 0.0
        var typeRadius: CGFloat = 0.0
        if self.view.frame.size.width >= 750 {
            circleWidth = self.view.frame.size.width * 0.08
            typeWidth = self.view.frame.size.width * 0.12
            textFont = 32.0
            distanceApart = self.view.frame.size.width * 0.03
            setWidth = self.view.frame.size.width * 0.2
            typeRadius = self.view.frame.size.width * 0.45
        }else{
            circleWidth = self.view.frame.size.width * 0.12
            typeWidth = self.view.frame.size.width * 0.18
            textFont = 18.0
            distanceApart = self.view.frame.size.width * 0.03
            setWidth = self.view.frame.size.width * 0.3
            typeRadius = self.view.frame.size.width * 0.6
        }
        
        let set = UIButton(frame: CGRect(x: (self.view.frame.size.width/2)-(setWidth/2), y: (self.view.frame.size.height/2)-(setWidth/2), width: setWidth, height: setWidth))
        set.titleLabel?.font = UIFont.systemFont(ofSize: textFont)
        set.backgroundColor = self.pinkShade
        set.layer.cornerRadius = set.bounds.size.width/2;
        set.setTitle("set chord", for: .normal)
        set.addTarget(self, action: #selector(PianoViewController.setPressed), for: .touchDown)
        chordView.addSubview(set)
        
        let octaveArray = ["1", "2", "3", "4", "5", "6"]
        var octaveX = self.view.frame.size.width/2 + setWidth/2 + distanceApart
        var octaveY = self.view.frame.size.height/2 - circleWidth/2
        for i in 0..<6{
            var octaveButton = UIButton(frame: CGRect(x: octaveX, y: octaveY, width: circleWidth, height: circleWidth))
            octaveButton.titleLabel?.font = UIFont.systemFont(ofSize: textFont)
            octaveButton.backgroundColor = self.lightYellowShade
            octaveButton.layer.cornerRadius = octaveButton.bounds.size.width/2;
            octaveButton.setTitle(octaveArray[i], for: .normal)
            octaveButton.addTarget(self, action: #selector(PianoViewController.octavePressed), for: .touchDown)
            octaveButton.tag = 5 - i
            chordView.addSubview(octaveButton)
            octaveX = (setWidth/2 + distanceApart + circleWidth/2) * cos(CGFloat(i + 1) * CGFloat.pi / 3) - circleWidth/2 + CGFloat(self.view.frame.size.width/2)
            octaveY = (setWidth/2 + distanceApart + circleWidth/2) * sin(CGFloat(i + 1) * CGFloat.pi / 3) - circleWidth/2 + CGFloat(self.view.frame.size.height/2)
        }
        
        let nameArray = ["B", "B♭", "A", "A♭", "G", "F#", "F", "E", "E♭", "D", "C#", "C"]
        var nameX = self.view.frame.size.width/2 + setWidth/2 + 2*distanceApart + circleWidth
        var nameY = self.view.frame.size.height/2 - circleWidth/2
        for i in 0..<12{
            var nameButton = UIButton(frame: CGRect(x: nameX, y: nameY, width: circleWidth, height: circleWidth))
            nameButton.titleLabel?.font = UIFont.systemFont(ofSize: textFont)
            nameButton.backgroundColor = self.lightGreenShade
            nameButton.layer.cornerRadius = nameButton.bounds.size.width/2;
            nameButton.setTitle(nameArray[i], for: .normal)
            nameButton.addTarget(self, action: #selector(PianoViewController.noteNamePressed), for: .touchDown)
            nameButton.tag = i
            chordView.addSubview(nameButton)
            nameX = (setWidth/2 + 2*distanceApart + 1.5*circleWidth) * cos(CGFloat(i + 1) * CGFloat.pi / 6) - circleWidth/2 + CGFloat(self.view.frame.size.width/2)
            nameY = (setWidth/2 + 2*distanceApart + 1.5*circleWidth) * sin(CGFloat(i + 1) * CGFloat.pi / 6) - circleWidth/2 + CGFloat(self.view.frame.size.height/2)
        }
        
        let typeArray = ["minor", "major", "dim.", "aug."]
        var typeX = typeRadius * cos(CGFloat.pi / 3) - typeWidth/2 + CGFloat(self.view.frame.size.width/2)
        var typeY = typeRadius * sin(CGFloat.pi / 3) - typeWidth/2 + CGFloat(self.view.frame.size.height/2)
        for i in 0..<4{
            var typeButton = UIButton(frame: CGRect(x: typeX, y: typeY, width: typeWidth, height: typeWidth))
            typeButton.titleLabel?.font = UIFont.systemFont(ofSize: textFont)
            typeButton.backgroundColor = self.lightBlueShade
            typeButton.layer.cornerRadius = typeButton.bounds.size.width/2;
            typeButton.setTitle(typeArray[i], for: .normal)
            typeButton.addTarget(self, action: #selector(PianoViewController.typePressed), for: .touchDown)
            typeButton.tag = i
            chordView.addSubview(typeButton)
            if i == 0 {
                typeX = typeRadius * cos(2 * CGFloat.pi / 3) - typeWidth/2 + CGFloat(self.view.frame.size.width/2)
                typeY = typeRadius * sin(2 * CGFloat.pi / 3) - typeWidth/2 + CGFloat(self.view.frame.size.height/2)
            }else if i == 1 {
                typeX = typeRadius * cos(4 * CGFloat.pi / 3) - typeWidth/2 + CGFloat(self.view.frame.size.width/2)
                typeY = typeRadius * sin(4 * CGFloat.pi / 3) - typeWidth/2 + CGFloat(self.view.frame.size.height/2)
            }else{
                typeX = typeRadius * cos(5 * CGFloat.pi / 3) - typeWidth/2 + CGFloat(self.view.frame.size.width/2)
                typeY = typeRadius * sin(5 * CGFloat.pi / 3) - typeWidth/2 + CGFloat(self.view.frame.size.height/2)
            }
        }
    }
    
    @objc func pressed(sender: UIButton!){
        if sender.backgroundColor == UIColor.white{
            sender.backgroundColor = self.whiteGrayShade
        }else if sender.backgroundColor == self.lightPurpleShade {
            sender.backgroundColor = self.darkPurpleShade
        }else if sender.backgroundColor == self.darkPurpleShade {
            sender.backgroundColor = self.darkPurpleShade
        }else if sender.backgroundColor == self.whiteGrayShade {
            sender.backgroundColor = self.whiteGrayShade
        }else{
            sender.backgroundColor = self.blackGrayShade
        }
        if midiBool == true {
            var sequence : MusicSequence? = nil
            var musicSequence = NewMusicSequence(&sequence)
            var track : MusicTrack? = nil
            var musicTrack = MusicSequenceNewTrack(sequence!, &track)
            // Adding notes
            let x: UInt8 = UInt8(sender.tag)
            let time = MusicTimeStamp(0.0)
            var note = MIDINoteMessage(channel: 0, note: x, velocity: 64, releaseVelocity: 0, duration: 0.75)
            musicTrack = MusicTrackNewMIDINoteEvent(track!, time, &note)
            // Creating a player
            var musicPlayer : MusicPlayer? = nil
            var player = NewMusicPlayer(&musicPlayer)
            player = MusicPlayerSetSequence(musicPlayer!, sequence)
            player = MusicPlayerStart(musicPlayer!)
        }else{
            var keyboard: AVAudioPlayer!
            let path = Bundle.main.path(forResource: "\(sender!.tag).aifc", ofType:nil)!
            let url = URL(fileURLWithPath: path)

            do {
                keyboard = try AVAudioPlayer(contentsOf: url)
                keyboards[sender!.tag - 21] = keyboard
                keyboard?.play()
            } catch {
                // couldn't load file :(
            }
        }
        delay(1.5){
            if sender.backgroundColor == self.whiteGrayShade {
                sender.backgroundColor = UIColor.white
            }else if sender.backgroundColor == UIColor.white {
                sender.backgroundColor = UIColor.white
            }else if sender.backgroundColor == self.blackGrayShade {
                sender.backgroundColor = UIColor.black
            }else if sender.backgroundColor == UIColor.black {
                sender.backgroundColor = UIColor.black
            }else{
                sender.backgroundColor = self.lightPurpleShade
            }
        }
    }
    
    @objc func released(sender: UIButton!){
        delay(0.1){
            if sender.backgroundColor == self.whiteGrayShade {
                sender.backgroundColor = UIColor.white
            }else if sender.backgroundColor == UIColor.white {
                sender.backgroundColor = UIColor.white
            }else if sender.backgroundColor == self.blackGrayShade {
                sender.backgroundColor = UIColor.black
            }else if sender.backgroundColor == UIColor.black {
                sender.backgroundColor = UIColor.black
            }else{
                sender.backgroundColor = self.lightPurpleShade
            }
        }
        delay(0.3){
            self.keyboards[sender!.tag - 21].stop()
        }
    }
    
    func delay(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    @objc func midiPressed(sender: UIButton!){
        if midiBool == false {
            sender.backgroundColor = UIColor(displayP3Red: 128.0 / 255.0, green: 128.0 / 255.0, blue: 128.0 / 255.0, alpha: 0.5)
            midiBool = true
        }else{
            sender.backgroundColor = pinkShade
            midiBool = false
        }
    }
    
    @objc func chordPressed(sender: UIButton!){
        chordView.alpha = 1.0
    }
    
    @objc func namePressed(sender: UIButton!){
        if nameBool == false {
            nameBool = true
            sender.backgroundColor = UIColor(displayP3Red: 128.0 / 255.0, green: 128.0 / 255.0, blue: 128.0 / 255.0, alpha: 0.5)
            for var x in scroll.subviews {
                if x.tag == 10000 {
                    x.alpha = 1.0
                }
            }
        }else{
            nameBool = false
            sender.backgroundColor = pinkShade
            for var x in scroll.subviews {
                if x.tag == 10000 {
                    x.alpha = 0.0
                }
            }
        }
    }
    
    @objc func clearPressed(sender: UIButton!){
        octaveBool = false
        noteNameBool = false
        typeBool = false
        chordArray = []
        startingNote = 0
        interval1 = 0
        interval2 = 0
        for var x in scroll.subviews {
            if x.tag % 12 == 1 || x.tag % 12 == 3 || x.tag % 12 == 6 || x.tag % 12 == 8 || x.tag % 12 == 10{
                x.backgroundColor = UIColor.black
            }else{
                x.backgroundColor = UIColor.white
            }
            if x.tag == 10000 {
                x.backgroundColor = UIColor.white.withAlphaComponent(0)
            }
        }
        for var x in chordView.subviews {
            if x.backgroundColor == self.darkYellowShade {
                x.backgroundColor = self.lightYellowShade
            }
            if x.backgroundColor == self.darkGreenShade {
                x.backgroundColor = self.lightGreenShade
            }
            if x.backgroundColor == self.darkBlueShade {
                x.backgroundColor = self.lightBlueShade
            }
        }
        chordView.alpha = 0.0
    }
    
    //buttons in the chord maker view
    @objc func octavePressed(sender: UIButton!){
        chordArray = [95 - (sender.tag*12), 94 - (sender.tag*12), 93 - (sender.tag*12), 92 - (sender.tag*12), 91 - (sender.tag*12), 90 - (sender.tag*12), 89 - (sender.tag*12), 88 - (sender.tag*12), 87 - (sender.tag*12), 86 - (sender.tag*12), 85 - (sender.tag*12), 84 - (sender.tag*12)]
        for var x in chordView.subviews {
            if x.backgroundColor == self.darkYellowShade {
                x.backgroundColor = self.lightYellowShade
            }
        }
        sender.backgroundColor = self.darkYellowShade
        if octaveBool == false {
            octaveBool = true
        }
    }
    
    @objc func noteNamePressed(sender: UIButton!){
        if octaveBool == true {
            startingNoteTag = sender.tag
            for var x in chordView.subviews {
                if x.backgroundColor == self.darkGreenShade {
                    x.backgroundColor = self.lightGreenShade
                }
            }
            sender.backgroundColor = self.darkGreenShade
            if noteNameBool == false {
                noteNameBool = true
            }
        }
    }
    
    @objc func typePressed(sender: UIButton!){
        typeTag = sender.tag
        if noteNameBool == true {
            for var x in chordView.subviews {
                if x.backgroundColor == self.darkBlueShade {
                    x.backgroundColor = self.lightBlueShade
                }
            }
            sender.backgroundColor = self.darkBlueShade
            if typeBool == false {
                typeBool = true
            }
        }
    }
    
    @objc func setPressed(sender: UIButton!){
        if octaveBool == true && noteNameBool == true && typeBool == true {
            startingNote = chordArray[startingNoteTag]
            if typeTag == 0 {
                interval1 = 3
                interval2 = 4
            }else if typeTag == 1 {
                interval1 = 4
                interval2 = 3
            }else if typeTag == 2 {
                interval1 = 3
                interval2 = 3
            }else{
                interval1 = 4
                interval2 = 4
            }
            for var x in scroll.subviews {
                if x.tag == startingNote || x.tag == startingNote + interval1 || x.tag == startingNote + interval1 + interval2 {
                    x.backgroundColor = self.lightPurpleShade
                }
            }
            chordView.alpha = 0.0
        }
    }
    
}

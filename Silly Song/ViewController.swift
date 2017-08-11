//
//  ViewController.swift
//  Silly Song
//
//  Created by Katie Fedoseeva on 7/30/17.
//  Copyright © 2017 Katie Fedoseeva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleBox: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    @IBOutlet weak var enterBtn: UIButton!
    @IBAction func enterButton(_ sender: UIButton) {
        displayLyrics(sender: enterButton)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }

    @IBAction func displayLyrics(_ sender: Any) {
        if nameField != nil {
            let name = nameField.text
            let lyricsToView = lyricsFromName(lyricsTemplate: bananaFanaTemplate, fullName: name!)
            lyricsView.text = lyricsToView
        }
    }

}

//returns short name from long name.
func shortNameFromName(name: String) -> String {
    var shortName = ""
    let vowels = "aeiouAEIOU"   //both lowercase and uppercase version of characters included.
    //   var lowercaseName = name.lowercased() //making sure it's lower case.
    
    var normalizedName = name.folding(options: [.diacriticInsensitive], locale: nil)       //returns normalized String.
    
    for character in normalizedName.characters {
        
        if !vowels.characters.contains(character){
            normalizedName.remove(at: normalizedName.startIndex) //go through each character and remove all the consonants at startIndex.
        } else {
            shortName = normalizedName.lowercased()
            break   //exit loop when there is a vowel.
        }
    }
    return shortName
}

// SillySong lyrics template
let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")


// 'lyricsFromName' function generates lyrics when a name is entered.
func lyricsFromName(lyricsTemplate: String, fullName: String) -> String {
    var personalizedLyrics = ""
    let lyricsTemplate = bananaFanaTemplate
    let fullName = fullName
    let shortName = shortNameFromName(name: fullName)
    
    personalizedLyrics = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName)
    personalizedLyrics = personalizedLyrics.replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return personalizedLyrics
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

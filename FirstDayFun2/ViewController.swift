//
//  ViewController.swift
//  FirstDayFun2
//
//  Created by Benjamin Bakhash on 7/15/20.
//  Copyright © 2020 Benjamin Bakhash. All rights reserved.
//

import UIKit
import SpriteKit

var serves = 0;

var totalserves = "Total serves: "

var serveInfo = [180, 7, 22]

var playerNames = ["Jenny", "Bob", "Shelly", "Fred"]

// This is creating an array whithout any elements in it
//were simply stating what type is going to be inside the array
var balls = [Int]()




class ViewController: UIViewController {
    
    // Class Scope Level variables
                    //   0     1     2    3
    let scoreInfo = ["LOVE", "15", "30", "40"]
                  //        0       1     2
    let scoreEndInfo = ["DUCE", "ADV", "-"]
    //outlet area
                           
    @IBOutlet weak var Serveslabel: UILabel!
    

    @IBOutlet weak var skView: SKView!
    
    
    @IBOutlet weak var Pgames: UILabel!
    
    @IBOutlet weak var Cgames: UILabel!
    
    // lets connect to the
    // players game points
    @IBOutlet weak var playerGPOutlet: UILabel!
    
    
    @IBOutlet weak var tslabel: UILabel!
    
    
    
    @IBOutlet weak var compterGPOutlet: UILabel!
    
    
    
    
    // lets connect an IBAction
    //For new ball!
    
    
    

    @IBAction func Newball(_ sender: Any) {
        
        print("New Ball")
        
        ball.size.width = ballOrigWidth
        ball.size.height = ballOrigHeight
    }
    
    
    
    @IBOutlet weak var totalserveslabel: UIView!
    
    @IBOutlet weak var serveButton: UIButton!
    
    
    @IBOutlet weak var goserve: UIButton!
    
    
    @IBAction func goserve2(_ sender: Any) {
        
        print("Prepare for Serve")
        
        serves += 1;
        
        print("Total serves are \(serves).")
   
        
        tslabel.text = "\(totalserves) \(serves)"
           
        
        
        Serveslabel.text = String(serves)
        
        
        print("\n Prepare to show serveInfo...")
        print ("serveInfo at the index of zero: \(serveInfo[0])")
        print("serveInfo at the index of one : \(serveInfo[1])")
        
        print("\n Team Number 1")
        print("Doubles Match!")
        print("Team 1: Player 1 \(playerNames[0])")
        print("Team 1: Player 2 \(playerNames[1])")
             
        
        print("\n Team Number 2")
        print("Team 2: Player 1 \(playerNames[2])")
        print("Team 2: Player 2 \(playerNames[3])")
             
        print("\n The count of elements in the serveInnfo array is: \(serveInfo.count)")
        print("The count of elements in the playerNames array is: \(playerNames.count)")
        
        print("The count of elements in the ball array is: \(balls.count)")
    }
    
  
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
  
        // connect to myscene
        
        let scene = MYscene(size:CGSize(width: 192, height: 440))
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
          //  Serveslabel.text = String(serves)
        
        
        
        print("Tennis program")
    
        print("Total initial serves \(serves)")
    
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats:true) { (timer) in
            
            // Do what you need to do repeatedly
            // semantic reference to self... is required
            // because were in a closure / callback
            self.displayScores()
            // end of the timer
        }
        
        // end of the viewDidLoad() method
        
    }
    
    func getScoreDiff() -> Bool {
        
        // let's check to see if the plauer has more than 40!
        
        let points = playerScore[2]
        let aiPoints = computerScore[2]
        
        
        
        /*
         
         BEN    [ADV]
         CPU    [ - ]
         
         BEN    [ - ]
         CPU    [ADV]
         
         BEN    [DUCE]
         CPU    [DUCE]
        
         BEN    [40]
         CPU    [30]
         */
        
        // 0         1   2     3 --> at 4  you won a game
        // Love     15   30   40
        // if the polayers points are 4 or more
        if ( points > 3) || (aiPoints > 3) {
        
            // the player might have just won a game!
            //Because the Player has one more points than 40
            // and the AI has 30 or less!
          
            // the player DID win a game
     
                
            let diff = points - aiPoints
            if ( diff >= 2) {
                // at this point we know the player won the game!
                //because the ai didn't make it to 40
                // reset the player's points
                playerScore[2] = 0
                // player won the game
                playerScore[1] += 1
                    
                // reset the computer's points points but dont give him a game
                computerScore[2] = 0
                            
                //end of the aiPoints is less than or equal to 2 check
                print(" The Human Player won a game!")
            }
            // lets just sau I got more than 40
            // and the AI is at 40
            // end of the points is greater than 3 check
            // this simply menas we're now at advantage!
            //TODO
                
            // the players points minus the ai points is exactly one!!
            else if(diff == 1) {
                playerGPOutlet.text = "ADV"
                compterGPOutlet.text = " - "
                    
            }
                
            else if diff == 0 {
                playerGPOutlet.text = "DUCE"
                compterGPOutlet.text = "DUCE"
            }
         
            else if diff == -1 {
                playerGPOutlet.text = " - "
                compterGPOutlet.text = "ADV"
            }
                
                //AI won a game
                
                    
            else {
                computerScore[2] = 0
                    
                computerScore[1] += 1
                   
                playerScore[2] = 0
                  
            }
          //This means we will return true if someone got more than 3 pooints :D
            return true
            //end of points greater than 3 check
        }
        // defualt return---meaning if no other returns take place it does this
        return false
        // end of the get score difference method
    }

    func displayScores() {
        
        let pScore = playerScore[2]
        let cScore = computerScore[2]
        
        // Should we use the modified scoring system
        //becuase maybe someone has 40 or more points
      
        if !getScoreDiff() {
            let pVal = scoreInfo[pScore]
            let cVal = scoreInfo[cScore]
            
            

            playerGPOutlet.text = pVal
            compterGPOutlet.text = cVal

            
        }
    }
    
    
// end of the ViewController class

}



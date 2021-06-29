

//
//  MYscene.swift
//  FirstDayFun2
//
//  Created by Benjamin Bakhash on 8/12/20.
//  Copyright © 2020 Benjamin Bakhash. All rights reserved.
//

        import UIKit
        import SpriteKit



        var ball = SKSpriteNode(imageNamed: "ball")


        var ballUp = false;


        var ballOrigWidth = CGFloat(0.1)
        var ballOrigHeight = CGFloat(0.1)

        var player = SKSpriteNode(imageNamed: "racquet_right")

        var computer = SKSpriteNode(imageNamed: "racquet_left")

        var bg = SKSpriteNode(imageNamed: "court")

        // index info   0     1     2
        //           [set, games, points]
        var playerScore = [0, 0, 0];
        var computerScore = [0, 0, 0];

        // how fast can the ai move?
        let aiSpeed = CGFloat(2.0)

        /*
        LOVE 15 30 40 GAME
        0    1  2  3
        You never lose  a point
 
        40-40 DUCE -> ADVANTAGE   Will do this after the array is working

 
        */
        //y is always going to change by 1...
        // The ball's x posistion might
        // begin myscene
        //These will be temproray varivales
        // reperesenting the posistion ->
        //just in case there are integer division issues
        var BX = 0.0;
        var BY = 0.0;
        // the balll has a velocity X of 0.0 ----- so it moves straight up and down
        var BVX = 0.2;
        var BVY = 1.0;
        class MYscene: SKScene {

    
    
        override func didMove(to view: SKView){
        
        print ("Move to MYscene was successful")
   
        backgroundColor = SKColor.green
        
        
        bg.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        bg.size = CGSize(width: size.width, height: size.height)
        addChild(bg)
    
        ball.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        ball.size = CGSize(width: size.width / 4, height: size.width / 4)
        addChild(ball)
    
        
        
        ballOrigWidth = ball.size.width
        ballOrigHeight = ball.size.height
        
        
        
        //2.A. position, size and add the player
        
        player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.25)
        player.size = CGSize(width: size.width / 4, height: size.width / 4)
        addChild(player)
        
        // 2.B. Position, size and the computer
            computer.position = CGPoint(x: size.width * 0.5, y: size.height * 0.83 )
        computer.size = CGSize(width: size.width / 5, height: size.width / 5)
        addChild(computer)
        // end of the didMove
    
        }
    
    
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    
        guard let touch = touches.first else {
            return
        }
            
        let touchLocation = touch.location(in: self)
          
       // print( "the touch location is: \(touchLocation)")
            
        let ballTouch = ball.contains(touch.location(in: self));
        let raquetTouch = player.contains(touch.location(in: self));
        if ballTouch && raquetTouch {
            print("Player hit the balll!")
            ball.position.y += player.size.height
            
            // randomice the ball X velocity when the player
            // hits it as well
            
            randomBVX()
            
            ballUp = true
        
        // end of touches method do not delete!
        
        }
        
            
        
        player.position.x = touchLocation.x
            
        
        player.position.y = touchLocation.y
            
            
            
    
        
        // reposotion racquest if it leaves the left end of the screen
        if player.position.x < player.size.width / 3{
            player.position.x = player.size.width / 3
        }
        // make temporary variables to make repostioning the
        //raqueteasier!
        
        
        //What is half of the width of the player?
        let halfPlayerWidth = player.size.width / 2
        let raquetRightSide = player.position.x + halfPlayerWidth
        let tooFarRight = bg.position.x + ( bg.size.width / 2 )
        if raquetRightSide >= tooFarRight {
            
        player.position.x = tooFarRight - halfPlayerWidth
            
        }
        
            
            //DEaling with going too far up
            let halfPlayerHeight = player.size.height / 2
            let RaquetTop = player.position.y + halfPlayerHeight
            let RaquetBottom = player.position.y - halfPlayerHeight
            let tooFarUp = (bg.position.y + (bg.size.height / 2)) / 2
            
            //print("T
            
            if RaquetTop >= tooFarUp {
                
                player.position.y = tooFarUp - halfPlayerHeight
            
            
                
            } else{
                
                player.position.y = touchLocation.y 
            }
            
            if RaquetBottom < bg.position.y - (bg.size.height / 2) {
                player.position.y = bg.position.y - (bg.size.height / 2) + player.size.height
            }
            
        // end of the touches moved method
        }
    
 
    
    
        //Mark: Touch Logic -> touchesBegan
    
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    
        guard let touch = touches.first else {
            return
        }
            
        let touchLocation = touch.location(in: self)
          
        print( "the touch location is: \(touchLocation)")
        
 
        //End of the ball touch method
        }
    
    
        func resetBall() {
            BVX = 0.0
            ball.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        player.size = CGSize(width: size.width / 4, height: size.width / 4)
            // the ball is heading from the computer to the player
            ballUp = false;
            
        }
        // begin the randomize Ball Velocity X
        func randomBVX() {
        
        //This will give a random number
        //between zero and 1.5 not inclusive on the upper bound
        // that means the biggest number can be
        // is 1.49999999999999999999999999999999999999999999999
        // double is the data type
        // random is a method that belongs to the double class
        var temp = Double.random(in: 0..<1.5)
        // data types
        //wrapper classees for data types
        
        // should the ball go left
        
        let goLeft = Bool.random()
    
        // if the boolean of goLeft is true
        // then reverse the temp varbiable by -1
            
        if goLeft {
            temp *= -1
        }
        
        // readdigbn the Ball Velocity  X to be
        // the valuse of temp :D (smile)
        BVX = temp
        
        // end randomize ball velocity X method
        }

        // began aiUpdate
        
        func aiUpdate(){

        // check for the distance between the ai's center ant the ball
        
        let dist = ball.position.x - computer.position.x
   
        //should we move the racquet for the computer?
        if ( dist > 1) {
        
            computer.position.x += aiSpeed
        }
    
        
        else if ( dist < 1) {
            computer.position.x -= aiSpeed
        }
  
        if ( ballUp && computerHit(ball: ball, computer: computer ) ){
        ballUp = false
            }
    
        
        }
            
            
            
    override func update(_ currentTime: TimeInterval) {
        
        
            //If the ball is at zero or size.width then out is out of bounds
            
        
        // is the ball out of bounds to the left
        let OOBLeft =  ball.position.x < 0
        if ( OOBLeft ) {
     
        print ("The ball is out of bounds on the left alley!")
           
            resetBall()
            
            if (ballUp) {
                print("The human player hit the ball out of bounds!")
          //computer gets a point
                // TODO_> convert into function call
                computerScore[2] += 1
                
            } else {
            
                print(" The AI hit the ball out of bounds!")
                playerScore[2] += 1
            
            
            }
        //end of OOBLeft
        }
        
        let OOBRight = ball.position.x > size.width
        if ( OOBRight ) {
            print("The ball is out of bounds on the right alley!")
            resetBall()
            
            
            if (ballUp) {
                print("The human player hit the ball out of bounds!")
          //computer gets a point
                // TODO_> convert into function call
                computerScore[2] += 1
                
            } else {
            
                print("The AI hit the ball out of bounds!")
                playerScore[2] += 1
            // end of the OOBRight
            
            }
        }
            
        
        
            //right now BVY will always be positive
            // since we already made a boolean to help with the work
        if ballUp {
            ball.position.y += CGFloat(BVY)
        } else {
            ball.position.y -= CGFloat(BVY)
        }
            // BVX may be negitive OR positive
            ball.position.x += CGFloat(BVX)
            
            aiUpdate ()
        // print(ball.position.y)
        
        let y_center = size.height / 2
        let y_ball = ball.position.y
        
        var dist = abs(y_center - y_ball)
         //print("The distance from center is : \(dist)")
        
                //save this algorithim for a ground bound
        var ratio = (dist / y_center)
        ratio = pow(ratio, -1)
        
        ratio *= 0.2
            
            if ( dist < 25) {
                dist = 25
            }
            
        let W = ballOrigWidth * ratio + 3
        let H = ballOrigWidth * ratio + 3
        // print("The ratio : \(ratio)")

        ball.size = CGSize(width: W, height: H)
         

        
        // the ball went out of bounds on which side
        if ball.position.y < 0 {
            resetBall()
        
        print("\nAI gets one point!")
        
        // what index correlates to the GAME POINT
        // 0  1  2  ?
        computerScore[2] += 1
            
        //New code
        //protect from out of bounds
        if ( computerScore[2] > 3) {
        computerScore[2] = 3;
        }
        } else if ball.position.y > size.height {
        resetBall()
          
        print("\nPlayer gets one point!")
        playerScore[2] += 1
        
        if ( playerScore[2] > 3) {
            playerScore[2] = 3;
        }
        }
        // End of function updated
        }
   
    
        // has the ai computer racquet hit the ball
    
    
        
    // keyword  func name
    func computerHit(ball: SKSpriteNode, computer: SKSpriteNode) -> Bool {
        let inside = computer.contains(ball.position)
        // add if else logic here!
        if ( inside ) {
            
            // randomize the ball velocity only if the computer hit the ball
            randomBVX()
            print("Computer hit the ball!")
            return true
      
        }else{
            return false
        //end of inside check
        }
            // this fuinction will process a point in the current game for the player
           
    // end of computerHit method
    }
    func playerScored() {
       
        // the player has recieved a point
        playerScore[2] += 1
        
    }

            
// end of MYScene
}


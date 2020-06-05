import SpriteKit
import GameplayKit

var recordData:String!
var right:Bool = false
var left:Bool = false

struct PhysicsCategory {
    static let none : UInt32 = 0
    static let all  : UInt32 = UInt32.max
    static let grandpa : UInt32 = 0b1 // 1
    static let floor : UInt32 = 0b10 // 2
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    override func didMove(to view: SKView) {
        // define a cor do fundo base
        backgroundColor = SKColor.gray
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch = touches.first!
        let location = touch.location(in: self)
        
        if(location.x < frame.midX)
        {
         right = false
         left = true
        }
        else{
            right = true
            left = false
        }
    }
}




func saveScore(){
    if(recordData == nil)
    {
        let savedString = "place holder"
        let userDefaults = Foundation.UserDefaults.standard
        userDefaults.set(savedString, forKey: "BestScore")
        
    }
    else
    {
        //let score:Int? = Int(scorelable.text!)
        //let record:Int? = Int(recordData)
        //if(score! > record!){
          //  let savedString = "place holder"
            //let userDefaults = Foundation.UserDefaults.standard
            //userDefaults.set(savedString, forKey: "BestScore")        }
        
    }
    
    
    
    
    
    
}

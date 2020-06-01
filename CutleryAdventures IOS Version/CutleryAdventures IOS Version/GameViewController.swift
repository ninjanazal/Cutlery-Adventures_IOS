//
//  GameViewController.swift
//  CutleryAdventures IOS Version
//
//  Created by ninjanazal on 01/06/2020.
//  Copyright © 2020 goBig. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    //MARK: View Controller START
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // cria uma instancia da GameScene
            let scene = GameScene(size: view.bounds.size)
            // define o tipo de escalamento
            scene.scaleMode = SKSceneScaleMode.resizeFill
            
            // indica que ignora a ordem de pais e filhos
            view.ignoresSiblingOrder = true;
            view.showsFPS = true
            view.showsNodeCount = true
            
            // apresenta a cena
            view.presentScene(scene)
            }
        }
    
    // indica que nao deve rodar a imagem de acordo com a orientaçao do phone
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

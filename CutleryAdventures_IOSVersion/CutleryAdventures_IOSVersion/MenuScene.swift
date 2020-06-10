import SpriteKit
import GameKit

// scena de menu
class MenuScene : SKScene{
    //MARK: HardCodedValues
    let uiMargin : CGFloat = 10.0    // margem entre elementos de Ui
    //MARK: SceneVars
    var cutleryAdventureLogo, backGroundImage : SKSpriteNode!
    var bestScoreLabel, bestScoreValueLabel : SKLabelNode!
    var playButton, creditsBtn : SKSpriteNode!
    
    
    
    override func didMove(to view: SKView) {
        // define a cor do fundo base
        backgroundColor = SKColor.white
        
        // inicia o menu
        InitMenu()
    }
    
    //MARK: Init MenuScene
    private func InitMenu(){
        // carrega elementos nao interactivos
        LoadNonInteractables()
        // carrega elementos interactivos
        LoadInteractables()
        LoadScore()
    }
    
    //MARK: Init NonInteractables
    private func LoadNonInteractables(){
        //MARK: Logo Load
        // carrega e posiciona o logo
        cutleryAdventureLogo = SKSpriteNode(imageNamed: "CutleryAdventureLogo")
        // define a posiçao do logo, 80% da altura maxima
        cutleryAdventureLogo.position = CGPoint(x: frame.size.width / 2,
            y: frame.size.height * 0.95 - cutleryAdventureLogo.size.height / 2)
        // coloca o logo na frente
        cutleryAdventureLogo.zPosition = 5
        // adiciona o logo á cena
        self.addChild(cutleryAdventureLogo)
        
        //MARK: Background Load
        // carrega e posiciona o background
        backGroundImage = SKSpriteNode(imageNamed: "background")
        //define a posiçao do background, está centrado sobre a vista
        backGroundImage.position = CGPoint(x: frame.size.width / 2 , y: frame.size.height / 2)
        // define o tamanho correcto para a imagem
        backGroundImage.size = CGSize(width: frame.size.width, height: frame.size.height)
        
        // adiciona o background á cena
        self.addChild(backGroundImage)
        
        // MARK: BestScore Display
        SetBestScoreDisplay()
    }
    
    private func SetBestScoreDisplay(){
        // label indica o melhor score
        bestScoreLabel = SKLabelNode(text: "Best Score!")
        bestScoreLabel.fontSize = 42   // define o tamanho da fonte
        bestScoreLabel.color = .white
        
        // label que mostra o valor do melhor score
        bestScoreValueLabel = SKLabelNode()
        
        // MARK: TODO -> ConnectValues
        //----- :: TODO :: LOAD VALUE FROM FILE ------ //
        bestScoreValueLabel.text = "0"      // a ser removido <<<< ---------
        bestScoreValueLabel.fontSize = 40   // define o tamanho da fonte
        bestScoreValueLabel.color = .white
        
        // define a posiçao das labels
        bestScoreValueLabel.position = CGPoint(x: frame.size.width * 0.5, y: frame.size.height * 0.5)
        bestScoreValueLabel.zPosition = 5   // coloca na frente
        bestScoreLabel.position = CGPoint(x: bestScoreValueLabel.position.x, y: bestScoreValueLabel.position.y + bestScoreValueLabel.frame.height + uiMargin)
        bestScoreLabel.zPosition = 5        // coloca na frente
        
        // adiciona as labels á cena
        self.addChild(bestScoreValueLabel)
        self.addChild(bestScoreLabel)
       
        
        
    }
    
    
    //MARK: Init Intectables
    private func LoadInteractables(){
        //MARK: PlayBtn Load
        // carrega a imagem do botao de play
        playButton = SKSpriteNode(imageNamed: "play_btn")
        // atribui um nome ao node
        playButton.name = "playButton"
        // define a posiçao do butao
        playButton.position = CGPoint(x: frame.size.width * 0.5, y: frame.size.height * 0.15 + playButton.size.height * 0.5)
        // coloca o butao na frente
        playButton.zPosition = 5
        // adiciona á cena
        self.addChild(playButton)
        
        // MARK: CreditsBtn
        // carrega a imagem do botao de play
        creditsBtn = SKSpriteNode(imageNamed: "play_btn")
        // atribui um nome ao node
        creditsBtn.name = "creditsBtn"
        // define a escala do botao
        creditsBtn.xScale = 0.4
        creditsBtn.yScale = 0.8
        // define a posiçao do botao
        creditsBtn.position = CGPoint(x: frame.size.width - creditsBtn.size.width * 0.25,
                                      y: frame.size.height * 0.2)
        // coloca o botao na frente
        creditsBtn.zPosition = 5
        
        // adiciona o botao á cena
        self.addChild(creditsBtn)
    }
    
    //MARK: Touch response
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // guarda o primeiro toque da lista, caso exista
        guard let touch = touches.first else {return}
        // guarda a localizaçao do toque
        let touchLocation = touch.location(in: self)
        // guarda o node em que ocorreu o toque
        let touchedNode = atPoint(touchLocation)
        
        // avalia de acordo com o nome do node em que tocou
        switch touchedNode.name {
        case "playButton":
            // troca de scena para a de jogo
            SwitchToGameScene()
        case "creditsBtn":
            // troca para a scena de creditos
            SwitchToCredits()
        default:
            // caso nao tenha tocado em nenhum node relevante
            return
        }
    }
    
    // metodo para a troca de scena
    private func SwitchToGameScene(){
        // define a transiçao
        let transition = SKTransition.push(with: .left, duration: 0.6)
        // define a scena a carregar
        let scene = GameScene(size: size)
        // mostra a cena com a transiçao definida
        self.view?.presentScene(scene, transition: transition)
    }
    // metodo para trocar para creditos
    private func SwitchToCredits(){
        // define a transiçao
        let transition = SKTransition.push(with: .left, duration: 0.6)
        // define a scena a carregar
        let scene = CreditsScene(size: size)
        // mostra a cena com a transiçao definida
        self.view?.presentScene(scene,transition: transition)
    }
    
    func LoadScore(){
        let userDefaults = Foundation.UserDefaults.standard
        let newScore = userDefaults.string(forKey: "BestScore")
        
        if(newScore == nil){
            bestScoreValueLabel.text = "0"
        }else
        {
            bestScoreValueLabel.text = newScore
        }
    }
}

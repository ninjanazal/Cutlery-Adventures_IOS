import SpriteKit
import GameKit

class EndGameScene: SKScene {
    //MARK: HardCoded var
    var labelSpacing : CGFloat = 0.05     // relativo ao tamanho do ecra
    //MARK: Internal Logic
    var playerScore : Double = 0   // pontuaçao do jogador
    
    //MARK: Scene Vars
    var backgroundImage, gameLogo : SKSpriteNode!
    var scoreLabelInfo, currentScoreLabel  : SKLabelNode!
    var playAgainBtn, goBackBtn : SKSpriteNode!
    
    //MARK: Scene Init
    // iniciador da cena
    init(size: CGSize,score : Double) {
        super.init(size: size)
        // aguarda a pontuaçao alcançada
        self.playerScore = score
    }
    // Handler de erro para um customInit
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: didMove
    // ao instanciar
    override func didMove(to view: SKView) {
        // define o fundo da scena
        backgroundColor = UIColor.white
        
        // inicia a cena
        InitScene()
    }
    
    //MARK: Private Method
    // inicaçao da cena
    private func InitScene(){
        // define o fundo da cena
        backgroundImage = SKSpriteNode(imageNamed: "background")
        // define a posiçao do fundo
        backgroundImage.position = CGPoint(x: frame.size.width * 0.5, y: frame.size.height * 0.5)
        // define o tamanho da imagem
        backgroundImage.size = CGSize(width: frame.size.width, height: frame.size.height)
        // define a posiçao horizontal da cena
        backgroundImage.zPosition = 0
        
        // adiciona o elemento á cena
        self.addChild(backgroundImage)
        
        // define o logo do jogo
        gameLogo = SKSpriteNode(imageNamed: "CutleryAdventureLogo")
        // define a posiçao do logo
        gameLogo.position = CGPoint(x: frame.size.width * 0.5, y: frame.size.height - gameLogo.size.height)
        // define a posiçao de profundidade
        gameLogo.zPosition = 5
        
        // adiciona á cena
        self.addChild(gameLogo)
        
        // inicia as labels
        LabelsInit()
        // inicia os botoes
        InitBtns()
    }
    
    //MARK: Init Labels
    // iniciaçao de elementos de texto
    private func LabelsInit(){
        // determina o espaçamento de acordo com o tamanho da view
        labelSpacing *= frame.size.height
        
        // define a lable informativa
        scoreLabelInfo = SKLabelNode(text: "Your Score!")
        // define o tamanho da fonte
        scoreLabelInfo.fontSize = 40
        // define a posiçao da label, verticalmente, 80% do ecra
        scoreLabelInfo.position = CGPoint(x: frame.size.width * 0.5, y: gameLogo.position.y - gameLogo.size.height * 0.5 - labelSpacing)
        // define a cor do texto
        scoreLabelInfo.color = .white
        // posiçao profundidade da label
        scoreLabelInfo.zPosition = 5
        
        // adiciona a label á cena
        self.addChild(scoreLabelInfo)
        
        // define a label da pontuaçao
        currentScoreLabel = SKLabelNode(text: String(playerScore))
        // define o tamanho da fonte
        currentScoreLabel.fontSize = 45
        //define a posiçao da label
        currentScoreLabel.position = CGPoint(x: frame.size.width * 0.5,
                                             y: scoreLabelInfo.position.y - scoreLabelInfo.frame.height * 0.5 - labelSpacing)
        // define a cor do texto
        currentScoreLabel.color = .white
        // posiçao profundidade da label
        currentScoreLabel.zPosition = 5
        
        // adiciona a label á cena
        self.addChild(currentScoreLabel)
    }
    
    //MARK: Init Interactables
    // inicia botoes
    private func InitBtns(){
        // define o botao de play again
        playAgainBtn = SKSpriteNode(imageNamed: "play_btn")
        // define o nome do botao
        playAgainBtn.name = "playAgain"
        // define a posiçao do botao
        playAgainBtn.position = CGPoint(x: frame.size.width * 0.5, y: frame.size.height * 0.45)
        // define a profundidade do botao
        playAgainBtn.zPosition = 5
        
        // adiciona o botao á cena
        self.addChild(playAgainBtn)
        
        // go back botao
        goBackBtn = SKSpriteNode(imageNamed: "play_btn")
        // define o nome do botao
        goBackBtn.name = "goBack"
        // define o tamanho
        goBackBtn.xScale = 0.4
        goBackBtn.yScale = 0.8
        // define a posiçao do botao
        goBackBtn.position = CGPoint(x: frame.size.width - goBackBtn.size.width * 0.25,
                                     y: frame.size.height * 0.2)
        // define a profundidade do botao
        goBackBtn.zPosition = 5
        
        // adiciona á cena
        self.addChild(goBackBtn)
    }
    
    //MARK: Input
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // guarda referencia do primeiro toque registado
        guard let touch = touches.first else {return}
        // guarda a localizaçao desse toque
        let touchLocation = touch.location(in: self)
        // guarda a referencia do node presente na localizaçao
        let touchedNode = atPoint(touchLocation)
        
        // switch para todos os possiveis botoes
        switch touchedNode.name {
        case "playAgain":
            // carrega novamente a cena de jogo
            LoadGameScene()
        case "goBack":
            // carrega o menu principal
            LoadMenuScene()
        default:
            return
        }
    }
    //MARK: Input Handlers
    // carrega scena de jogo
    private func LoadGameScene(){
        // define a transiçao
        let transition = SKTransition.push(with: .left, duration: 0.6)
        // define a cena para qual vai mudart
        let scene = GameScene(size: size)
        // muda para a cena com a transiçao definida
        self.view?.presentScene(scene, transition: transition)
    }
    // carrega a cena de menu
    private func LoadMenuScene(){
        // define a transiçao
        let transition = SKTransition.push(with: .left, duration: 0.6)
        // define a cena para qual vai mudar
        let scene = MenuScene(size: size)
        // muda para a cena com a transiçao definida
        self.view?.presentScene(scene, transition: transition)
    }
}

import SpriteKit
import GameplayKit

// dependendia da
var recordData:String!
var right:Bool = true
var left:Bool = false
var down:Bool = false
let userDefaults = Foundation.UserDefaults.standard

struct PhysicsCategory {
    static let none : UInt32 = 0
    static let all  : UInt32 = UInt32.max
    static let grandpa : UInt32 = 0b1 << 0 // 1
    static let floor : UInt32   = 0b1 << 1 // 2
}

// dependendia da
class GameScene: SKScene, SKPhysicsContactDelegate {
    //MARK: Player
    let grandpa = SKSpriteNode(imageNamed: "oldMan")
    var playerDirection : Int = 1   //direcçao do jogador
    var playerSpeed : Double = 225.5  // velocidade do jogador
    
    //MARK: HardCoded Vars
    var scrollSpeed : CGFloat = 150 // velocidade de scroll das plataformas
    var scrollAceleration : Double = 0.22  // aceleraçao do scroll
    
    //MARK: Scene Vars
    var backGroundImage : SKSpriteNode!
    var platformTexture : SKTexture!        // textura das plataformas
    var platformsDistance : CGFloat = 0.3   // distancia entre as plataformas
    var platforms = [Obstacle]()            // array vazio de plataformas
    var justTaplabel, playerScoreLabel : SKLabelNode!         // label que indica para o jogador carregar
    
    //MARK: Logic Vars
    private var lastUpdateTime : CGFloat = 0    // tempo do ultimo update
    private var startPlaying : Bool = false     // indica se o jogo começou
    private var currentScore : Double = 0.00     // score do jogador
    
    //MARK: ONLoad
    override func didMove(to view: SKView) {
        // define a cor do fundo base
        backgroundColor = SKColor.gray
        
        // definiçao do mundo fisico
        physicsWorld.gravity = .zero
        // indica o delegate de colisao
        physicsWorld.contactDelegate = self
        
        // inicia elementos da cena
        InitScene()
    }
    
    //MARK: Update
    override func update(_ currentTime: TimeInterval) {
        // determina o tempo do frame
        let deltaTime = CGFloat(currentTime) - lastUpdateTime
        
        
        let value = userDefaults.string(forKey: "BestScore")
        recordData = value
        
        if(startPlaying){
            // actualiza as plataformas
            UpdateObstacles(deltaTime: deltaTime)
            
            //MARK: Sugestao
            // actualiza a posiçao com base na velocidade e na quantidade de tempo entre frames
            self.grandpa.position.x += CGFloat(playerSpeed) * deltaTime * CGFloat(playerDirection)
          
        
            
        // actualiza o score de jogo
            UpdateScore(Double(deltaTime))
        }
        // atualiza o tempo do fram
        lastUpdateTime = CGFloat(currentTime)
        }
    
    
    //MARK: Late update
    // no final do ciclo, verifica se as plataformas estao posicionadas correctamente
    override func didFinishUpdate() {
        // Confirma se a plataforma continua em vista
        ConfirmObstacleView()
        
        // avalia a posiçao do jogador
        ConfirmPlayerPosition()
    }
    
    //MARK: Init
    private func InitScene(){
        // inicia o background da cena
        backGroundImage = SKSpriteNode(imageNamed: "background")
        // define a posiçao da imagem
        backGroundImage.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        // define o tamanho do fundo para se adaptar ao ecra
        backGroundImage.size = CGSize(width: frame.size.width, height: frame.size.height)
        backGroundImage.zPosition = 1
        // adiciona o background á cena
        self.addChild(backGroundImage)
        
        // gera a label para mostrar ao jogador para iniciar
        justTaplabel = SKLabelNode(text: "Just Tap!")
        // define o tamanho da fonte
        justTaplabel.fontSize = 45
        // define a posiçao da label
        justTaplabel.position = CGPoint(x: frame.size.width * 0.5, y: frame.size.height * 0.5)
        // defina a cor da label
        justTaplabel.color = .white
        // coloca na frente
        justTaplabel.zPosition = 10
        
        // adiciona a label á cena
        self.addChild(justTaplabel)
        
        // gera a label para mostrar a pontuaçao do jogador
        playerScoreLabel = SKLabelNode(text: String(currentScore))
        // define o tamanho da fonte
        playerScoreLabel.fontSize = 45
        // define a posiçao da label
        playerScoreLabel.position = CGPoint(x: frame.size.width * 0.5, y: frame.size.height * 0.90)
        // define a cor da label
        playerScoreLabel.color = .white
        //coloca na frente
        playerScoreLabel.zPosition = 10
        
        // gera plataformas
        GeneratePlatforms()
        
        //MARK: Player
        // posiçao do jogador
        grandpa.xScale = 2
        grandpa.yScale = 2
        grandpa.position = CGPoint(x: frame.midX, y: frame.height - grandpa.size.height * 2)
        grandpa.zPosition = 5
        
        grandpa.physicsBody = SKPhysicsBody(rectangleOf: grandpa.size)
        grandpa.physicsBody?.allowsRotation = false
        grandpa.physicsBody?.categoryBitMask = PhysicsCategory.grandpa
        grandpa.physicsBody?.collisionBitMask = PhysicsCategory.floor
        
        self.addChild(grandpa)
        
        
    }
    
    //MARK: Logica das Plataformas
    //MARK: Iniciador de plataformas
    // metodo que inicia as plataformas
    private func GeneratePlatforms(){
        // define a distancia em pixels entre plataformas de acordo com o tamanho do ecra
        platformsDistance *= frame.height
        // determina quantas plataformas devem ser geradas de acordo com o tamanho do ecra
        // é adicionado um buffer para plataformas que se encontrem fora de vista
        let platformCount : Int = Int(floor(frame.height / platformsDistance)) + 1
        // carrega a textura
        platformTexture = SKTexture(imageNamed: "segment")
        
        // para a quantidade de plataformas determinadas, criar um obstaculo
        for i in 0 ..< platformCount{
            // cria um obj
            // caso seja a primeira plataforma, define a posiçao inicial
            platforms.append(
                Obstacle(lastPlatformHeight: (i == 0) ?
                    frame.height - platformsDistance * 0.15 : platforms[i-1].obstaclePosition.y, texture: platformTexture, distanceFrom: platformsDistance, frame: frame))
            // adiciona o obstaculo criado á cena
            platforms[i].AddToScene(scene: self)
        }
        // indica o numero de segmentos criados
        print("Generated \(platforms.count) segments")
    }
    //MARK: Update das plataformas
    // metodo que actualiza as plataformas
    private func UpdateObstacles(deltaTime : CGFloat){
        // desloca os obstaculos
        // para cada plataforma instanciada
        for i in 0 ..< platforms.count{
            // desloca
            platforms[i].Move(amount: scrollSpeed * deltaTime)
        }
    }
    //MARK: Confirma visivilidade
    // avalia se a plataforma continua dentro de vista
    private func ConfirmObstacleView(){
        // verifica se o primeiro elemento está dentro dos limites
        if(!platforms[0].IsInsideScreen(frame: frame)){
            // se nao estiver este
            platforms[0].RemoveFromScene(scene: self)
            // remove do array
            platforms.removeFirst()
            // adiciona uma nova plataforma no final
            CreateNewObstacle()
        }
    }
    
    //MARK: Cria novas plataformas
    // metodo que cria novos obstaculos
    private func CreateNewObstacle(){
        // adiciona um novo obstaculo á lista
        platforms.append(Obstacle(lastPlatformHeight: platforms[platforms.count - 1].obstaclePosition.y, texture: platformTexture,
            distanceFrom: platformsDistance, frame: frame))
        // adiciona o elemento á scena
        platforms[platforms.count - 1].AddToScene(scene: self)
    }
    
    //MARK: Score Update
    private func UpdateScore(_ deltaTime : Double){
        // adiciona ao score o tempo passado
        currentScore += deltaTime
        // arredonta o valor final
        currentScore = round(100 * currentScore) / 100
        
        // actualiza o valor da label
        playerScoreLabel.text = String(currentScore)
        
        // sempre que o score muda a velocidade da partida tambem
        scrollSpeed += CGFloat(2 * scrollAceleration)
    }
    
    //MARK: GameState Confirmation
    private func ConfirmPlayerPosition(){
        // avalia a posiçao do jogador horizontal
        if(self.grandpa.position.x - self.grandpa.size.width * 0.5 < 0){
            self.grandpa.position.x = self.grandpa.size.width * 0.5}
        else if(self.grandpa.position.x + self.grandpa.size.width * 0.5 > frame.size.width){
            self.grandpa.position.x = frame.size.width - self.grandpa.size.width * 0.5}
        
        // avalia a posiçao vertical do jogador
        if(self.grandpa.position.y - self.grandpa.size.height * 0.5 < 0){
            self.grandpa.position.y = self.grandpa.size.height * 0.5}
        else if(self.grandpa.position.y - self.grandpa.size.height * 0.5 > frame.height){
            // end Game
            saveScore()
            LoadEndGameScene()
        }
    }
    private func SwitchToMenuScene(){
        // define a transiçao
        let transition = SKTransition.push(with: .left, duration: 0.6)
        // define a scena a carregar
        let scene = MenuScene(size: size)
        // mostra a cena com a transiçao definida
        self.view?.presentScene(scene, transition: transition)
    }
    //MARK: Input
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // verifica se nao é o toque de inicio
        if(!startPlaying){
            // sendo o primeiro toque
            // remove a label informativa e inicia a mostragem da pontuaçao
            justTaplabel.removeFromParent()
            self.addChild(playerScoreLabel)
            // activa o corpo fisico do jogador
            grandpa.physicsBody?.isDynamic = true
            // define a gravidade do jogo
            physicsWorld.gravity = CGVector(dx: 0, dy: -4.9)
            // inicia a partida
            startPlaying = true
            
            // ignora o resto da funçao
            return
        }
        //MARK: Sugestao
        self.playerDirection *= -1
        // actualiza a direcçao do jogador
        self.grandpa.xScale = abs(self.grandpa.xScale) * CGFloat(playerDirection)
        
    }

    func saveScore(){
        if(recordData == nil)
        {
            let savedString = playerScoreLabel.text
            
            userDefaults.set(savedString, forKey: "BestScore")

        }
        else
        {
            let score:Double? = Double(playerScoreLabel.text!)
            let record:Double? = Double(recordData)
            if(score! > record!)
            {
                let savedString = score
                let userDefaults = Foundation.UserDefaults.standard
                userDefaults.set(savedString, forKey: "BestScore")

            }
        
        }
    }
 
    //MARK: Collision callBack
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody : SKPhysicsBody
        var secondBody : SKPhysicsBody
        
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
        {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        
        if ((firstBody.categoryBitMask == PhysicsCategory.grandpa) &&
            (secondBody.categoryBitMask == PhysicsCategory.floor))
        {
            down = false
        }else{
            down = true
            
        }
    }
    
    //MARK: Load EndScene
    private func LoadEndGameScene(){
        // define a transiçao
        let transition = SKTransition.push(with: .left, duration: 0.6)
        // define a cena a carregar
        let scene = EndGameScene(size: size, score: currentScore)
        // mostra a cena com a transiçao definida
        self.view?.presentScene(scene, transition: transition)
    }
    
}

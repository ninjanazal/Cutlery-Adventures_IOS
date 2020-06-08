import SpriteKit
import GameKit

// class que gere as plataformas
class Obstacle{
    //MARK: Variaveis da class
    var leftPlatform, rightPlatform : SKSpriteNode!
    var gapSize : CGFloat = 0.2          // distancia de espaçamento entre as plataformas %da largura                                       do ecra
    var obstaclePosition : CGPoint      // posiçao central do espaçamento
    
    // construtor da class
    init(lastPlatformHeight : CGFloat, texture : SKTexture, distanceFrom: CGFloat, frame : CGRect) {
        // recebe a posiçao da plataforma anterior e a distancia que deve guardar da proxima
        // calcula o espaçamento dado a largura do ecra
        gapSize *= frame.width
        // define a posiçao central do espaçamento
        // a posiçao central do espaçamento pode estar entre as margem do ecra, mantendo sempre o tamanho definido
        obstaclePosition = CGPoint(
            x: CGFloat.random(in: gapSize * 0.5 ... frame.width - gapSize * 0.5),
            y: lastPlatformHeight - distanceFrom)
        
        //MARK: Plataforma da esquerda
        // inicia a plataforma da esquerda
        leftPlatform = SKSpriteNode(texture: texture)
        // define a altura da plataforma
        leftPlatform.yScale = 0.25
        // define a posiçao da plataforma da esquerda
        leftPlatform.position = CGPoint(
            x: obstaclePosition.x - gapSize * 0.5 - leftPlatform.size.width * 0.5,
            y: obstaclePosition.y)
        // coloca plataforma na frente
        leftPlatform.zPosition = 5
        
        //MARK: TODO fisicas dos objs
        
        //MARK: Plataforma da direita
        // inicia a plataforma da direita
        rightPlatform = SKSpriteNode(texture: texture)
        // define a altura da plataforma
        rightPlatform.yScale = 0.25
        // define a posiçao da plataforma
        rightPlatform.position = CGPoint(
            x: obstaclePosition.x + gapSize * 0.5 + rightPlatform.size.width * 0.5,
            y: obstaclePosition.y)
        // coloca a plataforma na frente
        rightPlatform.zPosition = 5
        
        //MARK: TODO fiscas dos objs
    }
    
    //MARK: Add & Remove from scene
    // metodo que adiciona as plataforma á cena
    public func AddToScene(scene : SKScene){
        // adiciona á cena recebida os objetos
        scene.addChild(leftPlatform)
        scene.addChild(rightPlatform)
    }
    // metodo que remove as plataformas da cena
    public func RemoveFromScene(scene : SKScene){
        // remove o obj da cena
        leftPlatform.removeFromParent()
        rightPlatform.removeFromParent()
    }
    
    //MARK: Move Obstacle
    // desloca o obstaculo
    public func Move(amount : CGFloat){
        // desloca todos os elementos a quantidade referneciada
        self.obstaclePosition.y += amount       // desloca a falha
        self.leftPlatform.position.y = self.obstaclePosition.y  // desloca a plataforma da esquerda
        self.rightPlatform.position.y = self.obstaclePosition.y // desloca a plataforma da direita
    }
    public func MoveTo(_ position : CGFloat){
        // coloca o elemento numa determinada posiçao
        self.obstaclePosition.y = position
        self.leftPlatform.position.y = position
        self.rightPlatform.position.y = position
    }
    
    // metodo que retorna se o obstaculo continua dentro dos limites do ecra
    public func IsInsideScreen(frame: CGRect) -> Bool{
        // verifica se o objeto está dentro dos limites
        return (obstaclePosition.y - leftPlatform.size.height * 0.5 < frame.size.height)
    }
}

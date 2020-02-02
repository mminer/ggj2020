import GameplayKit

struct GameSession {

    let currentPlayer: Player
    let imageModelMap: [Model] // Index = image number
    let players: [Player]

    init(gameCode: String, currentPlayerIndex: Int) {
        let playerCount = GameCode.extractPlayerCount(gameCode)
        let seed = gameCode.data(using: .utf8)!
        let randomNumberGenerator = GKARC4RandomSource(seed: seed)

        imageModelMap = randomNumberGenerator.arrayByShufflingObjects(in: Model.allCases) as! [Model]
        players = (1...playerCount).map { _ in Player(randomNumberGenerator: randomNumberGenerator) }
        currentPlayer = players[currentPlayerIndex]
    }

    init(playerCount: Int) {
        let gameCode = GameCode.generate(playerCount: playerCount)
        self.init(gameCode: gameCode, currentPlayerIndex: 0)
    }
}

import GameplayKit

struct GameSession {

    let currentPlayerNumber: Int
    let gameCode: String
    let imageModelMap: [Model] // Index = image number
    let players: [Player]

    var currentPlayer: Player {
        return players[currentPlayerNumber - 1]
    }

    init(gameCode: String, currentPlayerNumber: Int) {
        let playerCount = GameCode.extractPlayerCount(gameCode)
        let seed = gameCode.data(using: .utf8)!
        let randomNumberGenerator = GKARC4RandomSource(seed: seed)

        self.currentPlayerNumber = currentPlayerNumber
        self.gameCode = gameCode
        self.imageModelMap = randomNumberGenerator.arrayByShufflingObjects(in: Model.allCases) as! [Model]

        self.players = (1...playerCount).map { playerNumber in
          Player(playerNumber: playerNumber, randomNumberGenerator)
        }
    }

    init(playerCount: Int) {
        let gameCode = GameCode.generate(playerCount: playerCount)
        self.init(gameCode: gameCode, currentPlayerNumber: 1)
    }
}

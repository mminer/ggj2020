import GameplayKit

struct Player {

    let playerNumber: Int

    let beneficial: Model
    let detrimental: Model
    let visible: [Model]

    init(playerNumber: Int, _ randomNumberGenerator: GKRandom) {
        self.playerNumber = playerNumber

        var models = Model.allCases
        beneficial = popRandom(&models, randomNumberGenerator)
        detrimental = popRandom(&models, randomNumberGenerator)
        visible = (1...Constants.visibleModelCount).map { _ in popRandom(&models, randomNumberGenerator) }

        print("[Player \(playerNumber)] Beneficial:", beneficial)
        print("[Player \(playerNumber)] Detrimental:", detrimental)
        print("[Player \(playerNumber)] Visible:", visible)
    }
}

private func popRandom(_ models: inout [Model], _ randomNumberGenerator: GKRandom) -> Model {
    let index = randomNumberGenerator.nextInt(upperBound: models.count)
    return models.remove(at: index)
}

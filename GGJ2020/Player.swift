import GameplayKit

struct Player {

    let beneficial: Model
    let detrimental: Model
    let visible: [Model]

    init(randomNumberGenerator: GKRandom) {
        var models = Model.allCases
        beneficial = popRandom(models: &models, randomNumberGenerator: randomNumberGenerator)
        detrimental = popRandom(models: &models, randomNumberGenerator: randomNumberGenerator)

        visible = (1...Constants.visibleModelCount).map { _ in
            popRandom(models: &models, randomNumberGenerator: randomNumberGenerator)
        }

        print("Beneficial:", beneficial)
        print("Detrimental:", detrimental)
        print("Visible:", visible)
    }
}

private func popRandom(models: inout [Model], randomNumberGenerator: GKRandom) -> Model {
    let index = randomNumberGenerator.nextInt(upperBound: models.count)
    return models.remove(at: index)
}

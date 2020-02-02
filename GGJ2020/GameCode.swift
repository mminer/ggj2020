struct GameCode {

    // Shorter = easier to type, longer = more possible configurations.
    static let length = 3

    static func extractPlayerCount(_ gameCode: String) -> Int {
        return Int(gameCode.capitalized.first!.asciiValue!) - 64
    }

    static func generate(playerCount: Int) -> String {
        // Format: <player count><random string>
        // <player count> is represented as a letter to ease typing. B = 2, C = 3, and so forth.
        // The entire string (including the player count) forms the random seed.
        let playerCountCode = String(Unicode.Scalar(64 + playerCount)!)

        let randomizer = (1..<length)
            .compactMap { _ in String("ABCDEFGHIJKLMNOPQRSTUVWXYZ".randomElement()!) }
            .joined()

        return playerCountCode + randomizer
    }
}

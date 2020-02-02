import UIKit

class MainViewController: UIViewController {

    @IBAction func promptForGameCode() {
        let alert = UIAlertController(title: "What’s the game code?", message: nil, preferredStyle: .alert)

        alert.addTextField { textField in
            textField.autocapitalizationType = .allCharacters
            textField.keyboardType = .asciiCapable
            textField.placeholder = "e.g. CRE"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        let submitAction = UIAlertAction(title: "That’s It!", style: .default) { _ in
            guard let gameCode = alert.textFields?.first?.text, !gameCode.isEmpty else {
                return
            }

            self.promptForPlayerNumber(gameCode: gameCode)
        }

        alert.addAction(cancelAction)
        alert.addAction(submitAction)
        alert.preferredAction = submitAction
        present(alert, animated: true)
    }

    @IBAction func promptForPlayerCount() {
        let alert = UIAlertController(title: "How many players?", message: nil, preferredStyle: .alert)

        alert.addTextField { textField in
            textField.keyboardType = .numberPad
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        let startAction = UIAlertAction(title: "Start Game", style: .default) { _ in
            guard
                let playerCountString = alert.textFields?.first?.text,
                !playerCountString.isEmpty,
                let playerCount = Int(playerCountString)
            else {
                return
            }

            let gameSession = GameSession(playerCount: playerCount)
            self.startGame(gameSession)
        }

        alert.addAction(cancelAction)
        alert.addAction(startAction)
        alert.preferredAction = startAction
        present(alert, animated: true)
    }

    func promptForPlayerNumber(gameCode: String) {
        let playerCount = GameCode.extractPlayerCount(gameCode)

        let alert = UIAlertController(title: "Which player are you?", message: nil, preferredStyle: .actionSheet)

        (2...playerCount)
            .map { playerNumber in
                UIAlertAction(title: "Player \(playerNumber)", style: .default) { _ in
                    let gameSession = GameSession(gameCode: gameCode, currentPlayerNumber: playerNumber)
                    self.startGame(gameSession)
                }
            }
            .forEach { alert.addAction($0) }

        present(alert, animated: true)
    }

    func startGame(_ gameSession: GameSession) {
        let storyboard = UIStoryboard(name: "Game", bundle: nil)

        guard let viewController = storyboard.instantiateInitialViewController() as? GameViewController else {
          fatalError()
        }

        viewController.gameSession = gameSession
        present(viewController, animated: true)
    }
}

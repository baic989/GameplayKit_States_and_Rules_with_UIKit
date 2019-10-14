import UIKit
import GameplayKit
import PlaygroundSupport

enum Event {
    case first
    case second
    case third
}

final class EventBuffer {


}

final class FirstState: GKState {

    weak var stateController: StateViewController?

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == SecondState.self
    }

    override func didEnter(from previousState: GKState?) {
        print("Entered \(FirstState.self)")
    }

    override func willExit(to nextState: GKState) {
        // Next
    }
}

final class SecondState: GKState {

    weak var stateController: StateViewController?

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == ThirdState.self
    }

    override func didEnter(from previousState: GKState?) {
        // Previous
    }

    override func willExit(to nextState: GKState) {
        // Next
    }
}

final class ThirdState: GKState {

    weak var stateController: StateViewController?

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == FirstState.self
    }

    override func didEnter(from previousState: GKState?) {
        // Previous
    }

    override func willExit(to nextState: GKState) {
        // Next
    }
}

final class StateMachine: GKStateMachine {

}

final class StateViewController: UIViewController {

    var event: Event?
    var stateMachine: StateMachine?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "State Controller"
        view.backgroundColor = .white

        setupStateMachine()
    }

    private func setupStateMachine() {

        let first = FirstState()
        first.stateController = self

        let second = SecondState()
        second.stateController = self

        let third = ThirdState()
        third.stateController = self

        stateMachine = StateMachine(states: [first, second, third])

        // Force first state
        stateMachine?.enter(FirstState.self)
    }
}

let navigationController = UINavigationController(rootViewController: StateViewController())
PlaygroundPage.current.liveView = navigationController

import SwiftUI

// MARK: - View
struct ContentView: View {
    @ObservedObject var interactor: Interactor

    var body: some View {
        //Text("ellooooo")
        VStack {
            HStack(spacing:10){
                TextField("Enter a number", text: $interactor.firstNumber)
                    .padding()
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                Text(" + ")
                    .padding()
                TextField("Enter another number", text: $interactor.secondNumber)
                    .padding()
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
            }
            Button(action: {
                self.interactor.addNumbers()
            }) {
                Text("Add numbers")
                    .padding(.bottom,20)
            }
            Text("Result: \(interactor.result)")
        }
    }
}

// MARK: - Interactor
class Interactor: ObservableObject {
    @Published var firstNumber = ""
    @Published var secondNumber = ""
    @Published var result = ""

    func addNumbers() {
        guard let firstNumber = Int(self.firstNumber), let secondNumber = Int(self.secondNumber) else {
            return
        }
        self.result = String(firstNumber + secondNumber)
    }
}

// MARK: - Presenter
class Presenter {
    let interactor: Interactor

    init(interactor: Interactor) {
        self.interactor = interactor
    }
}

// MARK: - Router
class Router {
    let presenter: Presenter

    init(presenter: Presenter) {
        self.presenter = presenter
    }
}

// MARK: - Assembler
struct Assembler {
    static func assemble() -> some View {
        let interactor = Interactor()
        let presenter = Presenter(interactor: interactor)
        let router = Router(presenter: presenter)
        return ContentView(interactor: interactor)
    }
}

// MARK: - App
@main
struct AddTwoNumbersApp: App {
    var body: some Scene {
        WindowGroup {
            Assembler.assemble()
                .preferredColorScheme(.dark)
        }
    }
}

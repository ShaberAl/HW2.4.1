import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var overralResultLabel: UILabel!
    @IBOutlet weak var textResultLabel: UILabel!
    
    var receivedAnswers: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        calculateResult()
    }
    
    private func calculateResult() {
        var frequencyOfAnimals: [AnimalType: Int] = [:]
        let animals = receivedAnswers.map{ $0.type }
        
        for animal in animals {
            if let animalTypeCount = frequencyOfAnimals[animal] {
                frequencyOfAnimals.updateValue(animalTypeCount + 1, forKey: animal)
            } else {
                frequencyOfAnimals[animal] = 1
            }
        }
        
        let sortedFrequencyOfAnimals = frequencyOfAnimals.sorted{ $0.value > $1.value }
        guard let mostFrequencyAnimal = sortedFrequencyOfAnimals.first?.key else { return }
        
        updateUI(with: mostFrequencyAnimal)
    }
    
    private func updateUI(with animal: AnimalType) {
        overralResultLabel.text = "Вы - \(animal.rawValue)!"
        textResultLabel.text = animal.definition
    }
}

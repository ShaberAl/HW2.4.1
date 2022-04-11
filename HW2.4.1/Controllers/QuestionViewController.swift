import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var firstSV: UIStackView!
    @IBOutlet var firstButtons: [UIButton]!
    
    @IBOutlet weak var secondSV: UIStackView!
    @IBOutlet var secondLabels: [UILabel]!
    @IBOutlet var secondSwitches: [UISwitch]!
    
    @IBOutlet weak var thirdSV: UIStackView!
    @IBOutlet var thirdLabels: [UILabel]!
    @IBOutlet weak var thirdSlider: UISlider! {
        didSet {
            thirdSlider.maximumValue = Float(currentAnswers.count - 1)
            thirdSlider.value = thirdSlider.maximumValue / 2
        }
    }
    
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    private var answerChooser: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        
        resultVC.receivedAnswers = answerChooser
    }
    
    @IBAction func firstButtonPressed(_ sender: UIButton) {
        guard let buttonIndex = firstButtons.firstIndex(of: sender) else { return }
        
        let currentAnswer = currentAnswers[buttonIndex]
        answerChooser.append(currentAnswer)
        
        nextQuestion()
    }
    
    @IBAction func secondButtonPressed() {
        for (selectedSwitch, answer) in zip(secondSwitches, currentAnswers) {
            if selectedSwitch.isOn {
                answerChooser.append(answer)
            }
        }
        
        nextQuestion()
    }
    
    @IBAction func thirdButtonPressed() {
        let index = lrintf(thirdSlider.value)
        answerChooser.append(currentAnswers[index])
        
        nextQuestion()
    }
}

// MARK: Private methods
extension QuestionViewController {
    private func setupUI() {
        for stackView in [firstSV, secondSV, thirdSV] {
            stackView?.isHidden = true
        }
        
        let currentQuestion = questions[questionIndex]
        questionLabel.text = currentQuestion.title
        
        let totalProgress = Float(questionIndex) / Float(questions.count)
        progressView.setProgress(totalProgress, animated: true)
        
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        showCurrentAnswers(for: currentQuestion.type)
    }
    
    private func showCurrentAnswers(for type: ResponseType) {
        switch type {
        case .single: showFirstSV(with: currentAnswers)
        case .multiple: showSecondSV(with: currentAnswers)
        case .ranged: showThirdVC(with: currentAnswers)
        }
    }
    
    private func showFirstSV(with answers: [Answer]) {
        firstSV.isHidden = false
        
        for (button, answer) in zip(firstButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    private func showSecondSV(with answers: [Answer]) {
        secondSV.isHidden = false
        
        for (label, answer) in zip(secondLabels, answers) {
            label.text = answer.title
        }
    }
    
    private func showThirdVC(with answers: [Answer]) {
        thirdSV.isHidden = false
        
        thirdLabels.first?.text = answers.first?.title
        thirdLabels.last?.text = answers.last?.title
    }
    
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            setupUI()
            return
        }
        
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}

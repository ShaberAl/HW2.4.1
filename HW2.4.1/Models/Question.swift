struct Question {
    let title: String
    let type: ResponseType
    let answers: [Answer]
    
    static func getQuestions() -> [Question] {
        [
            Question(title: "Какую пищу предпочитаете?",
                     type: .single,
                     answers: [
                        Answer(title: "Стейк", type: .dog),
                        Answer(title: "Рыба", type: .cat),
                        Answer(title: "Морковь", type: .turtle),
                        Answer(title: "Кукуруза", type: .rabbit)
                     ]),
            Question(title: "Что Вам нравится больше?",
                     type: .multiple,
                     answers: [
                        Answer(title: "Плавать", type: .dog),
                        Answer(title: "Спать", type: .cat),
                        Answer(title: "Обниматься", type: .rabbit),
                        Answer(title: "Есть", type: .turtle)
                     ]),
            Question(title: "Любите ли Вы поездки на машине?",
                     type: .ranged,
                     answers: [
                        Answer(title: "Ненавижу", type: .dog),
                        Answer(title: "Нервничаю", type: .cat),
                        Answer(title: "Не замечаю", type: .rabbit),
                        Answer(title: "Люблю", type: .turtle)
                     ])
        ]
    }
}

struct Answer {
    let title: String
    let type: AnimalType
}

enum ResponseType {
    case single
    case multiple
    case ranged
}

enum AnimalType: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "Вам нравится быть с друзьями. Вы окружаете себя людьми, которые Вам нравятся, и всегда готовы помочь."
        case .cat:
            return "Гуляешь сам по себе, сильный и независимый."
        case .rabbit:
            return "Чуешь опасность и готов держаться от неё подальше."
        case .turtle:
            return "Сама водяная неотвратимость."
        }
    }
}

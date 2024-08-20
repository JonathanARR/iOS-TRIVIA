import UIKit

class QuestionLoader: NSObject {
    static func loadQuestions() -> [Question] {
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
            print("Error: JSON file not found.")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let questionArray = json as? [[String: Any]] else {
                print("Error: JSON is not an array of dictionaries.")
                return []
            }

            var questions: [Question] = []
            for dict in questionArray {
                if let questionText = dict["questionText"] as? String,
                   let options = dict["options"] as? [String],
                   let answer = dict["answer"] as? String {
                    let question = Question(questionText: questionText, options: options, answer: answer)
                    questions.append(question)
                } else {
                    print("Error: Missing or incorrect data in JSON.")
                }
            }
            return questions
        } catch {
            print("Error loading questions: \(error)")
            return []
        }
    }
}

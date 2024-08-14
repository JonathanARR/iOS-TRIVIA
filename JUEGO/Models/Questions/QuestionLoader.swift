import UIKit

class QuestionLoader: NSObject {
    static func loadQuestions() -> [Question] {
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
            print("Error: JSON file not found.")
            return []
        }

        do {
            // Carga los datos del archivo
            let data = try Data(contentsOf: url)
            // Deserializa los datos JSON
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            // Asegúrate de que el JSON es un arreglo de diccionarios
            guard let questionArray = json as? [[String: Any]] else {
                print("Error: JSON is not an array of dictionaries.")
                return []
            }

            var questions: [Question] = []
            for dict in questionArray {
                // Extrae los datos de cada pregunta
                if let questionText = dict["questionText"] as? String,
                   let options = dict["options"] as? [String],
                   let answer = dict["answer"] as? String {
                    // Crea un objeto Question con los datos extraídos
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

//
//  QnAViewController.swift
//  QnA
//
//  Created by 張凱棋 on 2023/4/26.
//

import UIKit

class QnAViewController: UIViewController {
    @IBOutlet weak var boniImg: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var kiwiImg: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet var optionsBtn: [UIButton]!
    
    var questions:[Question] = []
    var score:Int = 0
    var currentIndex:Int = 0 {
        didSet{
            loadQuestion()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setQuestions()
        loadQuestion()
    }
    
    func setQuestions() {
        // 題庫 + 洗牌
        questions = [
            Question(question: "以下哪個選項是一種前端框架？",
                     options: ["Flask", "Django", "Vue", "Laravel"],
                     answer: "Vue",
                     category: .frontEnd),
            Question(question: "在 HTML 中，下列哪個標籤可以用來建立一個超連結？",
                     options: ["<a>", "<img>", "<p>", "<h1>"],
                     answer: "<a>",
                     category: .frontEnd),
            Question(question: "以下哪個符號代表等於？",
                     options: ["=", "==", "!=", "<="],
                     answer: "==",
                     category: .common),
            Question(question: "在 CSS 中，下列哪個屬性可以改變文字的顏色？",
                     options: ["background-color", "font-weight", "text-align", "color"],
                     answer: "color",
                     category: .frontEnd),
            Question(question: "以下哪個選項是一種後端框架？",
                     options: ["React", "Vue", "Laravel", "Angular"],
                     answer: "Laravel",
                     category: .backEnd),
            Question(question: "在 JavaScript 中，下列哪個函式可以將一個字串轉換為整數？",
                     options: ["parseDouble()", "parseInt()", "parseFloat()", "toString()"],
                     answer: "parseInt()",
                     category: .frontEnd),
            Question(question: "以下哪個選項可以用來宣告一個常數？",
                     options: ["let", "const", "var", "const let"],
                     answer: "const",
                     category: .common),
            Question(question: "在 HTML 中，下列哪個標籤可以用來建立一個表格？",
                     options: ["<table>", "<form>", "<div>", "<span>"],
                     answer: "<table>",
                     category: .frontEnd),
            Question(question: "以下哪個選項是一種編譯語言？",
                     options: ["Python", "JavaScript", "Ruby", "C++"],
                     answer: "C++",
                     category: .backEnd),
            Question(question: "在 CSS 中，下列哪個屬性可以改變元素的寬度？",
                     options: ["height", "padding", "margin", "width"],
                     answer: "width",
                     category: .frontEnd),
            Question(question: "以下哪個選項是一個常見的版本控制系統？",
                     options: ["Git", "SVN", "Mercurial", "CVS"],
                     answer: "Git",
                     category: .common),
            Question(question: "在 JavaScript 中，下列哪個選項可以將一個字串轉換為小寫？",
                     options: ["toLowerCase()", "toUpperCase()", "slice()", "concat()"],
                     answer: "toLowerCase()",
                     category: .frontEnd),
            Question(question: "以下哪個選項是一個後端語言？",
                     options: ["HTML", "CSS", "JavaScript", "PHP"],
                     answer: "PHP",
                     category: .backEnd),
            Question(question: "在 HTML 中，下列哪個標籤可以用來建立一個列表？",
                     options: ["<ul>", "<ol>", "<li>", "<dl>"],
                     answer: "<ul>",
                     category: .frontEnd),
            Question(question: "以下哪個符號代表大於等於？",
                     options: ["=", "==", "!=", ">="],
                     answer: ">=",
                     category: .common),
            Question(question: "在 CSS 中，下列哪個屬性可以改變元素的高度？",
                     options: ["height", "padding", "margin", "width"],
                     answer: "height",
                     category: .frontEnd),
            Question(question: "以下哪個選項是一個資料庫系統？",
                     options: ["MySQL", "MongoDB", "Express", "Node.js"],
                     answer: "MySQL",
                     category: .backEnd),
            Question(question: "在 JavaScript 中，下列哪個函式可以回傳一個隨機數字？",
                     options: ["Math.floor()", "Math.ceil()", "Math.random()", "Math.round()"],
                     answer: "Math.random()",
                     category: .frontEnd),
            Question(question: "以下哪個選項是一個前端框架？",
                     options: ["Express", "React", "Django", "Flask"],
                     answer: "React",
                     category: .frontEnd),
            Question(question: "在 HTML 中，下列哪個標籤可以用來建立一個圖片？",
                     options: ["<img>", "<a>", "<p>", "<h1>"],
                     answer: "<img>",
                     category: .frontEnd),
        ]
        questions.shuffle()
        // 選項洗牌
        for (i, question) in questions.enumerated() {
            var options = question.options
            options.shuffle()
            let newQuestion = Question(
                question: question.question,
                options: options,
                answer: question.answer,
                category: question.category
            )
            questions[i] = newQuestion
        }
    }
    func loadQuestion() {
        if currentIndex < 10 {
            let question = questions[currentIndex]
            questionLabel.text = question.question
            for (i, optionBtn) in optionsBtn.enumerated() {
                optionBtn.setTitle(question.options[i], for: .normal)
            }
        }
        else{
            self.performSegue(withIdentifier: "showResultSegue", sender: self)
        }
        updateUI(status: .testing)
    }
    func updateUI(status: status) {
        switch status{
        case .correct:
            boniImg.image = UIImage(named: "correct.png")
            kiwiImg.image = UIImage(named: "cool.png")
            answerLabel.text = "水啦～"
        case .incorrect:
            boniImg.image = UIImage(named: "wrong.png")
            kiwiImg.image = UIImage(named: "sad.png")
            answerLabel.text = "可惡～"
        case .testing:
            boniImg.image = UIImage(named: "boni.png")
            kiwiImg.image = UIImage(named: "kiwi.png")
            answerLabel.text = ""
        }
    }
    @IBAction func btnTapped(_ sender: UIButton) {
        let question = questions[currentIndex]
        let alertController: UIAlertController
        if sender.currentTitle == question.answer {
            self.score += 10
            updateUI(status: .correct)
            alertController = UIAlertController(title: "答對了！", message: "你很猛欸", preferredStyle: .alert)
        }
        else{
            updateUI(status: .incorrect)
            alertController = UIAlertController(title: "答錯囉！", message: "答案是\(question.answer)", preferredStyle: .alert)
        }
        alertController.addAction(UIAlertAction(title: "下一題", style: .default, handler: { _ in self.currentIndex += 1
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    @IBSegueAction func showResult(_ coder: NSCoder) -> ResultViewController? {
        let controller = ResultViewController(coder: coder)
        controller?.score = self.score
        return controller
    }
}

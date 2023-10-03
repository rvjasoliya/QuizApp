
import UIKit

protocol QuestionCellDelegate {
    func handleButtonTap(sender: UIButton)
}

class QuestionCell: UICollectionViewCell {

    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answer1: UIView!
    @IBOutlet weak var answer1Label: UILabel!
    
    @IBOutlet weak var answer2: UIView!
    @IBOutlet weak var answer2Label: UILabel!
    
    @IBOutlet weak var answer3: UIView!
    @IBOutlet weak var answer3Label: UILabel!
    
    @IBOutlet weak var answer4: UIView!
    @IBOutlet weak var answer4Label: UILabel!
    
    @IBOutlet weak var answer5: UIView!
    @IBOutlet weak var answer5Label: UILabel!
    
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var widthCOnst: NSLayoutConstraint!
    
    static let xibName = "QuestionCell"
    static let cellIdentifier = "QuestionCell"
    
    var delegate: QuestionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func ansewerButtonAction(_ sender: UIButton) {
        self.delegate?.handleButtonTap(sender: sender)
    }

    func setData(currentQuestion: QuestionModel?) {
        self.questionLabel.text = currentQuestion?.question
        self.answer1Label.text = currentQuestion?.ans1
        self.answer2Label.text = currentQuestion?.ans2
        self.answer3Label.text = currentQuestion?.ans3
        self.answer4Label.text = currentQuestion?.ans4
        self.answer5Label.text = currentQuestion?.ans5
        
        answer1.isHidden = currentQuestion?.ans1 == "" ? true : false
        answer2.isHidden = currentQuestion?.ans2 == "" ? true : false
        answer3.isHidden = currentQuestion?.ans3 == "" ? true : false
        answer4.isHidden = currentQuestion?.ans4 == "" ? true : false
        answer5.isHidden = currentQuestion?.ans5 == "" ? true : false
        
        
        image1.image = UIImage(named: currentQuestion?.selectedItem == "ans1" ? "selected" : "deselect")
        image2.image = UIImage(named: currentQuestion?.selectedItem == "ans2" ? "selected" : "deselect")
        image3.image = UIImage(named: currentQuestion?.selectedItem == "ans3" ? "selected" : "deselect")
        image4.image = UIImage(named: currentQuestion?.selectedItem == "ans4" ? "selected" : "deselect")
        image5.image = UIImage(named: currentQuestion?.selectedItem == "ans5" ? "selected" : "deselect")
    }
    
}


import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightAnsLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    @IBOutlet weak var skipLabel: UILabel!
    
    var rightAns = 0
    var wrongeAns = 0
    var skipAns = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "\(rightAns) out of 10"
        rightAnsLabel.text = "Your right answer is: \(rightAns)"
        wrongLabel.text = "Your wrong answer is: \(wrongeAns)"
        skipLabel.text = "Your skip answer is: \(skipAns)"
        
    }
    
    @IBAction func homeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

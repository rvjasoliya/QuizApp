
import Foundation
import UIKit

class QuestionViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var questionNoLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    
    var questionArray: [QuestionModel] = []
    var questions: [QuestionModel] = []
    var index = 0
    var currentQuestion: QuestionModel?
    
    var rightAns = 0
    var wrongeAns = 0
    var skipAns = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        leftButton.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        questionApi()
        leftButton.isHidden = true
    }
    
    func registerCell() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: QuestionCell.xibName, bundle: nil), forCellWithReuseIdentifier: QuestionCell.cellIdentifier)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.collectionView {
            let xPoint = scrollView.contentOffset.x + scrollView.frame.width / 2
            let yPoint = scrollView.frame.height / 2
            let center = CGPoint(x: xPoint, y: yPoint)
            if let ip = self.collectionView.indexPathForItem(at: center) {
                self.index = ip.row
                questionNoLabel.text = "Question \(self.index+1) of 10"
                leftButton.isHidden = index == 0 ? true : false
                rightButton.isHidden = (index == (self.questions.count - 1)) ? true : false
                submitButton.isHidden = (index == (self.questions.count - 1)) ? false : true
            }
        }
    }
    
  
    
    @IBAction func previousButtonAction(_ sender: UIButton) {
        self.index = self.index - 1
        if index < 0 {
            self.index = 0
        }
        
        leftButton.isHidden = index == 0 ? true : false
        rightButton.isHidden = (index == (self.questions.count - 1)) ? true : false
        submitButton.isHidden = (index == (self.questions.count - 1)) ? false : true
        //self.setData(index: self.index)
        collectionView.scrollToItem(at: IndexPath(row: self.index, section: 0), at: .left, animated: true)
        questionNoLabel.text = "Question \(index+1) of 10"
        
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        self.index = self.index + 1
        if index >= self.questions.count {
            self.index = self.questions.count - 1
        }
        leftButton.isHidden = index == 0 ? true : false
        rightButton.isHidden = (index == (self.questions.count - 1)) ? true : false
        submitButton.isHidden = (index == (self.questions.count - 1)) ? false : true
        collectionView.scrollToItem(at: IndexPath(row: self.index, section: 0), at: .right, animated: true)
        questionNoLabel.text = "Question \(index+1) of 10"
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        
        for item in self.questions {
            if item.selectedItem == item.correct {
                rightAns = rightAns + 1
            } else if item.selectedItem == "" {
                skipAns = skipAns + 1
            } else{
                wrongeAns = wrongeAns + 1
            }
        }
        print("rightAns   " , rightAns)
        print("wrongeAns   " , wrongeAns)
        print("skipAns   " , skipAns)
        
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        newVC.rightAns = rightAns
        newVC.wrongeAns = wrongeAns
        newVC.skipAns = skipAns
        self.navigationController?.pushViewController(newVC, animated: true)
        
    }

}


// MARK: Collection View Setup
extension QuestionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.questions.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionCell.cellIdentifier, for: indexPath) as! QuestionCell
        cell.delegate = self
        cell.setData(currentQuestion: self.questions[indexPath.row])
        cell.widthCOnst.constant = UIScreen.main.bounds.width
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension QuestionViewController : QuestionCellDelegate {
    func handleButtonTap(sender: UIButton) {
        if sender.tag == 1001 {
            self.questions[index].selectedItem = "ans1"
        }
        if sender.tag == 1002 {
            self.questions[index].selectedItem = "ans2"
        }
        if sender.tag == 1003 {
            self.questions[index].selectedItem = "ans3"
        }
        if sender.tag == 1004 {
            self.questions[index].selectedItem = "ans4"
        }
        if sender.tag == 1005 {
            self.questions[index].selectedItem = "ans5"
        }
        self.collectionView.reloadData()
    }
    
}



// MARK: API Services
extension QuestionViewController {
    
    // Faqs Api
    func questionApi() {
        showLoading()
        questionArray = []
        questions = []
        APIHelper.questionApi() { (success, response)  in
            if !success {
                dissmissLoader()
                self.view.makeToast("Something went wrong")
            } else {
                dissmissLoader()
                print(response)
                for data in response.data.arrayValue {
                    self.questionArray.append(QuestionModel.init(json: data))
                }
                print(self.questionArray.count)
                let list = self.questionArray.shuffled().prefix(10)
                for item in list {
                    self.questions.append(item)
                }
                print(self.questions.count)
                self.collectionView.reloadData()
            }
        }
    }
    
}

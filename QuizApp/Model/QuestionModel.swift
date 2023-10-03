
import Foundation
import SwiftyJSON

public class QuestionModel {
    public let id : String?
    public let question : String?
    public let ans1 : String?
    public let ans2 : String?
    public let ans3 : String?
    public let ans4 : String?
    public let ans5 : String?
    public let correct : String?
    public let added_date : String?
    public let modified_date : String?
    public let status : String?
    public var selectedItem : String?
    
    init(json: JSON) {
        self.id = json["id"].string
        self.question = json["question"].string
        self.ans1 = json["ans1"].string
        self.ans2 = json["ans2"].string
        self.ans3 = json["ans3"].string
        self.ans4 = json["ans4"].string
        self.ans5 = json["ans5"].string
        self.correct = json["correct"].string
        self.added_date = json["added_date"].string
        self.modified_date = json["modified_date"].string
        self.status = json["status"].string
        self.selectedItem = ""
    }
    
}

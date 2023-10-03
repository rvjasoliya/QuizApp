
import Foundation
import SwiftyJSON
import Alamofire


final class APIHelper {
    
    //MARK: Question Api
    static func questionApi(success: @escaping(_ success: Bool, _ response: APIResponse) -> Void) {
        APIManager.shared.getRequestMethod(method: .get, url: APIEndPoint.qusetionApi.rawValue) { response in
            if response.success == true {
                success(true, response)
            } else {
                success(false, response)
            }
        }
    }
}

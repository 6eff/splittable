

import SwiftyJSON

class UserObject {
    var imageUrl: String
    var name: String
    var url:String
    var id:Int
    
    required init(json: JSON) {
        imageUrl = json["image_url"].stringValue
        name = json["name"].stringValue
        url = json["url"].stringValue
        id = json["id"].intValue
    }
}


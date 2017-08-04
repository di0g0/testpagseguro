import Alamofire
import Unbox

class BeerManager {
    var beerList = [Beer]()
    
    func getBeers(onloadComplete:@escaping (_ success: Bool)->Void) {
        Alamofire.request(
            AppConstants.beerApiUrl)
            .responseJSON { response in
                guard response.result.isSuccess else {
                    onloadComplete(false)
                    return
                }
                
                do {
                    self.beerList = try unbox(dictionaries: response.result.value as! [UnboxableDictionary])
                    onloadComplete(true)
                } catch {
                    onloadComplete(false)
                }
        }
    }
}


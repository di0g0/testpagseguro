import Foundation

struct BeerViewModel {
    let beer: Beer
    
    init(beer: Beer) {
        self.beer = beer
    }
    
    var nameText: String {
        return beer.beerName
    }
    
    var descriptionText: String {
        return beer.beerDescription
    }
    
    var taglineText: String {
        return beer.tagline
    }
    
    var abvText: String {
        return String(format: "ABV: %.1f%%", beer.abv)
    }
    
    var ibuText: String? {
        guard let ibu = beer.ibu else {
            return nil
        }
        
        return "IBU: \(ibu)"
    }
    
    var pictureUrl: URL? {
        return URL(string: beer.beerImageUrl)
    }
    
}

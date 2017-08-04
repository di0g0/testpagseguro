import Unbox

struct Beer : Unboxable {
    let beerName: String
    let beerImageUrl: String
    let beerDescription: String
    let tagline: String
    let abv: Float
    let ibu: Int?
    
    init(unboxer: Unboxer) throws {
        self.beerName = try unboxer.unbox(key: "name")
        self.beerImageUrl = try unboxer.unbox(key: "image_url")
        self.beerDescription = try unboxer.unbox(key: "description")
        self.tagline = try unboxer.unbox(key: "tagline")
        self.abv = try unboxer.unbox(key: "abv")
        self.ibu = unboxer.unbox(key: "ibu")
    }
}

import Foundation
import Combine

protocol CocktailsAPI: AnyObject {
    
//    var cocktailsPublisher: AnyPublisher<Data, CocktailsAPIError> { get }
    func fetchCocktails(_ completion: @escaping (_ success: Bool, _ results: Cocktails?, _ error: CocktailsAPIError?) -> Void)
//    func fetchCocktails(_ handler: @escaping (Result<Data, CocktailsAPIError>) -> Void)
}

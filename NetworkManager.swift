import Foundation

enum NetworkingError: String {
    case clientError  = "cannot connect to server"
    case networkError = "server error"
}

class NetworkManager {
    private static let urlString = "https://dummyURL"
    
    static func loadDeals(completion: @escaping (_ items:[item]?, _ error:String?) -> ()) -> URLSessionDataTask? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(nil, NetworkingError.clientError.rawValue)
                return
            }
            
            if let data = data {
                let apiResponse = response as! HTTPURLResponse
                if apiResponse.statusCode == 200 {
                    let decodedData = try? JSONDecoder().decode(MyModel.self, from: data)
                    completion(decodedData?.items, nil)
                } else {
                    completion(nil, NetworkingError.networkError.rawValue)
                    return
                }
            }
        }

        task.resume()
        return task
    }
}

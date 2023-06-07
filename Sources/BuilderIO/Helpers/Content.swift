import Foundation

public struct Content {
    public static func getContent(model: String, apiKey: String, url: String, locale: String?, preview: String?, callback: @escaping ((BuilderContent?)->())) {
        let encodedUrl = String(describing: url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
        var str = "https://cdn.builder.io/api/v2/content/\(model)"
        
        if let preview = preview, !preview.isEmpty {
            str += "/\(preview)"
        }
        str += "?apiKey=\(apiKey)&url=\(encodedUrl)"
        
        if let locale = locale, !locale.isEmpty {
            str += "&locale=\(locale)"
        }
        
        if let preview = preview, !preview.isEmpty {
            str += "&preview=true"
            str += "&cachebust=true"
        }
        
        print("Requesting from Builder.io: \(str)")
        
        let url = URL(string: str)!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                callback(nil)
                return
            }
            let decoder = JSONDecoder()
            let jsonString = String(data: data, encoding: .utf8)!
            do {
                if let preview = preview, !preview.isEmpty {
                    let content = try decoder.decode(BuilderContent.self, from: Data(jsonString.utf8))
                    callback(content)
                } else {
                    let content = try decoder.decode(BuilderContentList.self, from: Data(jsonString.utf8))
                    if content.results.count>0 {
                        callback(content.results[0])
                    }
                }
            } catch {
                print(error)
                callback(nil)
            }
        }
        
        task.resume()
    }
}

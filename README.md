# APIUtility
An ApiUtility framework using RxAlamofire, Himotoki, and RxSwift for Swift. You do not need to know the works of RxAlamofire and json parser of Himotoki. Just define request, and response object, APIUtitlity will do all the works for you.

# Requirements

- Swift 3.0 or later
- iOS 9.0 or later

## Installation

#### [Carthage](https://github.com/Carthage/Carthage)

- Insert `github "cam-hop/APIUtility"` to your Cartfile.
- Run `carthage update`.

#### [CocoaPods](https://cocoapods.org/)

- To be support soon

## Usage

- Refer to RxSwiftFluxDemo project for sample usage

### Step 1: Create Request and Response Object

- Create request which extend from APIRequest with all needed info

```swift
import APIUtility
import RxAlamofire
import Alamofire

struct SubscriberRequest: APIRequest {
    typealias Response = SubscriberResponse
    let baseURL: String = "https://itunes.apple.com"
    let headerFields: [String : String] = ["": ""]
    let method: Alamofire.HTTPMethod = .get
    let path: String = "/search?"
    let parameters: [String : Any]? = ["term": "beatles",
                                      "country": "JP",
                                      "lang": "ja_jp",
                                      "media": "music"]

}

```

- If you use more than a request, it recommends that you should define an APIRequest extension which contain all common info

```swift
import APIUtility

extension APIRequest {
    var baseURL: String {
        return "https://itunes.apple.com"
    }

    var headerFields: [String : String] {
        return ["": ""]
    }
}
```

- Create response object for this request

```swift
import Himotoki

struct SubscriberResponse : Decodable {
    let resultCount: Int
    let results: [Subcriber]?

    static func decode(_ e: Extractor) throws -> SubscriberResponse {
        return try SubscriberResponse(
            resultCount: e <| "resultCount",
            results: e <||? "results"
        )
    }
}

struct Subscriber: Decodable {
    let name: String
    let generation: String
    let imageUrl: String

    static func decode(_ e: Extractor) throws -> Subscriber {
        return try Subcriber(
            name: e <| "trackName",
            generation: e <| "artistName",
            imageUrl: e <| "artworkUrl100"
        )
    }
}
```

### Step 2: Fetch object form server throught api

- Just use fetch() method of APIUtility and get the results

```swift
import APIUtility

ApiService.shared.fetch(SubcriberRequest())
    .subscribe({ event -> Void in
         switch event {
             case .next(let value):
                 guard let results = value.results else { return }
                 // deal with results object
             case .completed:
                 // do something
                 print("Completed")
             case .error(let error):
                 // error case
                 print("Error")
          }
     })
     .addDisposableTo(disposeBag)
```

## Advanced

- If you need work more than fetch() method do, you can override it in your own class. Or implement other funcs that you need to do your work

```swift
import APIUtility

final class YourAppApiService: ApiService {
  
   override init() {
     super.init()
   }
   
   override func fetch<T: APIRequest>(_ item: T) -> Observable<T.Response>  {
      super.fetch(item)
      // do extra work
   }
   
   // define your own methods
}
```

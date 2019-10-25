
import Foundation

struct Alarm {
    
    var feedingTime: Date
    var playTime: Date
    var litterBoxTime: Date
    
    init (feedingTime: Date?, playTime: Date?, litterBoxTime: Date?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "+11:00")
        
        
        let date = dateFormatter.date(from: "2019-01-01T16:39:57")
        
        self.feedingTime = date!
        self.playTime = date!
        self.litterBoxTime = date!
        
    }
    
    mutating func setFeedingTime (time: Date) {
        feedingTime = time
    }
    
    mutating func setPlayTime (time: Date) {
        playTime = time
    }
    
    mutating func setLitterBoxTime (time: Date) {
        litterBoxTime = time
    }
}

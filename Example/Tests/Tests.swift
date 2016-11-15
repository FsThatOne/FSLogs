import UIKit
import XCTest
import FSLogger

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
        Fs("哈哈哈")
        FsInfo("嘻嘻")
        FsWarn("嘿嘿")
        FsError("错啦!!!")
        FSLog.logLevelShown = .warnning
        Fs("哈哈哈")
        FsInfo("嘻嘻")
        FsWarn("嘿嘿")
        FsError("错啦!!!")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}

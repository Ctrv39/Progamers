//
//  ProgamersExpertTests.swift
//  ProgamersExpertTests
//
//  Created by Viktor . on 31/10/21.
//

import XCTest
import RxSwift
@testable import ProgamersExpert

class ProgamersExpertTests: XCTestCase {
    private let disposeBag = DisposeBag()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testHomeInteractor() throws {
        // given
        let homeUseCase = Injection.init().provideHome()
        
        // when
        homeUseCase.getGameList(page: 0).observe(on: MainScheduler.instance)
            .subscribe{ _ in
                // then
                XCTAssert(homeUseCase.isGetGameCalled)
            }onError: { _ in
                XCTAssert(homeUseCase.isGetGameCalled)
            } onCompleted: {
                XCTAssert(homeUseCase.isGetGameCalled)
            }
            .disposed(by: disposeBag)
    }
}

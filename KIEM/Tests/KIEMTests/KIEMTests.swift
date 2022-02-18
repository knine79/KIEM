//
//  KIEMTests.swift
//  KIEMTests
//
//  Created by Samuel on 2022/02/18.
//

import XCTest
@testable import KIEM

class KIEMTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        XCTAssertEqual("ㅗ디ㅣㅐ, ㅏㅑ드".stringTypedInEnglishMode, "hello, kiem")
        XCTAssertEqual("KIEM은 Korean in English Mode의 약자입니다.".stringTypedInEnglishMode, "KIEMdms Korean in English Modedml dirwkdlqslek.")
        XCTAssertEqual("한글 문자열을 영문모드에서 타이핑한 문자열로 바꿔주는 라이브러리입니다.".stringTypedInEnglishMode, "gksrmf answkdufdmf dudansahemdptj xkdlvldgks answkduffh qkRnjwnsms fkdlqmfjfldlqslek.")
        XCTAssertEqual("😀👍👨🏻‍💻이런 이모지와 English등 한글이 아닌 것들은 원문 그대로 남아 있죠!!".stringTypedInEnglishMode, "😀👍👨🏻‍💻dlfjs dlahwldhk Englishemd gksrmfdl dksls rjtemfdms dnjsans rmeofh skadk dlTwy!!")
        XCTAssertEqual("자음,모음만 있는 경우도 잘 되고 ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎㅏㅐㅑㅒㅓㅔㅕㅖㅗㅛㅜㅠㅡㅣ,".stringTypedInEnglishMode, "wkdma,ahdmaaks dlTsms ruddneh wkf ehlrh rRseEfaqQtTdwWczxvgkoiOjpuPhynbml,")
        XCTAssertEqual("이중모음,이중자음도 잘 됩니다. ㅝㅘㅞㅢ읽짧잃슲".stringTypedInEnglishMode, "dlwndahdma,dlwndwkdmaeh wkf ehlqslek. njhknpmldlfrWkfqdlfgtmfv")
    }
}

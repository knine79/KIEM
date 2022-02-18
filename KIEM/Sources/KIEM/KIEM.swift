//
//  KIEM.swift
//  KIEM
//
//  Created by Samuel on 2022/02/18.
//

import Foundation

extension UnicodeScalar {
    public var isHangulConsonant: Bool {
        0x3130 <= value && value <= 0x314e
    }
    
    public var isHangulVowel: Bool {
        0x314f <= value && value <= 0x3163
    }
    
    public var isHangulSyllable: Bool {
        0xac00 <= value && value <= 0xd7af
    }
    
    public var hangulInitialConsonantIndex: Int? {
        guard isHangulSyllable else { return nil }
        return ((Int(value) - 0xac00) / caseCountOfFinalConsonant) / numberOfMedialVowel
    }
    
    public var hangulMedialVowelIndex: Int? {
        guard isHangulSyllable else { return nil }
        return ((Int(value) - 0xac00) / caseCountOfFinalConsonant) % numberOfMedialVowel
    }
    
    public var hangulFinalConsonantIndex: Int? {
        guard isHangulSyllable else { return nil }
        let indexOfFinalConsonantCase = (Int(value) - 0xac00) % caseCountOfFinalConsonant
        return indexOfFinalConsonantCase == 0 ? nil : indexOfFinalConsonantCase - 1
    }
    
    public var isHangul: Bool {
        isHangulConsonant || isHangulVowel || hangulInitialConsonantIndex != nil || hangulMedialVowelIndex != nil || hangulFinalConsonantIndex != nil
    }
    
    private var numberOfinitialConsonant: Int { 19 }
    private var numberOfMedialVowel: Int { 21 }
    private var caseCountOfFinalConsonant: Int { 28 } // 종성이 없는 경우도 포함된 개수
    
    private var phonemes: Array<Character> {
        Array("ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎㅁㄴㅇㄹㅎㅋㅌㅊㅍㅏㅐㅑㅒㅓㅔㅕㅖㅗㅛㅜㅠㅡㅣㅛㅕㅑㅗㅓㅏㅣㅠㅜㅡ")  // 33 + 19개
    }
    
    private var initialConsonants: Array<Character> {
        Array("ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎ")  // 19개
    }
    
    private var medialVowels: Array<Character> {
        Array("ㅏㅐㅑㅒㅓㅔㅕㅖㅗㅘㅙㅚㅛㅜㅝㅞㅟㅠㅡㅢㅣ") // 중성 21개
    }
    
    private var finalConsonants: Array<Character> {
        Array("ㄱㄲㄳㄴㄵㄶㄷㄹㄺㄻㄼㄽㄾㄿㅀㅁㅂㅄㅅㅆㅇㅈㅊㅋㅌㅍㅎ")  // 27개
    }
    
    public var charactersTypedInEnglishMode: [Character] {
        var decomposedIndices: [Int?] = []
        if isHangulSyllable {
            let initialConsonant = ((Int(value) - 0xac00) / caseCountOfFinalConsonant) / numberOfMedialVowel
            decomposedIndices = [initialConsonant] + decomposeDoubleVowel(hangulMedialVowelIndex) + decomposeDoubleFinalConsonant(hangulFinalConsonantIndex)
        } else if isHangulConsonant || isHangulVowel {
            if let initialConsonant = initialConsonants.firstIndex(of: Character(self)) {
                decomposedIndices = [initialConsonant]
            } else if let medialVowel = medialVowels.firstIndex(of: Character(self)) {
                decomposedIndices = decomposeDoubleVowel(medialVowel)
            } else if let finalConsonant = finalConsonants.firstIndex(of: Character(self)) {
                decomposedIndices = decomposeDoubleFinalConsonant(finalConsonant)
            }
        } else {
            return [Character(self)]
        }
        let englishKeys = Array("rRseEfaqQtTdwWczxvgASDFGZXCVkoiOjpuPhynbmlYUIHJKLBNM") // 33 + 19개
        return decomposedIndices.compactMap { $0 }.map { englishKeys[safe: $0] ?? Character(self) }
    }
    
    private func decomposeDoubleVowel(_ vowel: Int?) -> [Int?] {
        let doubleVowelMap = [
            "ㅘ": ("ㅗ", "ㅏ"), "ㅙ": ("ㅗ", "ㅐ"), "ㅚ": ("ㅗ", "ㅣ"),
            "ㅝ": ("ㅜ", "ㅓ"), "ㅞ": ("ㅜ", "ㅔ"), "ㅟ": ("ㅜ", "ㅣ"),
            "ㅢ": ("ㅡ", "ㅣ")
        ]
        if let decomposedVowels = doubleVowelMap.first(where: { vowel == medialVowels.firstIndex(of: Character($0.key)) })?.value {
            return [phonemes.firstIndex(of: Character(decomposedVowels.0)), phonemes.firstIndex(of: Character(decomposedVowels.1))]
        } else {
            return [vowel == nil ? nil : phonemes.firstIndex(of: medialVowels[vowel!])]
        }
    }
    
    private func decomposeDoubleFinalConsonant(_ consonant: Int?) -> [Int?] {
        let doubleConsonantMap = [
            "ㄳ": ("ㄱ", "ㅅ"), "ㄵ": ("ㄴ", "ㅈ"), "ㄶ": ("ㄴ", "ㅎ"),
            "ㄺ": ("ㄹ", "ㄱ"), "ㄻ": ("ㄹ", "ㅁ"), "ㄼ": ("ㄹ", "ㅂ"),
            "ㄽ": ("ㄹ", "ㅅ"), "ㄾ": ("ㄹ", "ㅌ"), "ㄿ": ("ㄹ", "ㅍ"),
            "ㅀ": ("ㄹ", "ㅎ"), "ㅄ": ("ㅂ", "ㅅ")
        ]
        if let decomposedConsonants = doubleConsonantMap.first(where: { consonant == finalConsonants.firstIndex(of: Character($0.key)) })?.value {
            return [phonemes.firstIndex(of: Character(decomposedConsonants.0)), phonemes.firstIndex(of: Character(decomposedConsonants.1))]
        } else {
            return [consonant == nil ? nil : phonemes.firstIndex(of: finalConsonants[consonant!])]
        }
    }
}

extension String {
    public var stringTypedInEnglishMode: String {
        String(unicodeScalars.map { $0.charactersTypedInEnglishMode }.flatMap { $0 })
    }
}

extension Character {
    public var isHangul: Bool {
        unicodeScalars.map { $0.isHangul }.reduce(true, { $0 && $1 })
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

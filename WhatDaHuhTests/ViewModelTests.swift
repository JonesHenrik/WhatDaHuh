//
//  ViewModelTests.swift
//  WhatDaHuhTests
//
//  Unit tests for: Levenshtein distance, Badge unlock logic,
//  ViewModel unlock, search, sort/filter, and persistence.
//
//  Run with: Cmd+U in Xcode after adding the WhatDaHuhTests target.
//  Import style: @testable gives access to internal declarations.
//

@testable import WhatDaHuh
import XCTest

// MARK: - Levenshtein Distance
// Pure free function — no ViewModel or test fixtures needed.

final class LevenshteinDistanceTests: XCTestCase {

    func test_identicalStrings_returnsZero() {
        XCTAssertEqual(levenshteinDistance("rizz", "rizz"), 0)
    }

    func test_bothEmpty_returnsZero() {
        XCTAssertEqual(levenshteinDistance("", ""), 0)
    }

    func test_emptyVsWord_returnsWordLength() {
        XCTAssertEqual(levenshteinDistance("", "rizz"), 4)
        XCTAssertEqual(levenshteinDistance("rizz", ""), 4)
    }

    func test_singleSubstitution_returnsOne() {
        // "rizz" → "ryzz": one substitution (i→y)
        XCTAssertEqual(levenshteinDistance("rizz", "ryzz"), 1)
    }

    func test_singleInsertion_returnsOne() {
        // "rizz" → "rizzz": one insertion
        XCTAssertEqual(levenshteinDistance("rizz", "rizzz"), 1)
    }

    func test_singleDeletion_returnsOne() {
        // "rizz" → "riz": one deletion
        XCTAssertEqual(levenshteinDistance("rizz", "riz"), 1)
    }

    func test_twoEdits_returnsTwo() {
        // "cat" → "cut" (a→u) → "gut" (c→g) = 2 substitutions
        XCTAssertEqual(levenshteinDistance("cat", "gut"), 2)
    }

    func test_fullyDifferentStrings_returnsHighDistance() {
        // "abc" → "xyz": 3 substitutions
        XCTAssertEqual(levenshteinDistance("abc", "xyz"), 3)
    }

    func test_isSymmetric() {
        // d(a, b) must equal d(b, a) by definition
        let forward  = levenshteinDistance("rizz", "goated")
        let backward = levenshteinDistance("goated", "rizz")
        XCTAssertEqual(forward, backward)
    }
}

// MARK: - Badge.isFullyUnlocked
// Pure method on a value type — no ViewModel needed.

final class BadgeUnlockTests: XCTestCase {

    private func makeBadge(words: [String]) -> Badge {
        Badge(title: "Test", imageName: "test", words: words, description: "")
    }

    func test_allWordsPresent_returnsTrue() {
        let badge = makeBadge(words: ["rizz", "goated"])
        XCTAssertTrue(badge.isFullyUnlocked(given: ["rizz", "goated"]))
    }

    func test_oneWordMissing_returnsFalse() {
        let badge = makeBadge(words: ["rizz", "goated"])
        XCTAssertFalse(badge.isFullyUnlocked(given: ["rizz"]))
    }

    func test_noWordsUnlocked_returnsFalse() {
        let badge = makeBadge(words: ["rizz"])
        XCTAssertFalse(badge.isFullyUnlocked(given: []))
    }

    func test_emptyBadgeWords_returnsTrue() {
        // allSatisfy on an empty collection is vacuously true
        let badge = makeBadge(words: [])
        XCTAssertTrue(badge.isFullyUnlocked(given: []))
    }

    func test_mixedCaseWords_matchesLowercasedTitles() {
        // badge.words may use mixed case; unlockedTitles stores lowercase
        let badge = makeBadge(words: ["Rizz", "GOATED"])
        XCTAssertTrue(badge.isFullyUnlocked(given: ["rizz", "goated"]))
    }

    func test_displayImageName_fullyUnlocked_returnsOwnImageName() {
        let badge = Badge(title: "T", imageName: "myBadge", words: ["rizz"], description: "")
        XCTAssertEqual(badge.displayImageName(given: ["rizz"]), "myBadge")
    }

    func test_displayImageName_locked_returnsLockedBadge() {
        let badge = Badge(title: "T", imageName: "myBadge", words: ["rizz"], description: "")
        XCTAssertEqual(badge.displayImageName(given: []), "lockedBadge")
    }
}

// MARK: - ViewModel
// All tests use a temp URL so they never touch the real Documents directory.

@MainActor
final class ViewModelTests: XCTestCase {

    var vm: ViewModel!
    var tempURL: URL!

    override func setUp() async throws {
        try await super.setUp()
        // Unique filename per test prevents cross-test file pollution.
        tempURL = FileManager.default.temporaryDirectory
            .appending(path: "whatdahuh_test_\(UUID().uuidString).json")
        vm = ViewModel(fileURL: tempURL)
    }

    override func tearDown() async throws {
        try? FileManager.default.removeItem(at: tempURL)
        vm = nil
        tempURL = nil
        try await super.tearDown()
    }

    // MARK: - Helpers

    /// Builds a minimal Word whose title does NOT exist in `wordToBadge`,
    /// keeping most tests isolated from badge-completion logic.
    private func makeWord(_ title: String, isLowkeyGem: Bool = false) -> Word {
        Word(
            title: title,
            wordClass: "noun",
            phoneticSpelling: title,
            definitions: ["test definition"],
            phrases: ["test phrase"],
            isLowkeyGem: isLowkeyGem,
            isUnlocked: false
        )
    }

    /// Pattern-match helper — fails the test with a readable message if
    /// `result` is not `.notFound`.
    private func assertNotFound(
        _ result: SearchResult,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard case .notFound = result else {
            XCTFail("Expected .notFound but got \(result)", file: file, line: line)
            return
        }
    }

    // MARK: - Unlock

    func test_unlock_addsToUnlockedTitles() {
        vm.unlock(word: makeWord("zork"))
        XCTAssertTrue(vm.unlockedTitles.contains("zork"))
    }

    func test_unlock_normalizesToLowercase() {
        vm.unlock(word: makeWord("ZORK"))
        XCTAssertTrue(vm.unlockedTitles.contains("zork"))
        XCTAssertFalse(vm.unlockedTitles.contains("ZORK"))
    }

    func test_unlock_appendsToUnlockedOrder() {
        vm.unlock(word: makeWord("zork"))
        XCTAssertEqual(vm.unlockedOrder, ["zork"])
    }

    func test_unlock_sameWordTwice_doesNotDuplicate() {
        let word = makeWord("zork")
        vm.unlock(word: word)
        vm.unlock(word: word)
        XCTAssertEqual(vm.unlockedTitles.count, 1)
        XCTAssertEqual(vm.unlockedOrder.count, 1)
    }

    func test_isUnlocked_trueAfterUnlock() {
        let word = makeWord("zork")
        vm.unlock(word: word)
        XCTAssertTrue(vm.isUnlocked(word))
    }

    func test_isUnlocked_falseBeforeUnlock() {
        XCTAssertFalse(vm.isUnlocked(makeWord("zork")))
    }

    func test_unlock_preservesChronologicalOrder() {
        ["zork", "quux", "flerb"].map { makeWord($0) }.forEach { vm.unlock(word: $0) }
        XCTAssertEqual(vm.unlockedOrder, ["zork", "quux", "flerb"])
    }

    // MARK: - Search: Exact Match

    func test_submitSearch_exactMatch_returnsWordUnlocked() {
        let bank = [makeWord("zork")]
        let result = vm.submitSearch(input: "zork", wordBank: bank, badgeBank: [])
        guard case .wordUnlocked(let word) = result else {
            XCTFail("Expected .wordUnlocked, got \(result)"); return
        }
        XCTAssertEqual(word.title, "zork")
    }

    func test_submitSearch_isCaseInsensitive() {
        let bank = [makeWord("zork")]
        let result = vm.submitSearch(input: "ZORK", wordBank: bank, badgeBank: [])
        guard case .wordUnlocked = result else {
            XCTFail("Expected .wordUnlocked, got \(result)"); return
        }
    }

    func test_submitSearch_trimsLeadingAndTrailingWhitespace() {
        let bank = [makeWord("zork")]
        let result = vm.submitSearch(input: "  zork  ", wordBank: bank, badgeBank: [])
        guard case .wordUnlocked = result else {
            XCTFail("Expected .wordUnlocked, got \(result)"); return
        }
    }

    // MARK: - Search: One-Letter Tolerance

    func test_submitSearch_oneLetterSubstitution_returnsWordUnlocked() {
        // "zark" → "zork": substitution o→a, distance = 1
        let bank = [makeWord("zork")]
        let result = vm.submitSearch(input: "zark", wordBank: bank, badgeBank: [])
        guard case .wordUnlocked(let word) = result else {
            XCTFail("Expected .wordUnlocked, got \(result)"); return
        }
        XCTAssertEqual(word.title, "zork")
    }

    func test_submitSearch_oneLetterInsertion_returnsWordUnlocked() {
        // "zorkk" → "zork": one extra character, distance = 1
        let bank = [makeWord("zork")]
        let result = vm.submitSearch(input: "zorkk", wordBank: bank, badgeBank: [])
        guard case .wordUnlocked(let word) = result else {
            XCTFail("Expected .wordUnlocked, got \(result)"); return
        }
        XCTAssertEqual(word.title, "zork")
    }

    func test_submitSearch_oneLetterDeletion_returnsWordUnlocked() {
        // "zor" → "zork": one missing character, distance = 1
        let bank = [makeWord("zork")]
        let result = vm.submitSearch(input: "zor", wordBank: bank, badgeBank: [])
        guard case .wordUnlocked(let word) = result else {
            XCTFail("Expected .wordUnlocked, got \(result)"); return
        }
        XCTAssertEqual(word.title, "zork")
    }

    // MARK: - Search: Not Found

    func test_submitSearch_noMatch_returnsNotFound() {
        // "aaaa" is distance 4 from "zork" — well outside tolerance
        assertNotFound(vm.submitSearch(input: "aaaa", wordBank: [makeWord("zork")], badgeBank: []))
    }

    func test_submitSearch_twoLettersOff_returnsNotFound() {
        // "zaak" is distance 2 from "zork" (o→a, r→a)
        assertNotFound(vm.submitSearch(input: "zaak", wordBank: [makeWord("zork")], badgeBank: []))
    }

    func test_submitSearch_emptyInput_returnsNotFound() {
        assertNotFound(vm.submitSearch(input: "", wordBank: [makeWord("zork")], badgeBank: []))
    }

    func test_submitSearch_whitespaceOnlyInput_returnsNotFound() {
        assertNotFound(vm.submitSearch(input: "   ", wordBank: [makeWord("zork")], badgeBank: []))
    }

    func test_submitSearch_emptyWordBank_returnsNotFound() {
        assertNotFound(vm.submitSearch(input: "zork", wordBank: [], badgeBank: []))
    }

    // MARK: - Search: Already Unlocked

    func test_submitSearch_alreadyUnlocked_returnsAlreadyUnlocked() {
        let word = makeWord("zork")
        vm.unlock(word: word)
        let result = vm.submitSearch(input: "zork", wordBank: [word], badgeBank: [])
        guard case .alreadyUnlocked = result else {
            XCTFail("Expected .alreadyUnlocked, got \(result)"); return
        }
    }

    func test_submitSearch_alreadyUnlocked_doesNotGrowUnlockedOrder() {
        let word = makeWord("zork")
        vm.unlock(word: word)
        _ = vm.submitSearch(input: "zork", wordBank: [word], badgeBank: [])
        XCTAssertEqual(vm.unlockedOrder.count, 1)
    }

    // MARK: - Search: Badge Completion
    // Uses real words from the "Certified W" badge because wordToBadge
    // is a module-level constant built from badgeBank.

    func test_submitSearch_completingLastWordOfBadge_returnsBadgeEarned() {
        // "Certified W" badge requires: ["rizz", "goated", "tuff", "w", "hits"]
        let badgeWords = ["rizz", "goated", "tuff", "w", "hits"]
        let testBank = badgeWords.map { makeWord($0) }

        // Unlock the first four directly — only "hits" is missing.
        testBank.dropLast().forEach { vm.unlock(word: $0) }

        let result = vm.submitSearch(input: "hits", wordBank: testBank, badgeBank: badgeBank)
        guard case .badgeEarned(let word, let badge) = result else {
            XCTFail("Expected .badgeEarned, got \(result)"); return
        }
        XCTAssertEqual(word.title, "hits")
        XCTAssertEqual(badge.title, "Certified W")
    }

    func test_submitSearch_partialBadgeProgress_returnsWordUnlocked() {
        // Unlocking one word of a 5-word badge must not trigger completion.
        let testBank = [makeWord("rizz")]
        let result = vm.submitSearch(input: "rizz", wordBank: testBank, badgeBank: badgeBank)
        guard case .wordUnlocked = result else {
            XCTFail("Expected .wordUnlocked, got \(result)"); return
        }
    }

    // MARK: - Sort: Alphabetical A–Z

    func test_unlockedWordsAZ_returnsSortedByTitle() {
        let bank = [makeWord("zork"), makeWord("apple"), makeWord("mango")]
        bank.forEach { vm.unlock(word: $0) }
        XCTAssertEqual(vm.unlockedWordsAZ(from: bank).map(\.title), ["apple", "mango", "zork"])
    }

    func test_unlockedWordsAZ_excludesLockedWords() {
        let bank = [makeWord("zork"), makeWord("apple"), makeWord("mango")]
        vm.unlock(word: bank[0])   // only "zork" unlocked
        XCTAssertEqual(vm.unlockedWordsAZ(from: bank).map(\.title), ["zork"])
    }

    func test_unlockedWordsAZ_emptyWhenNoneUnlocked() {
        XCTAssertTrue(vm.unlockedWordsAZ(from: [makeWord("zork")]).isEmpty)
    }

    func test_unlockedWordsAZ_emptyWordBank_returnsEmpty() {
        vm.unlock(word: makeWord("zork"))
        XCTAssertTrue(vm.unlockedWordsAZ(from: []).isEmpty)
    }

    // MARK: - Sort: Lowkey Gems

    func test_unlockedLowkeyGemsAZ_returnsOnlyGems() {
        let bank = [makeWord("regular"), makeWord("sparkle", isLowkeyGem: true)]
        bank.forEach { vm.unlock(word: $0) }
        XCTAssertEqual(vm.unlockedLowkeyGemsAZ(from: bank).map(\.title), ["sparkle"])
    }

    func test_unlockedLowkeyGemsAZ_emptyWhenNoGemsUnlocked() {
        let bank = [makeWord("regular"), makeWord("also regular")]
        bank.forEach { vm.unlock(word: $0) }
        XCTAssertTrue(vm.unlockedLowkeyGemsAZ(from: bank).isEmpty)
    }

    func test_unlockedLowkeyGemsAZ_excludesLockedGems() {
        // Gem exists in bank but was never unlocked — must not appear.
        let bank = [makeWord("hidden gem", isLowkeyGem: true)]
        XCTAssertTrue(vm.unlockedLowkeyGemsAZ(from: bank).isEmpty)
    }

    func test_unlockedLowkeyGemsAZ_sortedAlphabetically() {
        let bank = [
            makeWord("zap", isLowkeyGem: true),
            makeWord("ace", isLowkeyGem: true),
            makeWord("mid", isLowkeyGem: true)
        ]
        bank.forEach { vm.unlock(word: $0) }
        XCTAssertEqual(vm.unlockedLowkeyGemsAZ(from: bank).map(\.title), ["ace", "mid", "zap"])
    }

    // MARK: - Sort: Boomer → Alpha (oldest first)

    func test_unlockedWordsOldestFirst_preservesUnlockOrder() {
        let words = ["first", "second", "third"].map { makeWord($0) }
        words.forEach { vm.unlock(word: $0) }
        XCTAssertEqual(
            vm.unlockedWordsOldestFirst(from: words).map(\.title),
            ["first", "second", "third"]
        )
    }

    func test_unlockedWordsOldestFirst_emptyWhenNoneUnlocked() {
        XCTAssertTrue(vm.unlockedWordsOldestFirst(from: [makeWord("zork")]).isEmpty)
    }

    func test_unlockedWordsOldestFirst_wordsNotInBankAreDropped() {
        // If unlockedOrder references a title that's absent from the supplied bank,
        // compactMap silently drops it — the result must still be stable.
        vm.unlock(word: makeWord("zork"))
        let result = vm.unlockedWordsOldestFirst(from: [])
        XCTAssertTrue(result.isEmpty)
    }

    // MARK: - Sort: Alpha → Boomer (newest first)

    func test_unlockedWordsRecentFirst_reversesUnlockOrder() {
        let words = ["first", "second", "third"].map { makeWord($0) }
        words.forEach { vm.unlock(word: $0) }
        XCTAssertEqual(
            vm.unlockedWordsRecentFirst(from: words).map(\.title),
            ["third", "second", "first"]
        )
    }

    func test_unlockedWordsRecentFirst_singleWord_returnsThatWord() {
        let word = makeWord("zork")
        vm.unlock(word: word)
        XCTAssertEqual(vm.unlockedWordsRecentFirst(from: [word]).map(\.title), ["zork"])
    }

    func test_unlockedWordsRecentFirst_emptyWhenNoneUnlocked() {
        XCTAssertTrue(vm.unlockedWordsRecentFirst(from: [makeWord("zork")]).isEmpty)
    }

    // MARK: - stringToWord

    func test_stringToWord_findsExactMatch() {
        let bank = [makeWord("rizz")]
        XCTAssertEqual(vm.stringToWord(for: "rizz", from: bank)?.title, "rizz")
    }

    func test_stringToWord_isCaseInsensitive() {
        let bank = [makeWord("rizz")]
        XCTAssertNotNil(vm.stringToWord(for: "RIZZ", from: bank))
    }

    func test_stringToWord_trimsWhitespace() {
        let bank = [makeWord("rizz")]
        XCTAssertNotNil(vm.stringToWord(for: "  rizz  ", from: bank))
    }

    func test_stringToWord_returnsNilWhenNotFound() {
        XCTAssertNil(vm.stringToWord(for: "goated", from: [makeWord("rizz")]))
    }

    func test_stringToWord_emptyWordBank_returnsNil() {
        XCTAssertNil(vm.stringToWord(for: "rizz", from: []))
    }

    // MARK: - mostRecentlyUnlockedWord

    func test_mostRecentlyUnlockedWord_returnsLastInOrder() {
        let words = ["zork", "quux", "flerb"].map { makeWord($0) }
        words.forEach { vm.unlock(word: $0) }
        XCTAssertEqual(vm.mostRecentlyUnlockedWord(from: words)?.title, "flerb")
    }

    func test_mostRecentlyUnlockedWord_nilWhenNoneUnlocked() {
        XCTAssertNil(vm.mostRecentlyUnlockedWord(from: [makeWord("zork")]))
    }

    // MARK: - Persistence

    func test_unlockedWordsPersistAcrossViewModelInstances() {
        // vm writes "zork" to tempURL via saveUnlockedWords.
        vm.unlock(word: makeWord("zork"))

        // A fresh ViewModel pointing at the same file must see the saved data.
        let vm2 = ViewModel(fileURL: tempURL)
        XCTAssertTrue(vm2.unlockedTitles.contains("zork"))
        XCTAssertEqual(vm2.unlockedOrder, ["zork"])
    }

    func test_corruptedPersistenceFile_startsWithCleanState() {
        // Write garbage JSON to the temp file before init.
        try? "{ not valid json ]".data(using: .utf8)!.write(to: tempURL)
        let corruptVM = ViewModel(fileURL: tempURL)
        XCTAssertTrue(corruptVM.unlockedTitles.isEmpty)
        XCTAssertTrue(corruptVM.unlockedOrder.isEmpty)
    }
}

//
//  StorageProvider.swift
//  SkyengTestTask
//
//  Created by Дмитрий Х on 07.01.2022.
//

import Foundation

final class Cache<Key: Hashable, Value> {
	private let wrapped = NSCache<WrappedKey, Entry>()
	private let dateProvider: () -> Date
	private let entryLifetime: TimeInterval
	private let keyTracker = KeyTracker()
	
	init(dateProvider: @escaping () -> Date = Date.init,
		 entryLifetime: TimeInterval = 1,
		 maximumEntryCount: Int = 1) {
		self.dateProvider = dateProvider
		self.entryLifetime = entryLifetime
		wrapped.countLimit = maximumEntryCount
		wrapped.delegate = keyTracker
	}
	
	func insert(_ value: Value, forKey key: Key) {
		let date = dateProvider().addingTimeInterval(entryLifetime)
		let entry = Entry(key: key, value: value, expirationDate: date)
		insert(entry)
	}
	
	subscript(key: Key) -> Value? {
		get { return value(forKey: key) }
		set {
			guard let value = newValue else {
				removeValue(forKey: key)
				return
			}
			
			insert(value, forKey: key)
		}
	}
	
	func value(forKey key: Key) -> Value? {
		guard let entry = entry(forKey: key) else { return nil }
		return entry.value
	}
	
	func removeValue(forKey key: Key) {
		wrapped.removeObject(forKey: WrappedKey(key))
	}
}

private extension Cache {
	final class WrappedKey: NSObject {
		let key: Key
		
		init(_ key: Key) { self.key = key }
		
		override var hash: Int { return key.hashValue }
		
		override func isEqual(_ object: Any?) -> Bool {
			guard let value = object as? WrappedKey else {
				return false
			}
			
			return value.key == key
		}
	}
	
	final class Entry {
		let key: Key
		let value: Value
		let expirationDate: Date
		
		init(key: Key, value: Value, expirationDate: Date) {
			self.key = key
			self.value = value
			self.expirationDate = expirationDate
		}
	}
	
	final class KeyTracker: NSObject, NSCacheDelegate {
		var keys = Set<Key>()
		
		func cache(_ cache: NSCache<AnyObject, AnyObject>,
				   willEvictObject object: Any) {
			guard let entry = object as? Entry else {
				return
			}
			
			keys.remove(entry.key)
		}
	}
	
	func entry(forKey key: Key) -> Entry? {
		guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
			return nil
		}
		
		guard dateProvider() < entry.expirationDate else {
			removeValue(forKey: key)
			return nil
		}
		
		return entry
	}
	
	func insert(_ entry: Entry) {
		wrapped.setObject(entry, forKey: WrappedKey(entry.key))
		keyTracker.keys.insert(entry.key)
	}
}

extension Cache.Entry: Codable where Key: Codable, Value: Codable {}

extension Cache: Codable where Key: Codable, Value: Codable {
	convenience init(from decoder: Decoder) throws {
		self.init()
		
		let container = try decoder.singleValueContainer()
		let entries = try container.decode([Entry].self)
		entries.forEach(insert)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(keyTracker.keys.compactMap(entry))
	}
	
	func saveToDisk(withName name: String) throws {
		let data = try JSONEncoder().encode(self)
		try data.write(to: makeFileUrl(with: name))
	}
	
	func loadFromDisk(named name: String) throws -> Cache<Key, Value> {
		let data = try Data(contentsOf: makeFileUrl(with: name))
		let cache = try JSONDecoder().decode(Cache<Key, Value>.self, from: data)
		return cache
	}
	
	private func makeFileUrl(with name: String) -> URL {
		let folderURLs = FileManager
			.default.urls(for: .cachesDirectory, in: .userDomainMask)
		return folderURLs[0].appendingPathComponent(name + ".cache")
	}
}

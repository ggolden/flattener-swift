//
//  FlattenerSwift.playground
//
//  Copyright 2017 Glenn R. Golden
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//  for a clue as to what this is, see https://github.com/ggolden/flattener-swift
//

import XCTest

// flatten the array of arbitrary mix of objects and similar arrays into a single array of objects
func flatten(_ array: [Any]) -> [Any]
{
	// accumulate the result here
	var rv: [Any] = []
	
	// process each item
	for item in array
	{
		// when we run into an array, recurse on it, appending the results
		if let itemAsArray = item as? [Any]
		{
			rv.append(contentsOf: flatten(itemAsArray))
		}
			
			// when we run into a non-array item, simply append it
		else
		{
			rv.append(item)
		}
	}
	
	// here's what we got
	return rv
}

class FlattenerTests: XCTestCase
{
	func testFlaten()
	{
		var target: [Any] = []
		var sample: [Any] = []
		var flattened = flatten(sample)
		XCTAssertTrue(isEqualArray(Int.self, flattened, target)!, "\(sample) -> \(flattened)")
		
		target = [1,2,3,4,5,6,7]
		sample = [1,2,3,4,5,6,7]
		flattened = flatten(sample)
		XCTAssertTrue(isEqualArray(Int.self, flattened, target)!, "\(sample) -> \(flattened)")
		
		target = [1,2,3,4,5,6,7]
		sample = [[1],[2],[3],[4],[5],[6],[7]]
		flattened = flatten(sample)
		XCTAssertTrue(isEqualArray(Int.self, flattened, target)!, "\(sample) -> \(flattened)")
		
		target = [1,2,3,4,5,6,7]
		sample = [[1,2],[3,4],[5,6],[7]]
		flattened = flatten(sample)
		XCTAssertTrue(isEqualArray(Int.self, flattened, target)!, "\(sample) -> \(flattened)")
		
		target = [1,2,3,4,5,6,7]
		sample = [[1,2,3,4],[5,6],7]
		flattened = flatten(sample)
		XCTAssertTrue(isEqualArray(Int.self, flattened, target)!, "\(sample) -> \(flattened)")
		
		target = [1,2,3,4]
		sample = [[1,2,3],4]
		flattened = flatten(sample)
		XCTAssertTrue(isEqualArray(Int.self, flattened, target)!, "\(sample) -> \(flattened)")
		
		target = [1,2,3,4]
		sample = [[1,2,[3]],4]
		flattened = flatten(sample)
		XCTAssertTrue(isEqualArray(Int.self, flattened, target)!, "\(sample) -> \(flattened)")
		
		target = [1,2,3,4]
		sample = [[1,[[2]],[3]],4]
		flattened = flatten(sample)
		XCTAssertTrue(isEqualArray(Int.self, flattened, target)!, "\(sample) -> \(flattened)")

		target = [1,2,3,4,5,6]
		sample = [[1,[[2,3]],[4,5]],6]
		flattened = flatten(sample)
		XCTAssertTrue(isEqualArray(Int.self, flattened, target)!, "\(sample) -> \(flattened)")
	}
	
	// helper for the test, to compare two arrays of any single type
	func isEqualArray<T: Equatable>(_ type: T.Type, _ a: [Any], _ b: [Any]) -> Bool?
	{
		if (a.count != b.count)
		{
			return false
		}
		for i in 0 ..< a.count
		{
			if let aItem = a[i] as? T, let bItem = b[i] as? T
			{
				if aItem != bItem
				{
					return false
				}
			}
			else
			{
				return false
			}
		}
		
		return true
	}
}

// run the tests
let test = FlattenerTests.defaultTestSuite()
test.run()


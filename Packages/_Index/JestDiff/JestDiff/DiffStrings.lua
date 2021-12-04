-- upstream: https://github.com/facebook/jest/blob/v26.5.3/packages/jest-diff/src/diffStrings.ts
-- /**
--  * Copyright (c) Facebook, Inc. and its affiliates. All Rights Reserved.
--  *
--  * This source code is licensed under the MIT license found in the
--  * LICENSE file in the root directory of this source tree.
--  */

local CurrentModule = script.Parent
local Packages = CurrentModule.Parent

local diffSequences = require(Packages.DiffSequences)

local DIFF_DELETE = require(CurrentModule.CleanupSemantic).DIFF_DELETE
local DIFF_EQUAL = require(CurrentModule.CleanupSemantic).DIFF_EQUAL
local DIFF_INSERT = require(CurrentModule.CleanupSemantic).DIFF_INSERT
local Diff = require(CurrentModule.CleanupSemantic).Diff

return function(a: string, b: string): { [number]: any }
	local isCommon = function(aIndex: number, bIndex: number)
		return a:sub(aIndex + 1, aIndex + 1) == b:sub(bIndex + 1, bIndex + 1)
	end

	local aIndex = 0
	local bIndex = 0
	local diffs = {}

	local foundSubsequence = function(
		nCommon: number,
		aCommon: number,
		bCommon: number
	)
		if aIndex ~= aCommon then
			table.insert(diffs, Diff.new(DIFF_DELETE, a:sub(aIndex + 1, aCommon)))
		end
		if bIndex ~= bCommon then
			table.insert(diffs, Diff.new(DIFF_INSERT, b:sub(bIndex + 1, bCommon)))
		end

		aIndex = aCommon + nCommon -- // number of characters compared in a
		bIndex = bCommon + nCommon -- // number of characters compared in b
		table.insert(diffs, Diff.new(DIFF_EQUAL, b:sub(bCommon + 1, bIndex)))
	end

	diffSequences(#a, #b, isCommon, foundSubsequence)

	-- // After the last common subsequence, push remaining change items.
	if aIndex ~= #a then
		table.insert(diffs, Diff.new(DIFF_DELETE, a:sub(aIndex + 1)))
	end
	if bIndex ~= #b then
		table.insert(diffs, Diff.new(DIFF_INSERT, b:sub(bIndex + 1)))
	end

	return diffs
end
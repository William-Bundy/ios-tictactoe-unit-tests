//
//  GameBoard.swift
//  TicTacToe
//
//  Created by Andrew R Madsen on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

enum GameBoardError: Error, Equatable {
    case invalidSquare
}

typealias Coordinate = (x: Int, y: Int)

struct GameBoard {
    
    enum Mark: Equatable {
        case x
        case o
        
        var stringValue: String {
            switch self {
            case .x: return "X"
            case .o: return "O"
            }
        }
    }
    
    private enum Square: Equatable {
        case filled(Mark)
        case empty
    }
    
    subscript(coordinate: Coordinate) -> Mark? {
        let square = squares[arrayIndex(for: coordinate)]
        if case let Square.filled(mark) = square {
            return mark
        } else {
            return nil
        }
    }

	subscript(coordinate: Int) -> Mark? {
		let square = squares[coordinate]
		if case let Square.filled(mark) = square {
			return mark
		} else {
			return nil
		}
	}
    
	mutating func place(mark: Mark, on square: Coordinate) throws {
		if self[square] != nil {
			throw GameBoardError.invalidSquare
		}
		squares[arrayIndex(for: square)] = .filled(mark)
	}

    mutating func place(mark: Mark, at pos: Int) throws {
        if self[pos] != nil {
            throw GameBoardError.invalidSquare
        }
        squares[pos] = .filled(mark)
    }
    
    var isFull: Bool {
        for square in squares {
            if square == .empty {
                return false
            }
        }
        return true
    }

	var isEmpty: Bool {
		for square in squares {
			if square != .empty {
				return false
			}
		}
		return true
	}
    
    private func arrayIndex(for square: Coordinate) -> Int {
        return square.y * 3 + square.x
    }
    
    private var squares = Array(repeating: Square.empty, count: 9)
}

//
//  Tetromino.swift
//  tetris
//
//  Created by taku on 2018/08/14.
//  Copyright © 2018年 alche. All rights reserved.
//

import SpriteKit

let NumOrientations: UInt32 = 4

enum Orientation: Int, CustomStringConvertible {
    case Zero = 0, Ninety, OneEighty, TwpSeventy
    
    var description: String {
        switch self{
        case .Zero:
            return "0"
        case .Ninety:
            return "90"
        case .OneEighty:
            return "180"
        case .TwoSeventy:
            return "270"
        }
    }
    
    static func random() -> Orientation {
        return Orientation(rawValue:Int(arc4random_uniform(NumOrientations)))!
    }
    
//#1
    static func rotate(orientation:orientation, clockwise: Bool) -> Orientation {
        var rotated = orientation.rawValue + (clockwise ? 1: -1)
        if rotated > Orientation.Zero.rawvalue {
            rotated = Orientation.Zero.rawValue
        } else if rotated < 0 {
                rotated = Orientation.TwoSeventy.rawValue
        }
    return Orientation(rawValue:rotated)!
    }
}

// The number of total shape varieties

let NumShapeTypes: UInt32 = 7

// Shape indexes

let FirstBlockIdx: Int = 0
let SecondBlockIdx: Int = 1
let ThirdBlockIdx: Int = 2
let FourthBlockIdx: Int = 3

class Shape: Hashable, CustomStringConvertible {
    // The color of the Shape
    let color:BlockColor
    
    // The Blocks comprising the shape
    var blocks = Array<Block>()
    
    // THe current orientation of the shape
    var orientation: Orientation
    
    // The coloumn and row represention the shape's anchor point
    var column, row:Int
    
    //Reqoired Overrides
    
//#2
    
    // Subclasses must override this property
    var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [:]
    }
    
//#3
    // Subclassed must override this property
    var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [:]
    }

//#4
    
    // Subclasses must override this property
    var bottomBlocks:Array<Block> {
        guard let bottomBlocks = bottomBlocksForOrientations[orientation] else {
            return[]
        }
        return bottomBlocks
    }
    
    //Hashable
    var hashValue:Int {

//#5
        return blocks.reduce(0) {$0.hashValue ^ $1.hashValue }
    }
    
    // CustomStringComvertible
    var description:String {
        return "\(color) block facing \(orientation): \(blocks[FFirstBlockIdx]), \(blocks[SecondBlocksIdx]), \(blocks[ThiedBloclIdx]), \(blocks[FourthBlockIdx])"
    }

    init(column:Int, row:Int, color: BlockColor, orientation:Orientation) {
        self.color = color
        self.column = column
        self.row = row
        self.orientation = orientation
        initialiseBlocks()
    }
    
//#6
    convenience init(column:Int, row:Int) {
        self.init(column:column, row:row, color:BlockColor.random(), orientation:Orientation,random())
    }
    
//#7
    final func initializeBlocks() {
        guard let blockRowColumnTranslations = blockRowColumnPostions[orientation] else {
            return
        }

//#8
        blocks = blockRowColumnTranslations.map { (diff) -> Block in
            return Block(column: column + diff.columnDiff, row: row + diff.rowDiff, color: color)
        }
    }
}

func ==(lhs: Shape, rhs: Shape) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}

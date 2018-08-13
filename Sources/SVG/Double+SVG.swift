//
//  Double+SVG.swift
//  Rendering
//
//  Created by James Bean on 6/19/17.
//
//

// Attribution: https://github.com/timrwood/SVGPath/blob/master/SVGPath/SVGPath.swift

let numberSet: Set<UnicodeScalar> = ["-",".","0","1","2","3","4","5","6","7","8","9","e","E"]

func values(from pathValues: String) -> [Double] {
    
    var result: [String] = []
    var cur = ""
    var last = ""
    
    for char in pathValues.unicodeScalars {
        let next = String(char)
        if next == "-" && last != "" && last != "E" && last != "e" {
            if cur.utf16.count > 0 {
                result.append(cur)
            }
            cur = next
        } else if numberSet.contains(UnicodeScalar(char.value)!) {
            cur += next
        } else if cur.utf16.count > 0 {
            result.append(cur)
            cur = ""
        }
        last = next
    }
    
    result.append(cur)
    
    return result.compactMap { Double($0) }
}


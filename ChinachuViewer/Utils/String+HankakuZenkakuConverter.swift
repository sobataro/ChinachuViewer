//
// http://qiita.com/su_k/items/1dd6c9381bdd39c6cb64
//

import Foundation

extension String {
    private func convertFullWidthToHalfWidth(reverse: Bool) -> String {
        let str = NSMutableString(string: self) as CFMutableString
        CFStringTransform(str, nil, kCFStringTransformFullwidthHalfwidth, reverse)
        return str as String
    }

    var hankaku: String {
        return convertFullWidthToHalfWidth(false)
    }

    var zenkaku: String {
        return convertFullWidthToHalfWidth(true)
    }

    private func convertFullWidthToHalfWidthOnlyNumberAlphabet(fullWidth: Bool) -> String {
        var str = self
        let pattern = fullWidth ? "[A-Z0-9]+" : "[Ａ-Ｚ０-９]+"
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let results = regex.matchesInString(str, options: [], range: NSMakeRange(0, str.characters.count))

        results.reverse().forEach {
            let subStr = (str as NSString).substringWithRange($0.range)
            str = str.stringByReplacingOccurrencesOfString(
                subStr,
                withString: (fullWidth ? subStr.zenkaku : subStr.hankaku))
        }
        return str
    }

    var hankakuOnlyNumberAlphabet: String {
        return convertFullWidthToHalfWidthOnlyNumberAlphabet(false)
    }

    var zenkakuOnlyNumberAlphabet: String {
        return convertFullWidthToHalfWidthOnlyNumberAlphabet(true)
    }
}
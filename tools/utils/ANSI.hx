package utils;

enum abstract ANSICode(String) from String to String
{
	var Black = '\x1b[0;30m';
	var Red = '\x1b[0;31m';
	var Green = '\x1b[0;32m';
	var Yellow = '\x1b[0;33m';
	var Blue = '\x1b[0;34m';
	var Magenta = '\x1b[0;35m';
	var Cyan = '\x1b[0;36m';
	var Gray = '\x1b[0;37m';
	var White = '\x1b[1;37m';
	var BgBlack = '\x1b[40m';
	var BgRed = '\x1b[41m';
	var BgGreen = '\x1b[42m';
	var BgYellow = '\x1b[43m';
	var BgBlue = '\x1b[44m';
	var BgMagenta = '\x1b[45m';
	var BgCyan = '\x1b[46m';
	var BgWhite = '\x1b[47m';
	var Reset = '\x1b[0m';
	var Bold = '\x1b[1m';
	var Italic = '\x1b[3m';
	var Underline = '\x1b[4m';
	var Strikethrough = '\x1b[9m';
	var DoubleUnderline = '\x1b[21m';
	var Blink = '\x1b[5m';
	var Inverse = '\x1b[7m';
	var Hidden = '\x1b[8m';
	var BoldOff = '\x1b[22m';
	var ItalicOff = '\x1b[23m';
	var UnderlineOff = '\x1b[24m';
	var BlinkOff = '\x1b[25m';
	var InverseOff = '\x1b[27m';
	var HiddenOff = '\x1b[28m';
}

/**
 * Utility class for applying ANSI codes to strings for terminal output.
 */
class ANSI
{
	/**
	 * Applies the specified ANSI codes to the input string.
	 * You can pass one or multiple ANSI codes for combining styles.
	 * @param input The input string.
	 * @param codes The ANSI codes to apply.
	 * @param reset Whether to reset the style after the input. Defaults to true.
	 * @return The styled string.
	 */
	public static function apply(input:String, codes:Array<ANSICode>, reset:Bool = true):String
	{
		var styledString = codes.join('') + input;

		if (reset) 
			styledString += ANSICode.Reset;

		return styledString;
	}
}

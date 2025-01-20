package utils;

enum abstract Architecture(String)
{
	var ARM64;
	var ARMV7;
	var X86;
	var X86_64;

	@:from
	public static function fromFlag(flag:String):Null<Architecture>
	{
		switch (flag.toLowerCase())
		{
			case "-arm64":
				return ARM64;
			case "-armv7":
				return ARMV7;
			case "-x86":
				return X86;
			case "-x86_64":
				return X86_64;
			default:
				return null;
		}
	}

	@:to
	public inline function toFlag():String
	{
		return '-' + this;
	}
}

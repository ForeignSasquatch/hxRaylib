package utils;

using StringTools;

/**
 * @see https://github.com/openfl/hxp/blob/master/src/hxp/Script.hx
 */
@:nullSafety
class Cli
{
	public var args:Array<String> = [];
	public var command:String = '';
	public var commandArgs:Array<String> = [];
	public var defines:Map<String, String> = [];
	public var flags:Map<String, Bool> = [];
	public var options:Map<String, Array<String>> = [];
	public var runnedInDirectory:String = '';
	public var workingDirectory:String = '';

	public function new()
	{
		args = Sys.args();

		final runnedIn:Null<String> = args.pop();

		if (runnedIn != null)
			runnedInDirectory = runnedIn;

		workingDirectory = Sys.getCwd();

		processArguments();
	}

	private function processArguments():Void
	{
		var catchDefine = false;
		var catchOption:Null<String> = null;
		var words:Array<String> = [];

		for (arg in args)
		{
			final equals:Int = arg.indexOf('=');

			if (catchOption != null)
			{
				if (!options.exists(catchOption))
					options[catchOption] = [arg];
				else
					options[catchOption]?.push(arg);

				catchOption = null;
			}
			else if (arg == '-D')
				catchDefine = true;
			else if (equals > 0)
			{
				final expression:EReg = ~/^['"](.*)['"]$/;

				var argValue:String = arg.substr(equals + 1);

				if (expression.match(arg))
					argValue = expression.matched(1);

				if (catchDefine)
				{
					defines.set(arg, argValue);
					catchDefine = false;
				}
				else if (arg.startsWith('-D'))
					defines.set(arg.substr(2, equals - 2), argValue);
				else if (arg.startsWith('--'))
				{
					final field:String = arg.substr(2, equals - 2);

					if (!options.exists(field))
						options[field] = [argValue];
					else
						options[field]?.push(argValue);
				}
				else if (arg.startsWith('-'))
					flags.set(arg, true);
				else
					words.push(arg);
			}
			else if (catchDefine)
			{
				defines.set(arg, '');
				catchDefine = false;
			}
			else if (arg.startsWith('-D'))
				defines.set(arg.substr(2), '');
			else if (arg.startsWith('-'))
			{
				if (['--remap', '--connect', '-dce'].contains(arg))
					catchOption = arg;
				else
					flags.set(arg, true);
			}
			else
				words.push(arg);
		}

		final wordCommand:Null<String> = words.shift();

		if (wordCommand != null)
			command = wordCommand;

		commandArgs = words;
	}
}

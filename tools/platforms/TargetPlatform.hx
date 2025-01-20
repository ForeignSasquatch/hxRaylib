package platforms;

import hxp.HXML;
import hxp.Log;
import utils.Architecture;
import utils.Config;

@:nullSafety
class TargetPlatform
{
	@:noCompletion
	private final config:Config;

	@:noCompletion
	private final hxml:HXML;

	public function new(config:Config, hxml:HXML):Void
	{
		this.config = config;
		this.hxml = hxml;
	}

	public function setup():Void {}

	public function build(architectures:Array<Architecture>):Void
	{
		architectures = architectures.filter(function(arch:Architecture):Bool
		{
			return supportedArchitectures().contains(arch);
		});

		if (architectures.length == 0)
		{
			Log.error('No architectures to build after applying exclusions.');

			return;
		}
	}

	public function supportedArchitectures():Array<Architecture>
	{
		return [];
	}
}

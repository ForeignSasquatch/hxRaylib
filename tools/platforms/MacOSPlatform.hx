package platforms;

import haxe.io.Path;
import haxe.xml.Printer;
import hxp.Haxelib;
import hxp.HXML;
import hxp.Log;
import hxp.System;
import platforms.TargetPlatform;
import sys.FileSystem;
import utils.android.Feature;
import utils.android.Permission;
import utils.ANSI;
import utils.Architecture;
import utils.Config;

@:nullSafety
class MacOSPlatform extends TargetPlatform
{
	@:noCompletion
	private final outputDirectory:String;

	@:noCompletion
	private final cppDirectory:String;

	public function new(config:Config, hxml:HXML):Void
	{
		super(config, hxml);

		outputDirectory = Path.join([hxml.cpp, 'output']);
		cppDirectory = Path.join([hxml.cpp, 'cpp']);
	}

	public override function setup():Void
	{
		System.makeDirectory(outputDirectory);
		System.makeDirectory(cppDirectory);

		if (config.resourcesPath != null)
		{
			if (FileSystem.exists(config.resourcesPath))
			{
				final resources:Array<String> = System.readDirectory(config.resourcesPath);

				if (resources != null && resources.length > 0)
				{
					for (resource in resources)
						System.copyIfNewer(resource, Path.join([outputDirectory, resource]));
				}
			}
		}
	}

	public override function build(architectures:Array<Architecture>):Void
	{
		super.build(architectures);

		final compiledArchitectures:Array<String> = [];

		for (architecture in architectures)
		{
			var archDirectory:String;
			var archDefine:String;
			var archSuffix:String;

			final archHXML:HXML = hxml.clone();

			switch (architecture)
			{
				case ARM64:
					archDirectory = 'arm64';
					archDefine = 'HXCPP_ARM64';
				case X86_64:
					archDirectory = 'x86_64';
					archDefine = 'HXCPP_M64';
				default:
					Log.warn(ANSI.apply('Unable to use this architecture: $architecture', [ANSICode.Yellow]));
					continue;
			}

			archHXML.cpp = Path.join([cppDirectory, archDirectory]);
			archHXML.define(archDefine);
			archHXML.build();

			if (!hxml.noOutput)
				compiledArchitectures.push(Path.normalize(FileSystem.absolutePath(Path.join([archHXML.cpp, archHXML.debug ? archHXML.main + '-debug' : archHXML.main]))));
		}

		if (!hxml.noOutput)
		{
			if (compiledArchitectures.length > 1)
				System.runCommand(outputDirectory, 'lipo', ['-create', '-output', hxml.main].concat(compiledArchitectures));
			else if (compiledArchitectures.length > 0)
				System.copyIfNewer(compiledArchitectures[0], Path.join([outputDirectory, hxml.main]));

			System.runCommand(outputDirectory, 'chmod', ['755', './']);
		}
	}

	public override function supportedArchitectures():Array<Architecture>
	{
		return [ARM64, X86_64];
	}
}

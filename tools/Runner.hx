package;

import haxe.io.Path;
import haxe.Json;
import hxp.HXML;
import hxp.Log;
import hxp.System;
import platforms.AndroidPlatform;
import platforms.TargetPlatform;
import sys.io.File;
import sys.FileSystem;
import utils.ANSI;
import utils.Architecture;
import utils.Config;

@:nullSafety
class Runner
{
	private static var NDK_DIR:Null<String> = null;

	public static function main():Void
	{
		final args:Array<String> = Sys.args();
		final runDir:Null<String> = args.pop();
		final command:Null<String> = args.shift();
		final target:Null<String> = args.shift();

		var platform:Null<TargetPlatform> = null;

		if (runDir != null && command != null && target != null)
		{
			Sys.setCwd(runDir);

			switch (command)
			{
				case 'build':
					if (!FileSystem.exists('build.hxml'))
						Log.error(ANSI.apply('Unable to find "build.hxml" necessary for building process.', [ANSICode.Red]));

					switch (target)
					{
						case 'android':
							setupNDK();

							final buildFile:HXML = HXML.fromFile('build.hxml');

							buildFile.define('ANDROID_NDK_DIR', NDK_DIR);

							platform = new AndroidPlatform(Json.parse(File.getContent('config.json')), buildFile);

							platform.setup();

							final architectures:Array<Architecture> = [];

							for (arg in args)
							{
								switch (arg)
								{
									case '-arm64', '-armv7', '-x86', '-x86_64':
										final arch:Null<Architecture> = Architecture.fromFlag(arg);

										if (arch != null)
											architectures.push(arch);
									default:
										Log.warn('Unknown argument: ' + arg);
								}
							}

							platform.build(architectures);
					}
				default:
					Log.error(ANSI.apply('Unknown command ', [ANSICode.Red]) + ANSI.apply(command, [ANSICode.Italic, ANSICode.Red])
						+ ANSI.apply('...', [ANSICode.Red]));
			}
		}
	}

	private static function setupNDK():Void
	{
		NDK_DIR = Sys.getEnv('ANDROID_NDK_ROOT');

		if (NDK_DIR == null)
		{
			Log.info(ANSI.apply('ANDROID_NDK_ROOT is not set, searching for NDK...', [ANSICode.Yellow]));

			switch (System.hostPlatform)
			{
				case WINDOWS:
					Log.error(ANSI.apply('Please set ANDROID_NDK_ROOT manually.', [ANSICode.Red]));
				case MAC:
					NDK_DIR = Path.join([Sys.getEnv('HOME'), '/Library/Android/sdk/ndk']);
				case LINUX:
					if (FileSystem.exists(Path.join([Sys.getEnv('HOME'), '/Android/Sdk/ndk'])))
						NDK_DIR = Path.join([Sys.getEnv('HOME'), '/Android/Sdk/ndk']);
					else if (FileSystem.exists('/usr/local/android-ndk'))
						NDK_DIR = '/usr/local/android-ndk';
					else
						Log.error(ANSI.apply('Could not find the Android NDK automatically. Please set ANDROID_NDK_ROOT.', [ANSICode.Red]));
				default:
					Log.error(ANSI.apply('Unsupported OS. Please set ANDROID_NDK_ROOT manually.', [ANSICode.Red]));
			}
		}

		if (NDK_DIR != null)
			Log.info(ANSI.apply('Using Android NDK at $NDK_DIR', [ANSICode.Green]));
	}
}

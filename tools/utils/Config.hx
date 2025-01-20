package utils;

import sys.io.File;
import haxe.Json;

@:nullSafety
class Config
{
	public var resourcesPath:Null<String>;
	public var label:Null<String>;
	public var company:Null<String>;
	public var product:Null<String>;
	public var versionCode:Null<Int>;
	public var versionName:Null<String>;
	public var fullscreen:Bool = true;
	public var orientation:Null<String>;

	public function new(content:String):Void
	{
		final parsedData:Null<Dynamic> = Json.parse(content);

		if (parsedData != null)
		{
			resourcesPath = parsedData.resourcesPath;
			label = parsedData.label;
			company = parsedData.company;
			product = parsedData.product;
			versionCode = parsedData.versionCode;
			versionName = parsedData.versionName;
			fullscreen = parsedData.fullscreen;
			orientation = parsedData.orientation;
		}
	}

	public static inline function fromFile(filePath:String):Config
	{
		return new Config(File.getContent(filePath));
	}
}

package styles;

@:buildXml('<include name="${haxelib:raygui-impl.h}/project/Build.xml" />')
@:include('jungle/style_jungle.h')
@:unreflective
extern class Jungle
{
	@:native('JUNGLE_STYLE_PROPS_COUNT')
	static var STYLE_PROPS_COUNT:Int;

	@:native('JUNGLE_STYLE_FONT_ATLAS_COMP_SIZE')
	static var STYLE_FONT_ATLAS_COMP_SIZE:Int;

	@:native('GuiLoadStyleJungle')
	static function guiLoadStyle():Void;
}
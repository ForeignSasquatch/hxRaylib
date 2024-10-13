package styles;

@:buildXml('<include name="${haxelib:raygui-impl.h}/project/Build.xml" />')
@:include('cherry/style_cherry.h')
@:unreflective
extern class Cherry
{
	@:native('CHERRY_STYLE_PROPS_COUNT')
	static var STYLE_PROPS_COUNT:Int;

	@:native('CHERRY_STYLE_FONT_ATLAS_COMP_SIZE')
	static var STYLE_FONT_ATLAS_COMP_SIZE:Int;

	@:native('GuiLoadStyleCherry')
	static function guiLoadStyle():Void;
}

/**
 *   raylib-hx - a Haxe binding for the library raylib, a simple and easy-to-use library to enjoy videogames programming
 *
 *   LICENSE: zlib/libpng
 *
 *   raylib-hx is licensed under an unmodified zlib/libpng license, which is an OSI-certified,
 *   BSD-like license that allows static linking with closed source software:
 *
 *   Copyright (c) 2021-2022 Ratul Krisna (@ForeignSasquatch)
 *
 *   This software is provided "as-is", without any express or implied warranty. In no event
 *   will the authors be held liable for any damages arising from the use of this software.
 *
 *   Permission is granted to anyone to use this software for any purpose, including commercial
 *   applications, and to alter it and redistribute it freely, subject to the following restrictions:
 *
 *     1. The origin of this software must not be misrepresented; you must not claim that you
 *     wrote the original software. If you use this software in a product, an acknowledgment
 *     in the product documentation would be appreciated but is not required.
 *
 *     2. Altered source versions must be plainly marked as such, and must not be misrepresented
 *     as being the original software.
 *
 *     3. This notice may not be removed or altered from any source distribution.
 */

package raylib;

#if !cpp
#error 'Raygui supports only C++ target platforms.'
#end
import raylib.Types;

@:buildXml('<include name="${haxelib:raylib-hx}/project/Build.xml" />')
@:include('raygui-impl.h')
@:unreflective
extern class Raygui
{
    @:native('RAYGUI_VERSION_MAJOR')
    static var VERSION_MAJOR:Int;

    @:native('RAYGUI_VERSION_MINOR')
    static var VERSION_MINOR:Int;

    @:native('RAYGUI_VERSION_PATCH')
    static var VERSION_PATCH:Int;

    @:native('::String(RAYGUI_VERSION)')
    static var VERSION:String;

    @:native('SCROLLBAR_LEFT_SIDE')
    static var SCROLLBAR_LEFT_SIDE:Int;

    @:native('SCROLLBAR_RIGHT_SIDE')
    static var SCROLLBAR_RIGHT_SIDE:Int;

    @:native('GuiEnable')
    static function GuiEnable():Void;

    @:native('GuiDisable')
    static function GuiDisable():Void;

    @:native('GuiLock')
    static function GuiLock():Void;

    @:native('GuiUnlock')
    static function GuiUnlock():Void;

    @:native('GuiIsLocked')
    static function GuiIsLocked():Bool;

    @:native('GuiSetAlpha')
    static function GuiSetAlpha(alpha:Single):Void;

    @:native('GuiSetState')
    static function GuiSetState(state:Int):Void;

    @:native('GuiGetState')
    static function GuiGetState():Int;

    @:native('GuiSetFont')
    static function GuiSetFont(font:FontImpl):Void;

    @:native('GuiGetFont')
    static function GuiGetFont():FontImpl;

    @:native('GuiSetStyle')
    static function GuiSetStyle(control:Int, property:Int, value:Int):Void;

    @:native('GuiGetStyle')
    static function GuiGetStyle(control:Int, property:Int):Int;

    @:native('GuiLoadStyle')
    static function GuiLoadStyle(fileName:cpp.ConstCharStar):Void;

    @:native('GuiLoadStyleDefault')
    static function GuiLoadStyleDefault():Void;

    @:native('GuiEnableTooltip')
    static function GuiEnableTooltip():Void;

    @:native('GuiDisableTooltip')
    static function GuiDisableTooltip():Void;

    @:native('GuiSetTooltip')
    static function GuiSetTooltip(tooltip:cpp.ConstCharStar):Void;

    @:native('GuiIconText')
    static function GuiIconText(iconId:Int, text:cpp.ConstCharStar):cpp.ConstCharStar;

    #if !RAYGUI_NO_ICONS
    @:native('GuiSetIconScale')
    static function GuiSetIconScale(scale:Int):Void;

    @:native('GuiGetIcons')
    static function GuiGetIcons():raylib.utils.UnsignedPointer;

    @:native('GuiLoadIcons')
    static function GuiLoadIcons(fileName:cpp.ConstCharStar, loadIconsName:Bool):cpp.RawPointer<cpp.CastCharStar>;

    @:native('GuiDrawIcon')
    static function GuiDrawIcon(iconId:Int, posX:Int, posY:Int, pixelSize:Int, color:ColorImpl):Void;
    #end

    @:native('GuiWindowBox')
    static function GuiWindowBox(bounds:RectangleImpl, title:cpp.ConstCharStar):Int;

    @:native('GuiGroupBox')
    static function GuiGroupBox(bounds:RectangleImpl, text:cpp.ConstCharStar):Int;

    @:native('GuiLine')
    static function GuiLine(bounds:RectangleImpl, text:cpp.ConstCharStar):Int;

    @:native('GuiPanel')
    static function GuiPanel(bounds:RectangleImpl, text:cpp.ConstCharStar):Int;

    @:native('GuiTabBar')
    static function GuiTabBar(bounds:RectangleImpl, text:raylib.utils.ConstCharStarPointer, count:Int, active:raylib.utils.IntPointer):Int;

    @:native('GuiScrollPanel')
    static function GuiScrollPanel(bounds:RectangleImpl, text:cpp.ConstCharStar, content:RectangleImpl,
        scroll:cpp.RawPointer<Vector2Impl>, view:cpp.RawPointer<RectangleImpl>):Int;

    @:native('GuiLabel')
    static function GuiLabel(bounds:RectangleImpl, text:cpp.ConstCharStar):Int;

    @:native('GuiButton')
    static function GuiButton(bounds:RectangleImpl, text:cpp.ConstCharStar):Int;

    @:native('GuiLabelButton')
    static function GuiLabelButton(bounds:RectangleImpl, text:cpp.ConstCharStar):Int;

    @:native('GuiToggle')
    static function GuiToggle(bounds:RectangleImpl, text:cpp.ConstCharStar, active:raylib.utils.BoolPointer):Int;

    @:native('GuiToggleGroup')
    static function GuiToggleGroup(bounds:RectangleImpl, text:cpp.ConstCharStar, active:raylib.utils.IntPointer):Int;

    @:native('GuiToggleSlider')
    static function GuiToggleSlider(bounds:RectangleImpl, text:cpp.ConstCharStar, active:raylib.utils.IntPointer):Int;

    @:native('GuiCheckBox')
    static function GuiCheckBox(bounds:RectangleImpl, text:cpp.ConstCharStar, checked:raylib.utils.BoolPointer):Int;

    @:native('GuiComboBox')
    static function GuiComboBox(bounds:RectangleImpl, text:cpp.ConstCharStar, active:raylib.utils.IntPointer):Int;

    @:native('GuiDropdownBox')
    static function GuiDropdownBox(bounds:RectangleImpl, text:cpp.ConstCharStar, active:raylib.utils.IntPointer, editMode:Bool):Int;

    @:native('GuiSpinner')
    static function GuiSpinner(bounds:RectangleImpl, text:cpp.ConstCharStar, value:raylib.utils.IntPointer, minValue:Int, maxValue:Int,
        editMode:Bool):Int;

    @:native('GuiValueBox')
    static function GuiValueBox(bounds:RectangleImpl, text:cpp.ConstCharStar, value:raylib.utils.IntPointer, minValue:Int, maxValue:Int,
        editMode:Bool):Int;

    @:native('GuiValueBoxFloat')
    static function GuiValueBoxFloat(bounds:RectangleImpl, text:cpp.ConstCharStar, textValue:cpp.CastCharStar, value:raylib.utils.FloatPointer,
        editMode:Bool):Int;

    @:native('GuiTextBox')
    static function GuiTextBox(bounds:RectangleImpl, text:cpp.CastCharStar, textSize:Int, editMode:Bool):Int;

    @:native('GuiSlider')
    static function GuiSlider(bounds:RectangleImpl, textLeft:cpp.ConstCharStar, textRight:cpp.ConstCharStar, value:raylib.utils.FloatPointer,
        minValue:Single, maxValue:Single):Int;

    @:native('GuiSliderBar')
    static function GuiSliderBar(bounds:RectangleImpl, textLeft:cpp.ConstCharStar, textRight:cpp.ConstCharStar,
        value:raylib.utils.FloatPointer, minValue:Single, maxValue:Single):Int;

    @:native('GuiProgressBar')
    static function GuiProgressBar(bounds:RectangleImpl, textLeft:cpp.ConstCharStar, textRight:cpp.ConstCharStar,
        value:raylib.utils.FloatPointer, minValue:Single, maxValue:Single):Int;

    @:native('GuiStatusBar')
    static function GuiStatusBar(bounds:RectangleImpl, text:cpp.ConstCharStar):Int;

    @:native('GuiDummyRec')
    static function GuiDummyRec(bounds:RectangleImpl, text:cpp.ConstCharStar):Int;

    @:native('GuiGrid')
    static function GuiGrid(bounds:RectangleImpl, text:cpp.ConstCharStar, spacing:Single, subdivs:Int,
        mouseCell:cpp.RawPointer<Vector2Impl>):Int;

    @:native('GuiListView')
    static function GuiListView(bounds:RectangleImpl, text:cpp.ConstCharStar, scrollIndex:raylib.utils.IntPointer, active:raylib.utils.IntPointer):Int;

    @:native('GuiListViewEx')
    static function GuiListViewEx(bounds:RectangleImpl, text:raylib.utils.ConstCharStarPointer, count:Int,
        scrollIndex:raylib.utils.IntPointer, active:raylib.utils.IntPointer, focus:raylib.utils.IntPointer):Int;

    @:native('GuiMessageBox')
    static function GuiMessageBox(bounds:RectangleImpl, title:cpp.ConstCharStar, message:cpp.ConstCharStar,
        buttons:cpp.ConstCharStar):Int;

    @:native('GuiTextInputBox')
    static function GuiTextInputBox(bounds:RectangleImpl, title:cpp.ConstCharStar, message:cpp.ConstCharStar,
        buttons:cpp.ConstCharStar, text:cpp.CastCharStar, textMaxSize:Int, secretViewActive:raylib.utils.BoolPointer):Int;

    @:native('GuiColorPicker')
    static function GuiColorPicker(bounds:RectangleImpl, text:cpp.ConstCharStar, color:cpp.RawPointer<ColorImpl>):Int;

    @:native('GuiColorPanel')
    static function GuiColorPanel(bounds:RectangleImpl, text:cpp.ConstCharStar, color:cpp.RawPointer<ColorImpl>):Int;

    @:native('GuiColorBarAlpha')
    static function GuiColorBarAlpha(bounds:RectangleImpl, text:cpp.ConstCharStar, alpha:raylib.utils.FloatPointer):Int;

    @:native('GuiColorBarHue')
    static function GuiColorBarHue(bounds:RectangleImpl, text:cpp.ConstCharStar, value:raylib.utils.FloatPointer):Int;

    @:native('GuiColorPickerHSV')
    static function GuiColorPickerHSV(bounds:RectangleImpl, text:cpp.ConstCharStar, colorHsv:cpp.RawPointer<Vector3Impl>):Int;

    @:native('GuiColorPanelHSV')
    static function GuiColorPanelHSV(bounds:RectangleImpl, text:cpp.ConstCharStar, colorHsv:cpp.RawPointer<Vector3Impl>):Int;
}

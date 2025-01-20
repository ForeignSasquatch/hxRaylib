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
import utils.Architecture;
import utils.Config;

@:nullSafety
class AndroidPlatform extends TargetPlatform
{
	@:noCompletion
	private static final DEFAULT_FEATURES:Array<Feature> = [{name: 'android.hardware.sensor.accelerometer', required: true}];

	@:noCompletion
	private static final DEFAULT_PERMISSIONS:Array<Permission> = [
		{name: 'android.permission.INTERNET', required: true},
		{name: 'android.permission.VIBRATE', required: true}
	];

	@:noCompletion
	private final assetsDirectory:String;

	@:noCompletion
	private final cppDirectory:String;

	@:noCompletion
	private final javaDirectory:String;

	@:noCompletion
	private final jniLibsDirectory:String;

	@:noCompletion
	private final resDirectory:String;

	@:noCompletion
	private final templateDirectory:String;

	public function new(config:Config, hxml:HXML):Void
	{
		super(config, hxml);

		if (!hxml.hasDefine('android'))
			hxml.define('android');

		assetsDirectory = Path.join([hxml.cpp, 'app/src/main/assets']);
		cppDirectory = Path.join([hxml.cpp, 'app/src/main/cpp']);
		javaDirectory = Path.join([hxml.cpp, 'app/src/main/java']);
		jniLibsDirectory = Path.join([hxml.cpp, 'app/src/main/jniLibs']);
		resDirectory = Path.join([hxml.cpp, 'app/src/main/res']);
		templateDirectory = Path.join([Haxelib.getPath(new Haxelib('raylib-hx')), 'templates']);
	}

	public override function setup():Void
	{
		System.makeDirectory(assetsDirectory);
		System.makeDirectory(cppDirectory);
		System.makeDirectory(javaDirectory);
		System.makeDirectory(jniLibsDirectory);
		System.makeDirectory(resDirectory);

		if (config.resourcesPath != null)
		{
			if (FileSystem.exists(config.resourcesPath))
			{
				final resources:Array<String> = System.readDirectory(config.resourcesPath);

				if (resources != null && resources.length > 0)
				{
					for (resource in resources)
						System.copyIfNewer(resource, Path.join([assetsDirectory, resource]));
				}
			}
		}

		System.copyIfNewer(Path.join([Haxelib.getPath(new Haxelib('raylib-hx')), 'project/lib/raylib/logo/raylib_36x36.png']), Path.join([resDirectory, 'drawable-ldpi/icon.png']));
		System.copyIfNewer(Path.join([Haxelib.getPath(new Haxelib('raylib-hx')), 'project/lib/raylib/logo/raylib_48x48.png']), Path.join([resDirectory, 'drawable-mdpi/icon.png']));
		System.copyIfNewer(Path.join([Haxelib.getPath(new Haxelib('raylib-hx')), 'project/lib/raylib/logo/raylib_72x72.png']), Path.join([resDirectory, 'drawable-hdpi/icon.png']));

		final context:Dynamic = {};
		context.APP_PACKAGE = ['com', config.company ?? 'raylib', config.product ?? 'rgame'].join('.');
		context.APP_VERSION_NAME = config.versionName ?? '1.0';
		context.APP_VERSION_CODE = config.versionCode ?? 1;
		context.APP_COMPILE_SDK_VERSION = 34;
		context.APP_TARGET_SDK_VERSION = 34;
		context.APP_MIN_SDK_VERSION = 21;
		context.APP_USE_NON_TRANSITIVE_R_CLASS = true;
		context.APP_USE_ANDROIDX = false;
		context.APP_ENABLE_JETIFIER = false;
		context.APP_SHAREDLIBS = [];
		context.APP_SHOW_DEPRECATION_WARNINGS = false;
		context.GRADLE_VERSION = '8.10.2';
		context.GRADLE_PLUGIN_VERSION = '8.7.0';

		final packageDirectory:String = Path.join([javaDirectory, context.APP_PACKAGE.split('.').join('/')]);

		System.makeDirectory(packageDirectory);

		final nativeLoaderActivity:Array<String> = [];
		nativeLoaderActivity.push('package ${context.APP_PACKAGE};\n');
		nativeLoaderActivity.push('import org.raylib.ImmersiveActivity;\n');
		nativeLoaderActivity.push('public class NativeLoader extends ImmersiveActivity');
		nativeLoaderActivity.push('{');

		if (context.APP_SHAREDLIBS.length > 0)
		{
			nativeLoaderActivity.push('    static');
			nativeLoaderActivity.push('    {');

			final sharedLibs:Array<String> = context.APP_SHAREDLIBS;

			for (lib in sharedLibs)
				nativeLoaderActivity.push('        System.loadLibrary($lib);');

			nativeLoaderActivity.push('    }');
		}

		nativeLoaderActivity.push('}');
		System.writeText(nativeLoaderActivity.join('\n'), Path.join([packageDirectory, 'NativeLoader.java']));

		final manifest:Xml = Xml.createElement('manifest');
		manifest.set('xmlns:android', 'http://schemas.android.com/apk/res/android');

		final glEsVersion:Xml = Xml.createElement('uses-feature');
		glEsVersion.set('android:glEsVersion', hxml.hasDefine('GRAPHICS_API_OPENGL_ES3') ? '0x00030000' : '0x00020000');
		glEsVersion.set('android:required', 'true');
		manifest.addChild(glEsVersion);

		for (feature in DEFAULT_FEATURES)
		{
			final usesFeature:Xml = Xml.createElement('uses-feature');
			usesFeature.set('android:name', feature.name);
			usesFeature.set('android:required', Std.string(feature.required));
			manifest.addChild(usesFeature);
		}

		for (permission in DEFAULT_PERMISSIONS)
		{
			final usesPermission:Xml = Xml.createElement('uses-permission');
			usesPermission.set('android:name', permission.name);
			usesPermission.set('android:required', Std.string(permission.required));
			manifest.addChild(usesPermission);
		}

		final application:Xml = Xml.createElement('application');
		application.set('android:label', config.label ?? 'rGame');
		application.set('android:icon', '@drawable/icon');
		application.set('android:theme', config.fullscreen ? '@android:style/Theme.NoTitleBar.Fullscreen' : '@android:style/Theme.NoTitleBar');
		application.set('android:allowBackup', 'true');
		application.set('android:hardwareAccelerated', 'true');
		application.set('android:appCategory', 'game');

		if (context.APP_TARGET_SDK_VERSION >= 30)
			application.set('android:allowNativeHeapPointerTagging', 'false');

		manifest.addChild(application);

		final activity:Xml = Xml.createElement('activity');
		activity.set('android:name', 'NativeLoader');
		activity.set('android:configChanges', 'keyboard|keyboardHidden|orientation|screenSize|screenLayout|uiMode|locale|layoutDirection|navigation');
		activity.set('android:screenOrientation', config.orientation ?? 'landscape');
		activity.set('android:launchMode', 'singleTask');
		activity.set('android:resizeableActivity', 'false');
		activity.set('android:clearTaskOnLaunch', 'true');
		activity.set('android:exported', 'true');
		application.addChild(activity);

		final intentFilter:Xml = Xml.createElement('intent-filter');
		activity.addChild(intentFilter);

		final action:Xml = Xml.createElement('action');
		action.set('android:name', 'android.intent.action.MAIN');
		intentFilter.addChild(action);

		final category:Xml = Xml.createElement('category');
		category.set('android:name', 'android.intent.category.LAUNCHER');
		intentFilter.addChild(category);

		final metaData:Xml = Xml.createElement('meta-data');
		metaData.set('android:name', 'android.app.lib_name');
		metaData.set('android:value', hxml.main);
		activity.addChild(metaData);

		System.writeText(Printer.print(manifest, true), Path.join([hxml.cpp, 'app/src/main/AndroidManifest.xml']));

		final gradleProjectFiles:Array<String> = System.findTemplateRecursive([templateDirectory], 'android');

		if (gradleProjectFiles != null && gradleProjectFiles.length > 0)
		{
			for (fileLocation in gradleProjectFiles)
			{
				System.copyFile(fileLocation, Path.join([
					hxml.cpp,
					StringTools.replace(fileLocation, Path.join([templateDirectory, 'android']), '')
				]), context);
			}
		}
	}

	public override function build(architectures:Array<Architecture>):Void
	{
		super.build(architectures);

		for (architecture in architectures)
		{
			var archDirectory:String;
			var archDefine:String;
			var archSuffix:String;

			final archHXML:HXML = hxml.clone();

			switch (architecture)
			{
				case ARM64:
					archDirectory = 'arm64-v8a';
					archSuffix = archHXML.debug ? '-64-debug' : '-64';
					archDefine = 'HXCPP_ARM64';
				case ARMV7:
					archDirectory = 'armeabi-v7a';
					archSuffix = archHXML.debug ? '-v7-debug' : '-v7';
					archDefine = 'HXCPP_ARMV7';
				case X86:
					archDirectory = 'x86';
					archSuffix = archHXML.debug ? '-x86-debug' : '-x86';
					archDefine = 'HXCPP_X86';
				case X86_64:
					archDirectory = 'x86_64';
					archSuffix = archHXML.debug ? '-x86_64-debug' : '-x86_64';
					archDefine = 'HXCPP_X86_64';
			}

			archHXML.cpp = Path.join([cppDirectory, archDirectory]);
			archHXML.define(archDefine);
			archHXML.build();

			if (!archHXML.noOutput)
			{
				System.copyIfNewer(Path.join([archHXML.cpp, 'lib' + archHXML.main + archSuffix + '.so']),
					Path.join([jniLibsDirectory, archDirectory, 'lib' + archHXML.main + '.so']));
			}
		}

		if (!hxml.noOutput)
		{
			if (System.hostPlatform != WINDOWS)
				System.runCommand(hxml.cpp, 'chmod', ['+x', './gradlew']);

			System.runCommand(hxml.cpp, System.hostPlatform != WINDOWS ? './gradlew' : 'gradlew', ['assembleDebug', '--console=plain', '--warning-mode=all']);
		}
	}

	public override function supportedArchitectures():Array<Architecture>
	{
		return [ARM64, ARMV7, X86, X86_64];
	}
}

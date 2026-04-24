package extension.androidtools;

#if (!android && !native)
#error 'extension-androidtools is not supported on your current platform'
#end
import extension.androidtools.jni.JNICache;

using StringTools;

/**
 * Utility class for handling Android permissions via JNI.
 */
class Permissions
{
	public static inline var READ_EXTERNAL_STORAGE = "android.permission.READ_EXTERNAL_STORAGE";
	public static inline var WRITE_EXTERNAL_STORAGE = "android.permission.WRITE_EXTERNAL_STORAGE";
	public static inline var CAMERA = "android.permission.CAMERA";
	public static inline var MANAGE_EXTERNAL_STORAGE = "android.permission.MANAGE_EXTERNAL_STORAGE";

	public static inline function getGrantedPermissions():Array<String>
	{
		final getGrantedPermissionsJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/Tools', 'getGrantedPermissions', '()[Ljava/lang/String;');

		return getGrantedPermissionsJNI != null ? getGrantedPermissionsJNI() : [];
	}

	public static inline function requestPermissions(permissions:Array<String>, requestCode:Int = 1):Void
	{
		final requestPermissionsJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/Tools', 'requestPermissions', '([Ljava/lang/String;I)V');

		if (requestPermissionsJNI != null)
		{
			final nativePermissions:Array<String> = [];

			for (i in 0...permissions.length)
			{
				if (!permissions[i].startsWith('android.permission.'))
					nativePermissions[i] = 'android.permission.${permissions[i]}';
				else
					nativePermissions[i] = permissions[i];
			}

			requestPermissionsJNI(nativePermissions, requestCode);
		}
	}

	public static inline function hasManageAllFiles():Bool
	{
		final hasManageAllFilesJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/Tools', 'hasManageAllFiles', '()Z');
		return hasManageAllFilesJNI != null ? hasManageAllFilesJNI() : false;
	}
	
	public static inline function requestManageAllFiles():Void
	{
		final requestManageAllFilesJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/Tools', 'requestManageAllFiles', '()V');
		if (requestManageAllFilesJNI != null) {
			requestManageAllFilesJNI();
		}
	}
}

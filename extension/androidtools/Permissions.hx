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

	// Lazy-loaded JNI methods - don't initialize until first use
	private static var _getGrantedPermissionsJNI:Null<Dynamic>;
	private static var _requestPermissionsJNI:Null<Dynamic>;
	private static var _hasManageAllFilesJNI:Null<Dynamic>;
	private static var _requestManageAllFilesJNI:Null<Dynamic>;

	public static function getGrantedPermissions():Array<String>
	{
		try {
			if (_getGrantedPermissionsJNI == null)
				_getGrantedPermissionsJNI = JNICache.createStaticMethod('org/haxe/extension/Tools', 'getGrantedPermissions', '()[Ljava/lang/String;');
			
			return _getGrantedPermissionsJNI != null ? _getGrantedPermissionsJNI() : [];
		} catch (e:Dynamic) {
			trace("Error in getGrantedPermissions: " + e);
			return [];
		}
	}

	public static function requestPermissions(permissions:Array<String>, requestCode:Int = 1):Void
	{
		try {
			if (_requestPermissionsJNI == null)
				_requestPermissionsJNI = JNICache.createStaticMethod('org/haxe/extension/Tools', 'requestPermissions', '([Ljava/lang/String;I)V');

			if (_requestPermissionsJNI != null)
			{
				final nativePermissions:Array<String> = [];

				for (i in 0...permissions.length)
				{
					if (!permissions[i].startsWith('android.permission.'))
						nativePermissions[i] = 'android.permission.${permissions[i]}';
					else
						nativePermissions[i] = permissions[i];
				}

				_requestPermissionsJNI(nativePermissions, requestCode);
			}
		} catch (e:Dynamic) {
			trace("Error in requestPermissions: " + e);
		}
	}

	public static function hasManageAllFiles():Bool
	{
		try {
			if (_hasManageAllFilesJNI == null)
				_hasManageAllFilesJNI = JNICache.createStaticMethod('org/haxe/extension/Tools', 'hasManageAllFiles', '()Z');
			
			return _hasManageAllFilesJNI != null ? _hasManageAllFilesJNI() : false;
		} catch (e:Dynamic) {
			trace("Error in hasManageAllFiles: " + e);
			return false;
		}
	}
	
	public static function requestManageAllFiles():Void
	{
		try {
			if (_requestManageAllFilesJNI == null)
				_requestManageAllFilesJNI = JNICache.createStaticMethod('org/haxe/extension/Tools', 'requestManageAllFiles', '()V');
			
			if (_requestManageAllFilesJNI != null)
				_requestManageAllFilesJNI();
		} catch (e:Dynamic) {
			trace("Error in requestManageAllFiles: " + e);
		}
	}
}

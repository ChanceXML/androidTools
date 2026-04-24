package extension.androidtools;

#if (!android && !native)
#error 'extension-androidtools is not supported on your current platform'
#end
import extension.androidtools.jni.JNICache;

using StringTools;

class Permissions
{
	public static inline function getGrantedPermissions():Array<String>
	{
		final getGrantedPermissionsJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/Tools', 'getGrantedPermissions', '()[Ljava/lang/String;');

		return getGrantedPermissionsJNI != null ? getGrantedPermissionsJNI() : [];
	}

	public static inline function hasPermission(permission:String):Bool
	{
		final hasPermissionJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/Tools', 'hasPermission', '(Ljava/lang/String;)Z');
		
		if (hasPermissionJNI != null)
		{
			var p = permission.startsWith('android.permission.') ? permission : 'android.permission.$permission';
			return hasPermissionJNI(p);
		}
		return false;
	}

	public static inline function requestPermissions(permissions:Array<String>, requestCode:Int = 1):Void
	{
		final requestPermissionsJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/Tools', 'requestPermissions', '([Ljava/lang/String;I)V');

		if (requestPermissionsJNI != null)
		{
			final nativePermissions:Array<String> = [];

			for (i in 0...permissions.length)
			{
				nativePermissions[i] = permissions[i].startsWith('android.permission.') 
					? permissions[i] 
					: 'android.permission.${permissions[i]}';
			}

			requestPermissionsJNI(nativePermissions, requestCode);
		}
	}

	public static inline function hasManageAllFilesPermission():Bool
	{
		final isExternalStorageManagerJNI:Null<Dynamic> = JNICache.createStaticMethod('android/os/Environment', 'isExternalStorageManager', '()Z');
		
		if (isExternalStorageManagerJNI != null) {
			try {
				return isExternalStorageManagerJNI();
			} catch (e:Dynamic) {
				return false;
			}
		}
		return hasPermission('WRITE_EXTERNAL_STORAGE');
	}

	public static inline function requestManageAllFilesPermission():Void
	{
		final requestManageFilesJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/Tools', 'requestManageAllFilesPermission', '()V');
		
		if (requestManageFilesJNI != null)
		{
			requestManageFilesJNI();
		}
	}

	public static inline function canDrawOverlays():Bool
	{
		final canDrawOverlaysJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/Tools', 'canDrawOverlays', '()Z');
		return canDrawOverlaysJNI != null ? canDrawOverlaysJNI() : false;
	}

	public static inline function requestOverlayPermission():Void
	{
		final requestOverlayJNI:Null<Dynamic> = JNICache.createStaticMethod('org/haxe/extension/Tools', 'requestOverlayPermission', '()V');
		
		if (requestOverlayJNI != null)
		{
			requestOverlayJNI();
		}
	}
}

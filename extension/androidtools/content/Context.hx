package extension.androidtools.content;

#if (!android && !native)
#error 'extension-androidtools is not supported on your current platform'
#end
import extension.androidtools.jni.JNICache;
import extension.androidtools.jni.JNIUtil;

/**
 * This class provides access to directories and information associated with the application context using JNI calls.
 */
class Context
{
	/**
	 * Retrieves the name of this application's package.
	 *
	 * @return The application's package name.
	 */
	public static function getPackageName():String
	{
		final getPackageNameJNI = JNICache.createStaticMethod('org.haxe.extension.Tools', 'getPackageName', '()Ljava/lang/String;');
		
		if (getPackageNameJNI != null)
		{
			final result:Dynamic = getPackageNameJNI();
			if (result != null) return cast(result, String);
		}
		
		return '';
	}

	/**
	 * Retrieves the absolute path of the directory assigned to the application for storing private files.
	 *
	 * @return The absolute path of the private files directory.
	 */
	public static function getFilesDir():String
	{
		final getFilesDirJNI = JNICache.createStaticMethod('org.haxe.extension.Tools', 'getFilesDir', '()Ljava/io/File;');
		
		if (getFilesDirJNI != null)
		{
			final result:Dynamic = getFilesDirJNI();
			if (result != null) return JNIUtil.getAbsolutePath(result);
		}
		
		return '';
	}

	/**
	 * Retrieves the absolute path of the directory assigned to the application for storing external files.
	 *
	 * @param type Optional type of subdirectory to retrieve (e.g., "Pictures", "Documents").
	 * @return The absolute path of the external files directory.
	 */
	public static function getExternalFilesDir(type:String = null):String
	{
		final getExternalFilesDirJNI = JNICache.createStaticMethod('org.haxe.extension.Tools', 'getExternalFilesDir', '(Ljava/lang/String;)Ljava/io/File;');
		
		if (getExternalFilesDirJNI != null)
		{
			final result:Dynamic = getExternalFilesDirJNI(type);
			if (result != null) return JNIUtil.getAbsolutePath(result);
		}
		
		return '';
	}

	/**
	 * Retrieves the absolute paths of directories assigned to the application for storing external files.
	 * This can include multiple directories in cases where there are multiple external storage devices.
	 *
	 * @param type Optional type of subdirectory to retrieve (e.g., "Pictures", "Documents").
	 * @return An array of absolute paths of the external files directories.
	 */
	public static function getExternalFilesDirs(type:String = null):Array<String>
	{
		final getExternalFilesDirsJNI:Null<Dynamic> = JNICache.createStaticMethod('org.haxe.extension.Tools', 'getExternalFilesDirs',
			'(Ljava/lang/String;)[Ljava/io/File;');

		final dirs:Array<String> = [];
		
		if (getExternalFilesDirsJNI != null)
		{
			final result:Dynamic = getExternalFilesDirsJNI(type);
			if (result != null)
			{
				final arr:Array<Dynamic> = cast(result, Array<Dynamic>);
				if (arr != null)
				{
					for (dir in arr)
					{
						if (dir != null) dirs.push(JNIUtil.getAbsolutePath(dir));
					}
				}
			}
		}
		
		return dirs;
	}

	/**
	 * Retrieves the absolute paths of directories assigned to the application for storing media files.
	 * This bypasses scoped storage restrictions for the app's designated media folder.
	 *
	 * @return An array of absolute paths of the external media directories.
	 */
	public static function getExternalMediaDirs():Array<String>
	{
		final getExternalMediaDirsJNI:Null<Dynamic> = JNICache.createStaticMethod('org.haxe.extension.Tools', 'getExternalMediaDirs', '()[Ljava/io/File;');

		final dirs:Array<String> = [];
		
		if (getExternalMediaDirsJNI != null)
		{
			final result:Dynamic = getExternalMediaDirsJNI();
			if (result != null)
			{
				final arr:Array<Dynamic> = cast(result, Array<Dynamic>);
				if (arr != null)
				{
					for (dir in arr)
					{
						if (dir != null) dirs.push(JNIUtil.getAbsolutePath(dir));
					}
				}
			}
		}
		
		return dirs;
	}

	/**
	 * Retrieves the absolute path of the directory assigned to the application for storing cached files.
	 *
	 * @return The absolute path of the cache directory.
	 */
	public static function getCacheDir():String
	{
		final getCacheDirJNI = JNICache.createStaticMethod('org.haxe.extension.Tools', 'getCacheDir', '()Ljava/io/File;');
		
		if (getCacheDirJNI != null)
		{
			final result:Dynamic = getCacheDirJNI();
			if (result != null) return JNIUtil.getAbsolutePath(result);
		}
		
		return '';
	}

	/**
	 * Retrieves the absolute path of the directory assigned to the application for storing cached code.
	 *
	 * @return The absolute path of the code cache directory.
	 */
	public static function getCodeCacheDir():String
	{
		final getCodeCacheDirJNI = JNICache.createStaticMethod('org.haxe.extension.Tools', 'getCodeCacheDir', '()Ljava/io/File;');
		
		if (getCodeCacheDirJNI != null)
		{
			final result:Dynamic = getCodeCacheDirJNI();
			if (result != null) return JNIUtil.getAbsolutePath(result);
		}
		
		return '';
	}

	/**
	 * Retrieves the absolute path of the directory assigned to the application for storing backup files that won't be backed up by the system.
	 *
	 * @return The absolute path of the no-backup files directory.
	 */
	public static function getNoBackupFilesDir():String
	{
		final getNoBackupFilesDirJNI = JNICache.createStaticMethod('org.haxe.extension.Tools', 'getNoBackupFilesDir', '()Ljava/io/File;');
		
		if (getNoBackupFilesDirJNI != null)
		{
			final result:Dynamic = getNoBackupFilesDirJNI();
			if (result != null) return JNIUtil.getAbsolutePath(result);
		}
		
		return '';
	}

	/**
	 * Retrieves the absolute path of the directory assigned to the application for storing cached files on external storage.
	 *
	 * @return The absolute path of the external cache directory.
	 */
	public static function getExternalCacheDir():String
	{
		final getExternalCacheDirJNI = JNICache.createStaticMethod('org.haxe.extension.Tools', 'getExternalCacheDir', '()Ljava/io/File;');
		
		if (getExternalCacheDirJNI != null)
		{
			final result:Dynamic = getExternalCacheDirJNI();
			if (result != null) return JNIUtil.getAbsolutePath(result);
		}
		
		return '';
	}

	/**
	 * Retrieves the absolute paths of directories assigned to the application for storing cached files on external storage.
	 * This can include multiple directories in cases where there are multiple external storage devices.
	 *
	 * @return An array of absolute paths of the external cache directories.
	 */
	public static function getExternalCacheDirs():Array<String>
	{
		final getExternalCacheDirsJNI:Null<Dynamic> = JNICache.createStaticMethod('org.haxe.extension.Tools', 'getExternalCacheDirs', '()[Ljava/io/File;');

		final dirs:Array<String> = [];
		
		if (getExternalCacheDirsJNI != null)
		{
			final result:Dynamic = getExternalCacheDirsJNI();
			if (result != null)
			{
				final arr:Array<Dynamic> = cast(result, Array<Dynamic>);
				if (arr != null)
				{
					for (dir in arr)
					{
						if (dir != null) dirs.push(JNIUtil.getAbsolutePath(dir));
					}
				}
			}
		}
		
		return dirs;
	}

	/**
	 * Retrieves the absolute path of the directory assigned to the application for storing expansion files (OBB files).
	 *
	 * @return The absolute path of the OBB directory.
	 */
	public static function getObbDir():String
	{
		final getObbDirJNI = JNICache.createStaticMethod('org.haxe.extension.Tools', 'getObbDir', '()Ljava/io/File;');
		
		if (getObbDirJNI != null)
		{
			final result:Dynamic = getObbDirJNI();
			if (result != null) return JNIUtil.getAbsolutePath(result);
		}
		
		return '';
	}
}

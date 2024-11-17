package util;

import sys.io.File;

class Util
{
	inline public static function getFont(font:String, ext:String = "ttf")
	{
		return 'assets/fonts/${font}/font.${ext}';
	}

	public static function writeTextToFile(text:String, filename:String):Void
	{
		try
		{
			var file = File.write(filename, true);
			file.writeString(text);
			file.close();
		}
		catch (e:Dynamic)
		{
			trace('UH OH THE DETONS TOOK OVER: $e');
		}
	}

	public static function getCommand(command:String, ?args:Array<String>):String
	{
		try
		{
			var process = new sys.io.Process(command, args);

			var output = process.stdout.readAll().toString();
			return output;
		}
		catch (e:Dynamic)
		{
			return "UH OH THE DETONS TOOK OVER: " + e;
		}
	}
}

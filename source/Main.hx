package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, ToolState, 60, 60, true));
	}
}

class Util
{
	inline public static function getFont(font:String, ext:String = "ttf")
	{
		return 'assets/fonts/${font}/font.${ext}';
	}
}

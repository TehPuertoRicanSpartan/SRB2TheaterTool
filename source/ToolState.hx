package;

import util.*;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.ui.*;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;
import openfl.events.Event;
import openfl.filesystem.File;
import sys.FileSystem;

class ToolState extends FlxState
{
	var inVideo:File;

	var path:String = "assets/";

	var bg:FlxSprite;
	var bg2:FlxSprite;

	// input variables
	var tabBox:FlxUITabMenu;
	var tab1:FlxGroup;
	var tab2:FlxText;

	// main tab
	var videoPath:FlxUIInputText;

	var outputWidthDropdown:FlxUIDropDownMenu;
	var outputWidth:Int = 120;

	var fps:FlxUINumericStepper;

	var prefix:FlxUIInputText;
	var audioName:FlxUIInputText;

	var luaID:FlxUIInputText;
	var luaName:FlxUIInputText;

	override public function create()
	{
		super.create();

		bg = new FlxSprite().loadGraphic('${path}images/theater1.png');
		bg.setGraphicSize(FlxG.height * (bg.width / bg.height), FlxG.height);
		bg.updateHitbox();
		bg.screenCenter();
		bg2 = new FlxSprite().loadGraphic('${path}images/theater2.png');
		bg2.setGraphicSize(FlxG.height * (bg2.width / bg2.height), FlxG.height);
		bg2.updateHitbox();
		bg2.screenCenter();

		add(bg);
		add(bg2);
		bg2.alpha = 0;

		var blackTint:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackTint.alpha = 0.5;
		add(blackTint);

		var toolText:FlxText = new FlxText(0, 200, 0, 'SRB2TheaterTool', 32);
		toolText.setFormat(Util.getFont("sonic-2-system"), 32, 0xFFFFFF00, LEFT, SHADOW, 0xFF272727);
		toolText.borderSize = 4;
		toolText.screenCenter(X);
		add(toolText);
		var versionText:FlxText = new FlxText(0, toolText.y + (toolText.height - 6), 0, 'v${Application.current.meta.get('version')} nightly', 16);
		versionText.setFormat(Util.getFont("sonic-2-system"), 16, 0xFFFFFF00, LEFT, SHADOW, 0xFF272727);
		versionText.borderSize = 2;
		versionText.screenCenter(X);
		add(versionText);

		var tabs = [{name: "1 - Main", label: "Main"}, {name: "2 - Credits", label: "Credits"}];

		tabBox = new FlxUITabMenu(null, tabs, true);
		tabBox.resize(400, 300);
		tabBox.screenCenter();
		tabBox.selected_tab = 0;
		add(tabBox);

		tab1 = new FlxGroup();
		add(tab1);

		// main tab
		var pathText:FlxText = new FlxText(0, tabBox.y + 25, 0, 'Video Path:', 8);
		pathText.setFormat(Util.getFont("sonic-2-system"), 8, 0xFFE4E4E4, LEFT, SHADOW, 0xFF272727);
		pathText.borderSize = 1;
		pathText.screenCenter(X);
		tab1.add(pathText);
		videoPath = new FlxUIInputText(tabBox.x + 10, tabBox.y + 40, 290, '');
		videoPath.setFormat(Util.getFont("sonic-2-system"), 8, 0xFF272727, LEFT, NONE);
		tab1.add(videoPath);
		var browseButton:FlxUIButton = new FlxUIButton((videoPath.x + videoPath.width) + 10, videoPath.y - 3, 'Browse', function()
		{
			FlxG.sound.play('${path}sounds/DSS3K5B.ogg', 1, false, null, true, function()
			{
				inVideo = new File();
				inVideo.browseForOpen("Select a video file");
				inVideo.addEventListener(Event.SELECT, onFileSelected);
				inVideo.addEventListener(Event.CANCEL, onFileCancelled);
			});
		});
		browseButton.setLabelFormat(Util.getFont("sonic-2-system"), 8, 0xFF000000, CENTER, SHADOW, 0x3F000000);
		browseButton.getLabel().borderSize = 1;
		tab1.add(browseButton);

		var outWidthText:FlxText = new FlxText(tabBox.x + 80, tabBox.y + 60, 0, 'Output Width:', 8);
		outWidthText.setFormat(Util.getFont("sonic-2-system"), 8, 0xFFE4E4E4, LEFT, SHADOW, 0xFF272727);
		outWidthText.borderSize = 1;
		tab1.add(outWidthText);
		outputWidthDropdown = new FlxUIDropDownMenu(outWidthText.x, tabBox.y + 75, FlxUIDropDownMenu.makeStrIdLabelArray(['120', '160', '180', '200']),
			function(width:String)
			{
				outputWidth = Std.parseInt(width);
			});
		outputWidthDropdown.selectedLabel = '120';

		var fpsText:FlxText = new FlxText((outputWidthDropdown.x + outputWidthDropdown.width) + 10, tabBox.y + 60, 0, 'FPS:', 8);
		fpsText.setFormat(Util.getFont("sonic-2-system"), 8, 0xFFE4E4E4, LEFT, SHADOW, 0xFF272727);
		fpsText.borderSize = 1;
		tab1.add(fpsText);
		fps = new FlxUINumericStepper(fpsText.x, tabBox.y + 75, 1, 1, 1, 35, 0);
		tab1.add(fps);

		var prefixText:FlxText = new FlxText(tabBox.x + 10, tabBox.y + 100, 0, 'Texture Prefix:', 8);
		prefixText.setFormat(Util.getFont("sonic-2-system"), 8, 0xFFE4E4E4, LEFT, SHADOW, 0xFF272727);
		prefixText.borderSize = 1;
		tab1.add(prefixText);
		var prefixSubtext:FlxText = new FlxText(tabBox.x + 10, tabBox.y + 130, 0, '(7 characters max)', 8);
		prefixSubtext.setFormat(Util.getFont("sonic-2-system"), 8, 0xFFE4E4E4, LEFT, SHADOW, 0xFF272727);
		prefixSubtext.borderSize = 1;
		tab1.add(prefixSubtext);
		prefix = new FlxUIInputText(tabBox.x + 10, tabBox.y + 115, 185, '');
		prefix.setFormat(Util.getFont("sonic-2-system"), 8, 0xFF272727, LEFT, NONE);
		tab1.add(prefix);
		var audioText:FlxText = new FlxText((prefix.x + prefix.width) + 10, tabBox.y + 100, 0, 'Audio Name:', 8);
		audioText.setFormat(Util.getFont("sonic-2-system"), 8, 0xFFE4E4E4, LEFT, SHADOW, 0xFF272727);
		audioText.borderSize = 1;
		tab1.add(audioText);
		var audioSubtext:FlxText = new FlxText((prefix.x + prefix.width) + 10, tabBox.y + 130, 0, '(6 characters max)', 8);
		audioSubtext.setFormat(Util.getFont("sonic-2-system"), 8, 0xFFE4E4E4, LEFT, SHADOW, 0xFF272727);
		audioSubtext.borderSize = 1;
		tab1.add(audioSubtext);
		audioName = new FlxUIInputText((prefix.x + prefix.width) + 10, tabBox.y + 115, 185, '');
		audioName.setFormat(Util.getFont("sonic-2-system"), 8, 0xFF272727, LEFT, NONE);
		tab1.add(audioName);

		var convertButton:FlxUIButton = new FlxUIButton(0, tabBox.y + 180, 'Convert', function()
		{
			FlxG.sound.play('${path}sounds/DSS3K5B.ogg', 1, false, null, true, function()
			{
				convertMovie(videoPath.text, Std.int(fps.value), outputWidth, prefix.text, audioName.text);
			});
		});
		convertButton.setLabelFormat(Util.getFont("sonic-2-system"), 8, 0xFF000000, CENTER, SHADOW, 0x3F000000);
		convertButton.getLabel().borderSize = 1;
		convertButton.screenCenter(X);
		tab1.add(convertButton);

		var luaIDtext:FlxText = new FlxText(tabBox.x + 10, tabBox.y + 260, 0, 'Video ID:');
		luaIDtext.setFormat(Util.getFont("sonic-2-system"), 8, 0xFFE4E4E4, LEFT, SHADOW, 0xFF272727);
		tab1.add(luaIDtext);
		luaID = new FlxUIInputText(luaIDtext.x, luaIDtext.y + 15, 185, '');
		luaID.setFormat(Util.getFont("sonic-2-system"), 8, 0xFF272727, LEFT, NONE);
		tab1.add(luaID);

		var luaNameText:FlxText = new FlxText((luaID.x + luaID.width) + 10, tabBox.y + 260, 0, 'Video Title:');
		luaNameText.setFormat(Util.getFont("sonic-2-system"), 8, 0xFFE4E4E4, LEFT, SHADOW, 0xFF272727);
		tab1.add(luaNameText);
		luaName = new FlxUIInputText(luaNameText.x, luaNameText.y + 15, 185, '');
		luaName.setFormat(Util.getFont("sonic-2-system"), 8, 0xFF272727, LEFT, NONE);
		tab1.add(luaName);

		tab1.add(outputWidthDropdown);

		// credits tab
		var credits:String = "CREDITS
		\n
		\nTehPuertoRicanSpartan - Main Programmer of the Tool
		\n(https://github.com/TehPuertoRicanSpartan)
		\n
		\nLJ Sonic - Coding the original Theater Lua
		\nApollyon - Making the original Theater map
		\n
		\nFabrice Bellard - Writing FFmpeg
		\n(without it, this tool wouldn't be possible!)";
		tab2 = new FlxText(0, 0, tabBox.width, credits, 8);
		tab2.setFormat(Util.getFont("sonic-2-system"), 8, 0xFFE4E4E4, CENTER, SHADOW, 0xFF272727);
		tab2.screenCenter();
		add(tab2);

		var engineText:FlxText = new FlxText(8, 8, 0, 'Tool made by TehPuertoRicanSpartan\nWritten in Haxe with ${Std.string(FlxG.VERSION)}', 8);
		engineText.setFormat(Util.getFont("sonic-2-system"), 8, 0xFFE4E4E4, LEFT, SHADOW, 0xFF272727);
		engineText.borderSize = 1;
		add(engineText);

		FlxG.sound.play('${path}sounds/DSKC5E.ogg');
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		tab1.active = tab1.visible = tabBox.selected_tab == 0;
		tab2.active = tab2.visible = tabBox.selected_tab == 1;

		prefix.text = prefix.text.substr(0, 7).toUpperCase();
		audioName.text = audioName.text.substr(0, 6).toUpperCase();
	}

	function convertMovie(file:String, fps:Int, outWidth:Int, prefix:String, audioFile:String)
	{
		// initialize everything else first
		if (audioFile.length > 6)
			audioFile = audioFile.substr(0, 6);

		var numberLength = 8 - prefix.length;

		Sys.command('mkdir "./movies/${luaID.text}/Music"');
		Sys.command('mkdir "./movies/${luaID.text}/Textures"');
		Sys.command('mkdir "./movies/${luaID.text}/Lua"');

		var aspect:Array<String> = ((Util.getCommand('./ffprobe.exe', [
			'-v',
			'error',
			'-select_streams',
			'v:0',
			'-show_entries',
			'stream=display_aspect_ratio',
			'-of',
			'default=noprint_wrappers=1:nokey=1',
			file
		])).split(':'));
		var height:Int = Math.round((Std.parseFloat(aspect[1]) / Std.parseFloat(aspect[0])) * outWidth);
		Sys.command('./ffmpeg.exe', [
			'-i',
			file,
			'-s:v',
			'${outWidth}x$height',
			'-r',
			'$fps',
			'-start_number',
			'0',
			'movies/${luaID.text}/Textures/$prefix%0${numberLength}d.png',
			'-vn',
			'-acodec',
			'libvorbis',
			'movies/${luaID.text}/Music/O_$audioFile.ogg'
		]);

		// initialize the lua file
		var prefixWithAsteriks:String = prefix;
		for (i in 0...numberLength)
			prefixWithAsteriks += '*';

		var duration:Int = Math.round(Std.parseFloat(Util.getCommand('./ffprobe.exe', [
			'-v',
			'error',
			'-show_entries',
			'format=duration',
			'-of',
			'default=noprint_wrappers=1:nokey=1',
			file
		])) * 35);

		var frames:Int = 0;
		var items:Array<String> = FileSystem.readDirectory('./movies/${luaID.text}/Textures');
		for (item in items)
			frames++;

		var luaFile:String = '/*\nAutomatically generated by SRB2TheaterTool v${Application.current.meta.get('version')}\nhttps://github.com/TehPuertoRicanSpartan/SRB2TheaterTool\n*/\ntheater.addMovie{\n\tid = "${luaID.text}",\n\tname = "${luaName.text}",\n\tduration = $duration,\n\twidth = $outputWidth,\n\theight = $height,\n\ttextures = "$prefixWithAsteriks",\n\tframes = ${frames - 1},\n\tmusic = "${audioName.text}"\n}';
		Util.writeTextToFile(luaFile, './movies/${luaID.text}/Lua/movie.lua');

		var pk3 = ZipUtil.createZipFile('./movies/${luaID.text}.pk3');
		ZipUtil.writeFolderToZip(pk3, './movies/${luaID.text}');
		pk3.flush();
		pk3.close();

		Sys.command('rmdir /q /s "./movies/${luaID.text}"');
	}

	private function onFileSelected(_)
	{
		inVideo.removeEventListener(Event.SELECT, onFileSelected);
		inVideo.removeEventListener(Event.CANCEL, onFileCancelled);

		videoPath.text = inVideo.nativePath;
	}

	private function onFileCancelled(_)
	{
		inVideo.removeEventListener(Event.SELECT, onFileSelected);
		inVideo.removeEventListener(Event.CANCEL, onFileCancelled);
	}
}

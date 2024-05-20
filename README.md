Have you ever want to put a video on the big screen? Virtually? Did you see anyone do it when hosting movies on SRB2's Master Server and wanted to do it too? Well, introducing...
# SRB2MovieTool
## A tool for Theater.pk3 for Sonic Robo Blast 2
SRB2MovieTool is a Windows-only tool that's intended for converting videos to [Theater.pk3](https://cdn.discordapp.com/attachments/796954415591981116/1166491613657301032/Theater.pk3), which can be only used in [Sonic Robo Blast 2.](https://srb2.org)

# Installation
1. Extract the zip file that comes with the tool. (RECOMMENDED)
2. Download the FFmpeg binaries [here.](https://www.gyan.dev/ffmpeg/builds/)
3. Find `ffmpeg.exe` and `ffprobe.exe`, then place them in the root file of the tool (where SRB2MovieTool.exe is).
# Tool Usage
## You need to fill in fields for every single inputs for:
- **Video Path** is the path of the video you want to see in SRB2. There's a **Browse** button next to it, so you can browse the video file.
- **Output Width** is the width of what you want the output to be. Due to Theater.pk3's restrictions, the only options are **120**, **160**, **180**, and **200**
- **FPS** is the "frames per second" of the output. It goes up to 35.
- **Texture Prefix** is the prefix of the output. The maximum is 7 characters, but keeping it nice and short is ***REALLY*** recommended. If I want to make a prefix for *Sonic OVA*, I would put `OVA`.
- **Audio Name** is the audio name of the output. The maximum is 6 characters, due to how SRB2's music files works.
- **Video ID** is a short, lowercase, and no-spaced name for the output. If I were to make an ID for *Sonic OVA*, once again, I would put `sonicova`. **Keep it nice and short for easier accessibility.**
- **Video Title** is the title of the video.
- Pressing the **Convert** button will use FFmpeg and FFprobe to convert the video and make a Lua file in the `movies` directory, where the output is going to be.
# Packaging the Output
1. Inside the folder where it has the video name, you will see three folders; `Lua`, `Music`, and `Textures`. **Verify each folder to make sure it's correct for SRB2 modding.** For example, `OVA00000` should be the first frame. The list goes on until the video ends.
2. Select all three folders by pressing Ctrl+A to package them. **[7-Zip](https://www.7-zip.org) should do it.**
3. Right-click the highlighted folders and select `7-Zip > Add to "your video file here.zip"`.
4. Rename the `zip` to `pk3`. **Make sure you have `File name extensions` checked.**
5. Put it in your SRB2 addons folder, and you're ready to go.
# Testing the Output
1. Make sure you have `Theater.pk3` somewhere in your SRB2 folder.
2. Boot up SRB2.
3. Load `Theater.pk3` and the output PK3.
4. Warp to where the theater is. It can be in the console, which you can open by pressing \`, or the level select.
5. Go to the screening room and execute `theaterplay yourvideoidhere` to play.
6. Grab your popcorn and drink, and enjoy.

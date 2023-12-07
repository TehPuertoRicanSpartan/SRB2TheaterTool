--template lua file / included in SRB2MovieTool (https://github.com/TehPuertoRicanSpartan/SRB2MovieTool)
theater.addMovie{
	id = "movieid", --video name (no spaces, no caps)
	name = "Movie Name", --full video name
	duration = 0, --video duration * 35 (rounded)

	width = 160, --width (check the frames)
	height = 90, --height (check the frames)
	textures = "PRFX****", --prefix (check the frames' filename) (also the asteriks/*'s represent the digits of numbers)
	frames = 0, --amount of frames

	music = "MOVAUD", --audio file (take off the "O_" part)
}
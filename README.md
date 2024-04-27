# Redstone test
A library for testring Minecraft redstone logic's correctness with the help of cc:tweaked and other mods in a creative world.

## Usage
1. Create a modpack with the bellow requirements fulfilled
2. Make a creative world with cheats enabled
3. Spawn a command computer in the game with the command `/give @a computercraft:computer_command`, and place it down. 
4. Copy the included files to it. This can be done manually by
	- running `mkdir a` on the computer (this step is important).
	- going to your world folder
	- inside the `computercraft/computer` folder, there should be a folder (probably called `0`) which contains the `a` folder. Go into it
	- clone this repository into the folder, or download [the zip folder](https://github.com/largenumberhere/refs/heads/main.zip) of it and extract it into the folder
	- verify that it worked on the command computer by using `cd` to get to the redstonetestfolder and running `./select_inputs`. Quit the program as directed by the message.
5. Place `redstone integrator`s in the world (from the plethora mod)
6. Join the redstone integrators to the computer with `Writed Modem`s and `Networking Cable`s
7. Run the included programs `select_inputs` and `select_outputs` to specify the redstone inputs and outputs in order, follow the directions they provide.
8. Create a test script, `or16test.lua` is included as an example. It is important that the `libredstonetest` folder is in the same folder as your test script.
9. Run the program. Please contact me if you experience bugs or have any other difficultly, I intend to update this readme with detail when I receive questions. 

## Requirements:
This library assumes specific set of mods. The following are all the modifications I used **and all thier dependencies**. If you are inexpereinced, I suggest using multimc to manage modded minecraft instances to keep things organized and convienient. Hopefully, if you install all these the same way, it'll work without issue. Install fabric loader first. 
- Minecraft 1.20.1
- fabric loader 0.15.10
- cc-tweaked-1.20.1-fabric-1.110.2-fabric.jar
- fabric-api-0.92.1+1.20.1-fabric.jar
- fabric-carpet-1.20-1.4.112+v230608-fabric.jar
- fabric-language-kotlin-1.10.19+kotlin.1.9.23.jar
- Plethora-Fabric-1.11.7.jar
- trinkets-3.7.2.jar
- worldedit-mod-7.2.15-fabricforge.jar


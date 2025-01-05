# Play here: [https://bonemanseth.itch.io/boxbox](https://bonemanseth.itch.io/wizards-poem)
Wizard's Poem
=====
![Wizard's Poem Logo](https://raw.githubusercontent.com/Sethbones/Wizards-Poem/master/res/ast/itch%20card%20final.png)
## Description
Made with Heaps Game Engine
Source Code for the HaxeJam 2024 Summer Jam Submission: Wizard's Poem
a game in the vein of Bookworm Adventures
in which a player is tasked to string together words to deal damage to targets.

## Screenshots
![Wizard's Poem Game](https://img.itch.zone/aW1hZ2UvMjc3NzA2My8xNjU3MTA0OS5wbmc=/original/lCaHlw.png)
## Requirements
#### Windows
* [Haxe](https://haxe.org/download/) (Use Installer)
#### Linux
 [Platform Specific Notes](https://haxe.org/download/linux/)
```
Ubuntu
sudo add-apt-repository ppa:haxe/releases -y
sudo apt-get update
sudo apt-get install haxe -y
mkdir ~/haxelib && haxelib setup ~/haxelib

Arch Linux
sudo pacman -S haxe
mkdir ~/haxelib && haxelib setup ~/haxelib

Debian
sudo apt-get install haxe -y
mkdir ~/haxelib && haxelib setup ~/haxelib

Fedora
sudo dnf install haxe -y
mkdir ~/haxelib && haxelib setup ~/haxelib

OpenSUSE
sudo zypper install haxe
mkdir ~/haxelib && haxelib setup ~/haxelib
```
### Environment Setup
Install Required Haxe Libraries
```
haxelib git heaps https://github.com/HeapsIO/heaps.git
haxelib install hlopenal
haxelib install hlsdl
haxelib install hldx
haxelib install random
```
### Setup
```
git clone https://github.com/Sethbones/Wizards-Poem
cd Wizards-Poem
haxe compile.hxml
```

## Running
open index.html in the game's directory with your favorite browser

## License
Everything in here is licensed under the BSD 3-Clause 'New' or 'Revised' License; see LICENSE file for details.

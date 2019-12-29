# Setup

#### 1. Unpack Chernarus pbo
    1. Start ArmA III Tools from Steam and start BankRev
    2. Unpack "Arma 2/AddOns/Chernarus_Data_Layers.pbo"

#### 2. Convert tiles in "ca/chernarus/data/layers" from .paa to .png
    1. In ArmA II Tools go to View -> Open ArmA II Tools directory
    2. Go into TexView2 directory and copy the full path to "Pal2PacE.exe"
    3. Edit paths in map_utils/create_tiles.sh
    4. Install [ImageMagick](https://imagemagick.org/script/download.php) (On Linux via packet manager, on Windows you need [MinGW](http://www.mingw.org/)) and add it to PATH
    5. Run it (careful a convert.exe exists in Windows PATH by default, might have to specify full path to the binary), this should give you a map.png

#### 3. Convert full map to tiles with zoom levels
    1. Install [GDAL](https://gdal.org/index.html) (On Windows you need [Anaconda](https://anaconda.org/))
    2. Head to /map_utils directory
    3. run "pyhton gdal2tiles.py -l -p raster -z 0-x -w none map.png tiles" and wait for it to finish (x is max zoom, i would recommend 7, the bigger the longer it will take)
    4. You should have your finished map in the /tiles folder
    5. Copy the entire folder to /assets

#### 4. Setup SQL Database for DayZ vehicle spawns
    1. Download DayZ Mod and get SQL scripts from /SQL/version
    2. Execute on database
    3. Enter DB credentials in /scripts/get-spawns.php

Hope this works for you too!

## References
These scripts were insprited by other creators and only modified for this purpose
- [gdal2tiles.py](https://github.com/commenthol/gdal2tiles-leaflet)
- create_tiles.sh - sorry cant find the original author again

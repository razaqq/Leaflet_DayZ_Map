#!/bin/bash
# quick and dirty
# adjust paths as needed

Pal2PacE="C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools\TexView2\Pal2PacE.exe"
ImageMagic="C:\Program Files (x86)\ImageMagic"
del="\\"  # use forward slash for linux

echo "Starting..."
cd ./ca/chernarus/data/layers || exit -1

echo "Converting PAA to PNG..."
for i in $(seq -w 0 31); do for j in $(seq -w 0 31); do $Pal2PacE m_0${i}_0${j}_lco.paa m_0${i}_0${j}_lco.png; done; done

echo "Shaving..."
"${ImageMagic}${del}mogrify" -shave 16x16 s_*.png

echo "Merge stage 1..."
"${ImageMagic}${del}convert.exe" -append s_000*.png m_01.png
"${ImageMagic}${del}convert.exe" -append s_001*.png m_02.png
"${ImageMagic}${del}convert.exe" -append s_002*.png m_03.png
"${ImageMagic}${del}convert.exe" -append s_003*.png m_04.png
"${ImageMagic}${del}convert.exe" -append s_004*.png m_05.png
"${ImageMagic}${del}convert.exe" -append s_005*.png m_06.png
"${ImageMagic}${del}convert.exe" -append s_006*.png m_07.png
"${ImageMagic}${del}convert.exe" -append s_007*.png m_08.png
"${ImageMagic}${del}convert.exe" -append s_008*.png m_09.png
"${ImageMagic}${del}convert.exe" -append s_009*.png m_10.png
"${ImageMagic}${del}convert.exe" -append s_010*.png m_11.png
"${ImageMagic}${del}convert.exe" -append s_011*.png m_12.png
"${ImageMagic}${del}convert.exe" -append s_012*.png m_13.png
"${ImageMagic}${del}convert.exe" -append s_013*.png m_14.png
"${ImageMagic}${del}convert.exe" -append s_014*.png m_15.png
"${ImageMagic}${del}convert.exe" -append s_015*.png m_16.png
"${ImageMagic}${del}convert.exe" -append s_016*.png m_17.png
"${ImageMagic}${del}convert.exe" -append s_017*.png m_18.png
"${ImageMagic}${del}convert.exe" -append s_018*.png m_19.png
"${ImageMagic}${del}convert.exe" -append s_019*.png m_20.png
"${ImageMagic}${del}convert.exe" -append s_020*.png m_21.png
"${ImageMagic}${del}convert.exe" -append s_021*.png m_22.png
"${ImageMagic}${del}convert.exe" -append s_022*.png m_23.png
"${ImageMagic}${del}convert.exe" -append s_023*.png m_24.png
"${ImageMagic}${del}convert.exe" -append s_024*.png m_25.png
"${ImageMagic}${del}convert.exe" -append s_025*.png m_26.png
"${ImageMagic}${del}convert.exe" -append s_026*.png m_27.png
"${ImageMagic}${del}convert.exe" -append s_027*.png m_28.png
"${ImageMagic}${del}convert.exe" -append s_028*.png m_29.png
"${ImageMagic}${del}convert.exe" -append s_029*.png m_30.png
"${ImageMagic}${del}convert.exe" -append s_030*.png m_31.png
"${ImageMagic}${del}convert.exe" -append s_031*.png m_32.png
  
echo "Merge stage 2..."
"${ImageMagic}${del}convert.exe" +append m_*.png map.png

echo "Done"

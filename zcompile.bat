rem path = "C:\z88dk199c\bin"
path = "songs\"

cls

cd songs
@rem zx0 -f ReAofNo.pt3 ReAofNo.zx0
zx0 -f TrafOfD.pt3 TrafOfD.zx0
cd ..

z80asm.exe -v -s -m -b --split-bin Z_main.asm 

bas2tap -a10 loader.bas loader.tap

bin2tap -o Z_main.tap -a 32768 Z_main_MAIN.bin

bin2tap -o Z_PTZX.tap -a 49152 Z_main_PTZX_Player.bin

copy /b loader.tap + Z_main.tap + Z_PTZX.tap  1Z_output.tap

@del "loader.tap"
@del "Z_main.tap"
@del "Z_PTZX.tap"

@move "Z_main_MAIN.bin" "maps\"
@move "Z_main_PTZX_Player.bin" "maps\"
@move "Z_main.sym" "maps\"
@move "Z_main.map" "maps\"
@move "Z_main.o" "maps\"

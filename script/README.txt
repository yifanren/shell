
build_one.sh name [options]
=> Build archive/name, output to ~/XyunsOutput/rtd1185/ .

build_all.sh
=> Build archive/name in 000list.txt, output to ~/XyunsOutput/rtd1185/ ,
   and pack rtd1185 to rtd1185.tar.xz .



build_one.sh Follow Chart:
        Clean image creator
    =>  Read `name'
    =>  Get archive/`name'/def/secure.txt value
    =>  Get secure boot key by archive/`name'/def/name.txt if need
    =>  Finish archive/`name'/mk/ files
    =>  Do archive/`name'/mk copy
    =>  Build AP
    =>  Do AP copy
    =>  Get bootloader by archive/`name'/def/name.txt
    =>  Get kernel by archive/`name'/def/lan.txt
    =>  Get boot animation files by archive/`name'/def/name.txt
    =>  Unlzma System.map.lzma
    =>  Do archive/`name'/rss copy
    =>  Do archive/`name'/res copy
    =>  Do archive/`name'/conf copy
    =>  Create install.img
    =>  Do install.img copy and rename it
    =>  Clean image creator

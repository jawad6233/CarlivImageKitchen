###############################################################################
#                                                                             #
#                     Carliv Image Kitchen for Android                        #
#              for android phones copyright©2015 carliv@xda                   #
#             including support for MTK powered phones images                 #
#                                                                             #
###############################################################################	
	
	To use this Android images kitchen is very easy.
First, place your image files in the root of this Tool folder, just where the scripts are.
Then open a terminal window in this folder, or open the terminal and navigate with "cd" command from home to this folder.

	For unpacking type in terminal: 

# ./unpack_img your-image-name.img

or for a MTK image:

# ./unpack_MTK_img your-image-name.img

Example: ./unpack_MTK_img carliv_recovery.img

	After finish your modding job, for repacking type in terminal: 

# ./repack_img unpacked-folder

or for a MTK image:

# ./repack_MTK_img unpacked-folder 

Example: ./repack_MTK_img carliv-recovery

NOTE: As you can see, for repacking the input for script is a folder name, so there is no extension here, and no slashes or other things, just the name of the folder.

NOTE: few MTK phones, like AndroidOne project (sprout) doesn't have MTK header and you have to use the regular script for them.

	During repacking the script will prompt you to enter the desired name for the new repacked image: type a name without the extension ".img"; any name but be carefull to include the type of image in it - "boot" or "recovery". Example: "boot-stock-220115" or "carliv-recovery-30" or "new-boot" or "twrp-recovery", etc.
>>> This applies also to images you want to unpack. Don't use abstract names like "blue.img" or "seaside.img", use names which contains the image type inside, and this way it will be easier for you to understand what you are doing there.
	If you don't want to unpack the image but only to see or to check it's informations (offsets, sizes, addresses, cmdline, etc.) for various reasons, type this in terminal:

# ./image_info your-image-name.img

 Also a text file with all informations will be saved in utility's root folder.

	If you want to clear the Tool folder, double click on "clean_all" script, then select "Run in Terminal" when prompt, and all the working folders and files created by scripts will be deleted. All but your initial images and the repacked images. These you have to decide by yourself how to handle (delete, copy, move, etc.).
	
	My tool doesn't have restrictions on placement. For me it worked in last partition, in sub-subfolder, without problems.
	Please respect my work and if you use it don't forget to hit the THANKS button in my thread or to make a donation to buy me a coffee. And if you take it and share it on other sites, or integrate it in other tools, give proper credits for my work.
	I built from source every working module for this kitchen.
	
###############################################################################
#                                 CREDITS                                     #
#  * michfood from xda.developers for the initial ideea;                      #
#  * osm0sis from xda.developers for his Android Image Kitchen, which gave me #
#  some ideeas;                                                               #
#  * Android Open Source Project and Omnirom for the initial source code      #
#  of binaries;                                                               #
###############################################################################		
	

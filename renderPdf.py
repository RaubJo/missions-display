#!/usr/bin/env python3

import PySimpleGUI as PSG
from pdf2image import convert_from_path
from screeninfo import get_monitors
from PIL import Image
import glob
import os

pdf_dir = "resources/letters/"
source_imgs = "resources/source_images/"
resized_imgs = "resources/resized_images/"
width, height = None, None
display_seconds = 100
slide = 0
loading_window_width, loading_window_height = 640, 480
percent = 0
PSG.theme("DefaultNoMoreNagging")

loading_window_layout = [
    [
        PSG.Image(filename="logo.png", size=(250, 250), key="-logo-"),
        PSG.Text("NHBC Missions Display"),
    ],
#    [PSG.Output(size=(loading_window_width - 20, 10), key="-output-")],
    [
        PSG.ProgressBar(
            100,
            size=(loading_window_width - 20, 10),
            orientation="h",
            key="-progress-bar-",
        )
    ],
]


loading_window = PSG.Window(
    title="",
    no_titlebar=True,
    layout=loading_window_layout,
    size=(loading_window_width, loading_window_height),
    finalize=True,
)

loading_window.Refresh()

# Check is working directories exist if not make them
print("Checking for folders...")
loading_window.Refresh()
if not os.path.isdir(pdf_dir):
    os.makedirs(pdf_dir)
    print("Created: " + pdf_dir)
    percent += 10
    loading_window["-progress-bar-"].Update(percent)
else:
    percent += 10
    loading_window["-progress-bar-"].Update(percent)
    loading_window.Refresh()

if not os.path.isdir(source_imgs):
    os.makedirs(source_imgs)
    print("Created: " + source_imgs)
    percent += 10
    loading_window["-progress-bar-"].Update(percent)
else:
    percent += 10
    loading_window["-progress-bar-"].Update(percent)
    loading_window.Refresh()

if not os.path.isdir(resized_imgs):
    os.makedirs(resized_imgs)
    print("Created: " + resized_imgs)
    percent += 10
    loading_window["-progress-bar-"].Update(percent)
else:
    percent += 10
    loading_window["-progress-bar-"].Update(percent)
    loading_window.Refresh()

# Collect pdf letters to display and convert them to png images for PSG
pdfs_to_convert = glob.glob(pdf_dir + "*.pdf")
convert_percent_per_file = 35 / len(pdfs_to_convert)
for i in range(len(pdfs_to_convert)):
    fname = source_imgs + os.path.basename(pdfs_to_convert[i]).split(".")[0] + ".png"
    print("Checking for: " + fname)
    loading_window.Refresh()
    if not os.path.isfile(fname):
        print("Converting: " + pdfs_to_convert[i] + " to " + fname)
        images = convert_from_path(pdfs_to_convert[i], dpi=600)
        images[0].save(fname, "PNG")
        percent = percent + convert_percent_per_file
        loading_window["-progress-bar-"].Update(percent)
        loading_window.Refresh()
    else:
        print("Found!: " + fname)
        percent = percent + convert_percent_per_file
        loading_window["-progress-bar-"].Update(percent)
        loading_window.Refresh()

# Set width and height to screen size and scale images accordingly
# Only set width and height once
print("Getting Screen Size...")
loading_window.Refresh()
for m in get_monitors():
    if width == None:
        width = m.width
    if height == None:
        height = m.height

print("Screen Size: " + str(width) + ", " + str(height))
loading_window.Refresh()


def removeImages(image):
    os.remove(image)
    print("Removed " + str(image))


# Resize images to screen size for accurate fullscreen viewing
srcImgs_to_convert = glob.glob(source_imgs + "*.png")
resize_percent_per_file = 35 / len(srcImgs_to_convert)
for r in range(len(srcImgs_to_convert)):
    fname = (
        resized_imgs + os.path.basename(srcImgs_to_convert[r]).split(".")[0] + ".png"
    )
    srcImg = Image.open(srcImgs_to_convert[r])
    print("Checking for: " + fname)
    loading_window.Refresh()
    if not os.path.isfile(fname):
        print("Resizing: " + fname)
        resImg = srcImg.resize((width, height))
        resImg.save(fname)
        percent += resize_percent_per_file
        loading_window["-progress-bar-"].Update(percent)
        loading_window.Refresh()
    else:
        print("Found!")
        img = Image.open(fname)
        if not img.size == (width, height):
            print("Image is the wrong size!")
            removeImages(fname)
            print("Resizing: " + fname)
            resImg = srcImg.resize((width, height))
            resImg.save(fname)
            percent += resize_percent_per_file
            loading_window["-progress-bar-"].Update(percent)
            loading_window.Refresh()

print("Processing finished...")

loading_window.close()

# slides = glob.glob(resized_imgs+"*.png")
slides = sorted(
    glob.glob(resized_imgs + "*.png"),
    key=lambda x: int(os.path.basename(x).split(".")[0]),
)


def updatePSG():
    global slide
    if slide == len(slides):
        slide = 0
    else:
        print("Showing slide: " + str(slides[slide]))
        window["-Image-"].update(filename=slides[slide])
        slide = slide + 1


layout = [
    [
        PSG.Image(
            filename=slides[slide], pad=(0, 0), size=(width, height), key="-Image-"
        )
    ],
]

window = PSG.Window(
    "Test Window",
    layout,
    enable_close_attempted_event=True,
    no_titlebar=True,
    location=(0, 0),
    margins=(0, 0),
    finalize=True,
)

window.set_cursor("no")

while True:
    event, values = window.read(timeout=display_seconds * 1000)
    print(event, values)
    updatePSG()
    if event == PSG.WINDOW_CLOSE_ATTEMPTED_EVENT or event == "Exit":
        break
    if event == "__TIMEOUT__":
        updatePSG()

window.close()

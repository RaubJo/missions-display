#!/usr/bin/env python3

import PySimpleGUI as sg

loading_window_width, loading_window_height = 640, 480

sg.theme("DefaultNoMoreNagging")

loading_window_layout = [[sg.Image(filename="logo.png",size=(250,250),key="-logo-"), sg.Text("NHBC Missions Display")],
          [sg.Output(size=(loading_window_width-20,10),key="-output-")],
          [sg.ProgressBar(1000,size=(loading_window_width-20,10),orientation="h",key="-progress-bar-")]]

loading_window = sg.Window('My Title', layout=loading_window_layout, size=(loading_window_width,loading_window_height), location=(0,0), finalize=True)
print("Hello World!")

for i in range(1000):
    event, values = loading_window.read(timeout=1)
    print(i+1)
    loading_window["-progress-bar-"].Update(i+1)

loading_window.close()

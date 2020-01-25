#!/usr/bin/python

import Tkinter as tk
from Tkinter import simpledialog

ROOT = tk.Tk()

ROOT.withdraw()

USER_INP = simpledialog.askstring(title="test",prompt="what's your name?")

print("Hello ", USER_INP)

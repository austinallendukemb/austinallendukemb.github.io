"""This is the Python code for my first HW assignment."""

import csv
import io
import urllib.request

import numpy as np
import openpyxl
import pandas as pd


data_url = "https://causeweb.org/tshs/datasets/Surgery%20Timing.xlsx"
df = pd.read_excel(data_url)

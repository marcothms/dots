#!/usr/bin/python3

import os
import sys
import random
import re
import argparse


def get_wallpapers(query: str, path: str):
    "Fetch a wallpaper"

    # Search through all wallpapers
    wallpapers = [f for f in os.listdir(path) if re.search(r"png|jpg", f)]
    queried_wallpapers = [f for f in wallpapers if re.search(rf"{query}", f)]

    return queried_wallpapers

def pick_wallpaper(wallpaper_list, *args):
    # Error handling
    if not wallpaper_list:
        print("No wallpapers found!")
        sys.exit(1)
    else:
        new_wallpaper = random.choice(wallpaper_list)

    return new_wallpaper

def list_wallpapers(wallpaper_list, *args):
    print("Wallpapers matching your query:")
    for wallpaper in wallpaper_list:
        print(wallpaper)


if __name__ == "__main__":

    ### DEFAULT WALLPAPER DIRECTORY HERE
    path = "data/wallpaper"

    parser = argparse.ArgumentParser()
    parser.add_argument("-q", "--query", help="Refine selection")
    parser.add_argument("-p", "--path", help="Path to wallpaper directory")
    parser.add_argument("-l", "--list", action="store_true", help="List potential wallpapers" )
    args = parser.parse_args()

    query = ""
    if args.query:
        query = args.query
        print(f"Searching for wallpapers filename matching: {query}")

    if args.path:
        path = args.path
    print(f"Searching in: {path}")

    # Get a list of all wallpapers
    wallpaper_list = get_wallpapers(query, path)

    if args.list:
        print("=================================================")
        print("Arg '--list' is set. No wallpaper will be applied")
        print("=================================================")
        list_wallpapers(wallpaper_list)
        sys.exit(1)

    # Pick one wallpaper
    query_result = pick_wallpaper(wallpaper_list)
    wallpaper = path + "/" + query_result

    os.system(f"feh --bg-scale {wallpaper}")
    print(f"Updated wallpaper to: {wallpaper}")

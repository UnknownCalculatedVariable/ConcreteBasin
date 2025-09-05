import json
import os

def convert_pywal_to_vicinae(pywal_path, output_path):
    # Expand the ~ to absolute paths
    pywal_path = os.path.expanduser(pywal_path)
    output_path = os.path.expanduser(output_path)
    
    # Check if Pywal file exists
    if not os.path.exists(pywal_path):
        print(f"Error: Pywal colors file not found at {pywal_path}")
        print("Make sure you've run 'wal' at least once to generate colors")
        return False
    
    # Load Pywal colors
    with open(pywal_path, 'r') as f:
        pywal = json.load(f)
    
    # Map Pywal colors to Vicinae format
    vicinae_theme = {
        "version": "1.0.0",
        "appearance": "dark",
        "icon": "./dynamic-theme.png",
        "name": "Pywal Dynamic",
        "description": "Automatically generated from Pywal",
        "palette": {
            "background": pywal['special']['background'],
            "foreground": pywal['special']['foreground'],
            "blue": pywal['colors']['color4'],
            "green": pywal['colors']['color2'],
            "magenta": pywal['colors']['color5'],
            "orange": pywal['colors']['color11'],
            "purple": pywal['colors']['color13'],
            "red": pywal['colors']['color1'],
            "yellow": pywal['colors']['color3'],
            "cyan": pywal['colors']['color6']
        }
    }
    
    # Create output directory if it doesn't exist
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    
    # Save Vicinae theme (overwrites if file exists)
    with open(output_path, 'w') as f:
        json.dump(vicinae_theme, f, indent=2)
    
    print(f"Successfully updated Pywal theme at {output_path}")
    return True

# Usage - simply overwrites the file each time
success = convert_pywal_to_vicinae('~/.cache/wal/colors.json', '~/.config/vicinae/themes/pywal-theme.json')

if success:
    print("Theme updated successfully!")
else:
    print("Update failed. Please run 'wal' first to generate colors.")

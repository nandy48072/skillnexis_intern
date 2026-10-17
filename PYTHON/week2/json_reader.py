# Assignment 3: JSON File Reader[cite: 2]

import json

def read_json_file(filename):
    try:
        with open(filename, 'r', encoding='utf-8') as file:
            data = json.load(file)
            
            print(f"\n--- Formatted JSON Output from '{filename}' ---")
            # json.dumps with indent=4 outputs formatted JSON data
            print(json.dumps(data, indent=4))
            
    except FileNotFoundError:
        print(f"Error: The file '{filename}' was not found.")
    except json.JSONDecodeError:
        print("Error: Failed to decode JSON from the file.")

if __name__ == "__main__":
    # Creates a sample JSON file for demonstration
    sample_json = "data.json"
    sample_data = {
        "student": {
            "name": "Nandhini",
            "roll_number": "101",
            "skills": ["Python", "Android", "Flutter"]
        },
        "course": "Data Structures & Loops"
    }
    
    with open(sample_json, "w", encoding="utf-8") as f:
        json.dump(sample_data, f, indent=4)
        
    print(f"Created a sample JSON file named '{sample_json}'.")
    read_json_file(sample_json)
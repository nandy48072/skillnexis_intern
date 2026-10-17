# Assignment 2: Word Counter from Text File

def count_file_stats(filename):
    try:
        with open(filename, 'r', encoding='utf-8') as file:
            content = file.read()
            
            # Count total characters
            char_count = len(content)
            
            # Count total lines
            file.seek(0)
            line_count = len(file.readlines())
            
            # Count total words
            words = content.split()
            word_count = len(words)
            
            print(f"\n--- File Statistics for '{filename}' ---")
            print(f"Lines: {line_count}")
            print(f"Words: {word_count}")
            print(f"Characters: {char_count}")
            
    except FileNotFoundError:
        print(f"Error: The file '{filename}' was not found.")

if __name__ == "__main__":
    # Creates a sample file for demonstration if it doesn't exist
    sample_filename = "sample.txt"
    with open(sample_filename, "w", encoding="utf-8") as f:
        f.write("Hello world!\nWelcome to Python programming.\nFile I/O operations are very useful.")
    
    print(f"Created a sample text file named '{sample_filename}'.")
    count_file_stats(sample_filename)
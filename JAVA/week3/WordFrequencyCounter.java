import java.io.*;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

public class WordFrequencyCounter {
    public static void main(String[] args) {
        String inputFileName = "input.txt";
        String outputFileName = "output.txt";

        // Create a sample input file automatically if it doesn't exist
        createSampleInputFile(inputFileName);

        Map<String, Integer> wordCountMap = new TreeMap<>();

        // 1. Read from text file and count frequencies
        try (BufferedReader reader = new BufferedReader(new FileReader(inputFileName))) {
            String line;
            while ((line = reader.readLine()) != null) {
                // Convert to lowercase and split by non-word characters
                String[] words = line.toLowerCase().split("\\W+");
                for (String word : words) {
                    if (!word.isEmpty()) {
                        wordCountMap.put(word, wordCountMap.getOrDefault(word, 0) + 1);
                    }
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading the file: " + e.getMessage());
            return;
        }

        // 2. Write output to another file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(outputFileName))) {
            writer.write("--- Word Frequency Report ---\n");
            for (Map.Entry<String, Integer> entry : wordCountMap.entrySet()) {
                writer.write(entry.getKey() + ": " + entry.getValue() + "\n");
            }
            System.out.println("Word frequency successfully counted and written to " + outputFileName);
        } catch (IOException e) {
            System.out.println("Error writing to the file: " + e.getMessage());
        }
    }

    private static void createSampleInputFile(String fileName) {
        File file = new File(fileName);
        if (!file.exists()) {
            try (PrintWriter writer = new PrintWriter(file)) {
                writer.println("Java programming is fun. Java and Python are popular.");
                writer.println("File handling in Java is very powerful.");
            } catch (IOException e) {
                System.out.println("Could not create sample input file.");
            }
        }
    }
}
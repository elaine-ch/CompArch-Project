import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;
import java.io.File;
import java.io.FileWriter;

public class Assembler {

    static final boolean CLEAN_ASSEMBLY = true;

    static final String FORMAT = ".txt";

    static final int VERSION = 1;
    static final String ASSEMBLY_FILE = "assembly" + VERSION + FORMAT;  // assembly1.txt
    static final String MACHINE_CODE_FILE = "machine_code" + VERSION + FORMAT;  // machine_code.txt

    static final String NO_COMMENT_FILE = "clean_assembly" + VERSION + FORMAT;

    public static void main(String[] args) {
        CommentRemover commentRemover = new CommentRemover();
        Translator translator = new Translator();

        // removes comments from the assembly code
        createFrom(ASSEMBLY_FILE, NO_COMMENT_FILE, commentRemover);

        // translatesl to machine code, except branches
        createFrom(NO_COMMENT_FILE, MACHINE_CODE_FILE, translator);
        return;
    }

    public static void createFrom(String source, String destination, Converter c) {
        try {
            File toRead = new File(source);
            Scanner scan = new Scanner(toRead);
            FileWriter mach = new FileWriter(destination);

            String line;

            while (scan.hasNextLine()) {
                line = scan.nextLine().toLowerCase();

                // use the converter to process the line
                line = c.process(line);

                if (line.length() > 0) {
                    mach.write(line);
                    mach.write('\n');
                }
            }

            scan.close();
            mach.close();
            System.out.println("Done");
            
        } catch (FileNotFoundException e) {
            System.out.println("File not found.");
            e.printStackTrace();
        } catch (IOException e) {
            System.err.print("An IO exception occurred.");
            e.printStackTrace();
        }
    }
}
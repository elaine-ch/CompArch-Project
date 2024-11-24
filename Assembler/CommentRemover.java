public class CommentRemover implements Converter {
    public String process(String line) {
        if (line.contains("#")) {
            line = line.substring(0, line.indexOf("#"));
        }
        return line.trim();
    }
}

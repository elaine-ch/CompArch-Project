public class Translator implements Converter {
    public String process(String line) {
        if (line.length() < 3) {
            return "";
        }
        
        String ins = "";
        switch(line.substring(0, 3)) {
            case "and": 
                ins += "0"; // R type
                ins += "000"; // opcode
                ins += getOperands();
                break;
            case "add": 
                ins += "0"; // R type
                ins += "001"; // opcode
                break;
            case "sub": 
                ins += "0"; // R type
                ins += "010"; // opcode
                break;
            case "orr": 
                ins += "0"; // R type
                ins += "011"; // opcode
                break;
            case "lst": 
                ins += "0"; // R type
                ins += "100"; // opcode
                break;
            case "rst": 
                ins += "0"; // R type
                ins += "101"; // opcode
                break;
            case "cmp": 
                ins += "0"; // R type
                ins += "110"; // opcode
                break;
            case "don": 
                ins += "1"; // B type
                ins += "111"; // opcode
                break;
            case "beq": 
                ins += "1"; // B type
                ins += "00"; // opcode
                break;
            case "ldr": 
                ins += "1"; // B type
                ins += "10"; // opcode
                break;
            case "ldc": 
                ins += "1"; // B type
                ins += "10"; // opcode
                break;
            case "str": 
                ins += "1"; // B type
                ins += "01"; // opcode
                break;
            case "mov": 
                ins += "1"; // B type
                ins += "11"; // opcode
                break;
            default:
        }
        return ins;
    }

    private String getOperands() {
        return "";
    }
}

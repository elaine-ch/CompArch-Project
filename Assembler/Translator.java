public class Translator implements Converter {
    static int lineCount = 1;

    static final String[] R_TYPE_OPERANDS = new String[] {"r0", "r1", "r2", "r3"};
    static final String[] REGISTERS = new String[] {"r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7"};

    public String process(String line) {
        if (line.length() < 3) {
            return "";
        }
        
        String ins = "";
        switch(line.substring(0, 3)) {
// ------------ R-type ops ------------
            case "and": 
                ins += "0"; // R type
                ins += "000"; // opcode
                ins += getRRegisters(line.substring(4));
                break;
            case "add": 
                ins += "0"; // R type
                ins += "001"; // opcode
                ins += getRRegisters(line.substring(4));
                break;
            case "sub": 
                ins += "0"; // R type
                ins += "010"; // opcode
                ins += getRRegisters(line.substring(4));
                break;
            case "orr": 
                ins += "0"; // R type
                ins += "011"; // opcode
                ins += getRRegisters(line.substring(4));
                break;
            case "lst": 
                ins += "0"; // R type
                ins += "100"; // opcode
                ins += getRRegisters(line.substring(4));
                break;
            case "rst": 
                ins += "0"; // R type
                ins += "101"; // opcode
                ins += getRRegisters(line.substring(4));
                break;
            case "cmp": 
                ins += "0"; // R type
                ins += "110"; // opcode
                ins += getRRegisters(line.substring(4));
                break;
            case "don": 
                ins += "1"; // B type
                ins += "111"; // opcode
                ins += "11111"; // padding
                break;
// ------------ B-type ops ------------
            case "beq": 
                ins = line.trim();
                break;
            case "ldr": 
                ins += "1"; // B type
                ins += "10"; // opcode
                ins += toBinary(assignRegister(line.substring(4), REGISTERS), 3);
                ins += "11";    // padding
                ins += "0";     // signifier
                break;
            case "ldc": 
                ins += "1"; // B type
                ins += "10"; // opcode
                ins += line.substring(4);   // constant
                ins += "1";   // signifier
                break;
            case "str": 
                ins += "1"; // B type
                ins += "01"; // opcode
                ins += toBinary(assignRegister(line.substring(4), REGISTERS), 3);
                ins += "111";    // padding
                break;
                case "mov": 
                ins += "1"; // B type
                ins += "11"; // opcode
                line = line.substring(4).replace(" ", "").toLowerCase();
                String[] parts = line.split(",");
                ins += toBinary(assignRegister(parts[0].trim(), REGISTERS), 3);
                ins += toBinary(assignRegister(parts[1].trim(), REGISTERS), 3);
                break;
            default:
                line = line.trim();
                if (line.charAt(line.length() - 1) == ':') {    // labels
                    ins = line;
                }
                else {
                    System.out.println("Error in translator" + " at line " + lineCount);
                }
        }
        lineCount++;
        return ins;
    }

    /**
     * Outputs an array of int corresponding to the R-type register operands
     * @param line the assembly line containing comma-separated registers
     * @return the 5-bit machine code corresponding to both R-type operands
     */
    private String getRRegisters(String line) {
        // remove space/tabs, to lower case
        line = line.replace(" ", "");
        line = line.toLowerCase().trim();

        String[] parts = line.split(",");

        // check number of registers
        if (parts.length != 2) {
            System.err.println("Invalid number of registers at line " + lineCount);
        }

        String reg = "";
        reg += toBinary(assignRegister(parts[0], R_TYPE_OPERANDS), 2);
        reg += toBinary(assignRegister(parts[1], REGISTERS), 3);
        return reg;
    }

    /**
     * Returns the register number (to be converted in binary) based on available registers
     * @param reg the register to assign
     * @param registers the available registers for a given operation
     * @return the register number corresponding to the operation
     */
    private int assignRegister(String reg, String[] registers) {
        for (int i = 0; i < registers.length; i++) {
            if (registers[i].equals(reg)) {
                return i;
            }
        }
        System.err.println("Assigned invalid register value of: " + reg + "\n at line " + lineCount);
        return -1;
    }

    /**
     * Converts val from decimal to binary.
     * Used for registers.
     * @param val non-negative decimal value
     * @param size number of bits to output
     * @return the value converted to binary
     */
    private String toBinary(int val, int size) {
        if (size < 0) {
            System.err.println("Negative number at line " + lineCount);
            return null;
        }

        String result = "";
        int powerOfTwo;

        while (size-- > 0) {
            powerOfTwo = (int) Math.pow(2, size);
            if (val >= powerOfTwo) {
                result += "1";
                val -= powerOfTwo;
            } 
            else {
                result += "0";
            }
        }

        return result;
    }
}

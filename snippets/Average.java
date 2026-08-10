public class Average {

    /** Returns the arithmetic mean of an array of values. */
    public static double average(double[] values) {
        double sum = 0;
        for (double value : values) {
            sum += value;
        }
        return sum / values.length;
    }
}

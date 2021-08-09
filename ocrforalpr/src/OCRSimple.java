import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

import javax.swing.DefaultListModel;
import javax.swing.JOptionPane;
import javax.swing.SwingUtilities;

import com.heatonresearch.book.introneuralnet.neural.som.SelfOrganizingMap;
import com.heatonresearch.book.introneuralnet.neural.som.TrainSelfOrganizingMap;
import com.heatonresearch.book.introneuralnet.neural.som.NormalizeInput.NormalizationType;
import com.heatonresearch.book.introneuralnet.neural.som.TrainSelfOrganizingMap.LearningMethod;

/**
 *
 * @author David
 */
public class OCRSimple implements Runnable{
    
    public class UpdateStats implements Runnable {
        
                long _tries;
                double _lastError;
                double _bestError;

                public void run() {
                    System.out.println("y esto????");
                    System.out.println("" + this._tries);
                    System.out.println("" + this._lastError);
                    System.out.println("" + this._bestError);
                        
                }
        }
     /**
         * Serial id for this class.
         */
        private static final long serialVersionUID = -6779380961875907013L;

        /**
         * The downsample width for the application.
         */
        static final int DOWNSAMPLE_WIDTH = 5;

        /**
         * The down sample height for the application.
         */
        static final int DOWNSAMPLE_HEIGHT = 7;

        static final double MAX_ERROR = 0.01;
        
                 /* The main method.
         * 
         * @param args
         *            Args not really used.
         */
        public static void main(final String args[]) {
        OCRSimple ocrs = new OCRSimple();
        ocrs.load();
        ocrs.train();
        int i = Integer.parseInt(JOptionPane.showInputDialog("ingresa el numero"));
        if(i==1){
        final double input[] ={-0.5,-0.5,-0.5,0.5,0.5,-0.5,-0.5,-0.5,0.5,0.5,-0.5,-0.5,0.5,0.5,0.5,-0.5,0.5,0.5,-0.5,0.5,-0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,-0.5,-0.5,-0.5,0.5};
        char car = ocrs.Recognition(input);
        System.out.println(car);
        }else{
            System.out.println("todavia no");
        }
         //final double input[] ={-0.5,-0.5,-0.5,0.5,0.5,-0.5,-0.5,-0.5,0.5,0.5,-0.5,-0.5,0.5,0.5,0.5,-0.5,0.5,0.5,-0.5,0.5,-0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,-0.5,-0.5,-0.5,0.5};
//         char car = ocrs.Recognition(input);
//         System.out.println(car);
        }
         boolean halt;

        /**
         * The entry component for the user to draw into.
         */
        Entry entry;

        /**
         * The down sample component to display the drawing downsampled.
         */
        Sample sample;

        /**
         * The letters that have been defined.
         */
        DefaultListModel letterListModel = new DefaultListModel();
        /**
         * The neural network.
         */
        SelfOrganizingMap net;
        /**
         * The background thread used for training.
         */
        Thread trainThread = null;
        
         char[] mapNeurons() {
                final char map[] = new char[this.letterListModel.size()];

                for (int i = 0; i < map.length; i++) {
                        map[i] = '?';
                }
                for (int i = 0; i < this.letterListModel.size(); i++) {
                        final double input[] = new double[5 * 7];
                        int idx = 0;
                        final SampleData ds = (SampleData) this.letterListModel
                                        .getElementAt(i);
                        for (int y = 0; y < ds.getHeight(); y++) {
                                for (int x = 0; x < ds.getWidth(); x++) {
                                        input[idx++] = ds.getData(x, y) ? .5 : -.5;
                                }
                        }

                        final int best = this.net.winner(input);
                        map[best] = ds.getLetter();
                }
                return map;
        }
       public char Recognition(double []input){
            //input A = -0.5-0.5-0.50.50.5-0.5-0.5-0.50.50.5-0.5-0.50.50.50.5-0.50.50.5-0.50.5-0.50.50.50.50.50.50.50.50.50.50.5-0.5-0.5-0.50.5;
              int best = this.net.winner(input);
             char map[] = mapNeurons();
             return (map[best]);
        }

    @Override
    public void run() {
        System.out.println("esto se ejecuta cuando se entrena");
                        try {
                        final int inputNeuron = OCR.DOWNSAMPLE_HEIGHT
                                        * OCR.DOWNSAMPLE_WIDTH;
                        final int outputNeuron = this.letterListModel.size();

                        final double set[][] = new double[this.letterListModel.size()][inputNeuron];

                        for (int t = 0; t < this.letterListModel.size(); t++) {
                                int idx = 0;
                                final SampleData ds = (SampleData) this.letterListModel
                                                .getElementAt(t);
                                for (int y = 0; y < ds.getHeight(); y++) {
                                        for (int x = 0; x < ds.getWidth(); x++) {
                                                set[t][idx++] = ds.getData(x, y) ? .5 : -.5;
                                        }
                                }
                        }

                        this.net = new SelfOrganizingMap(inputNeuron, outputNeuron,
                                        NormalizationType.MULTIPLICATIVE);
                        final TrainSelfOrganizingMap train = new TrainSelfOrganizingMap(
                                        this.net, set,LearningMethod.SUBTRACTIVE,0.5);
                        int tries = 1;

                        do {
                                train.iteration();
                                update(tries++, train.getTotalError(), train.getBestError());
                        } while ((train.getTotalError() > MAX_ERROR) && !this.halt);

                        this.halt = true;
                        update(tries, train.getTotalError(), train.getBestError());

                } catch (final Exception e) {
                        e.printStackTrace();
                        //JOptionPane.showMessageDialog(this, "Error: " + e + "Training",JOptionPane.ERROR_MESSAGE);
                        System.out.println("Error: " + e + "Training");
                }
    }
    public void train() {
                if (this.trainThread == null) {
                        this.trainThread = new Thread(this);
                        this.trainThread.start();
                } else {
                        this.halt = true;
                }
        }
            public void update(final int retry, final double totalError, final double bestError) {

                if (this.halt) {
                        this.trainThread = null;
                        System.out.println("Begin Training");
                        //JOptionPane.showMessageDialog(this, "Training has completed.","Training", JOptionPane.PLAIN_MESSAGE);
                        System.out.println("Training has completed.");
                }
                final UpdateStats stats = new UpdateStats();
                stats._tries = retry;
                stats._lastError = totalError;
                stats._bestError = bestError;
                try {
                        SwingUtilities.invokeAndWait(stats);
                } catch (final Exception e) {
                        //JOptionPane.showMessageDialog(this, "Error: " + e, "Training", JOptionPane.ERROR_MESSAGE);
                    System.out.println("Error: " + e + "training");
                }
        }
            
                 public void load() {
                try {
                        FileReader f;// the actual file stream
                        BufferedReader r;// used to read the file line by line

                        f = new FileReader(new File("./sample.dat"));
                        r = new BufferedReader(f);
                        String line;
                        int i = 0;

                        this.letterListModel.clear();

                        while ((line = r.readLine()) != null) {
                                final SampleData ds = new SampleData(line.charAt(0),
                                                OCR.DOWNSAMPLE_WIDTH, OCR.DOWNSAMPLE_HEIGHT);
                                this.letterListModel.add(i++, ds);
                                int idx = 2;
                                for (int y = 0; y < ds.getHeight(); y++) {
                                        for (int x = 0; x < ds.getWidth(); x++) {
                                                ds.setData(x, y, line.charAt(idx++) == '1');
                                        }
                                }
                        }

                        r.close();
                        f.close();
                        //clear_actionPerformed(null);
                        //JOptionPane.showMessageDialog(this, "Loaded from 'sample.dat'.","Training", JOptionPane.PLAIN_MESSAGE);
                        System.out.println("Loaded from 'sample.dat'.");
                } catch (final Exception e) {
                        e.printStackTrace();
                       // JOptionPane.showMessageDialog(this, "Error: " + e, "Training",JOptionPane.ERROR_MESSAGE);
                        System.out.println("Error: " + e + "Training");
                }

        }
    
    
}

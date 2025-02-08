import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.*;

public class PhishingDetectorGUI extends JFrame {

    private JTextField urlField;
    private JTextArea resultArea;
    private JProgressBar progressBar;

    public PhishingDetectorGUI() {
        // Frame settings
        setTitle("Phishing Detection System");
        setSize(500, 350);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        // Input panel
        JPanel inputPanel = new JPanel();
        inputPanel.setLayout(new FlowLayout());

        JLabel urlLabel = new JLabel("Enter URL: ");
        urlField = new JTextField(30);
        JButton checkButton = new JButton("Check");

        inputPanel.add(urlLabel);
        inputPanel.add(urlField);
        inputPanel.add(checkButton);

        // Result area
        resultArea = new JTextArea(10, 40);
        resultArea.setEditable(false);
        resultArea.setFont(new Font("Arial", Font.BOLD, 14));
        JScrollPane scrollPane = new JScrollPane(resultArea);

        // Progress bar
        progressBar = new JProgressBar();
        progressBar.setStringPainted(true);
        progressBar.setVisible(false);

        // Add components to frame
        add(inputPanel, BorderLayout.NORTH);
        add(scrollPane, BorderLayout.CENTER);
        add(progressBar, BorderLayout.SOUTH);

        // Button click event
        checkButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String url = urlField.getText();
                if (!url.isEmpty()) {
                    runPythonScript(url);
                } else {
                    JOptionPane.showMessageDialog(null, "Please enter a URL", "Error", JOptionPane.ERROR_MESSAGE);
                }
            }
        });

        setVisible(true);
    }

    // Function to run the Python script
    private void runPythonScript(final String url) {
        progressBar.setIndeterminate(true);
        progressBar.setVisible(true);
        resultArea.setText("Checking URL, please wait...");

        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    // Execute Python script
                    ProcessBuilder pb = new ProcessBuilder("python", "app.py", url);
                    pb.redirectErrorStream(true);
                    Process process = pb.start();
                    process.waitFor();

                    // Read result from result.txt
                    final String result = readResultFile();

                    // Update UI on the Event Dispatch Thread
                    SwingUtilities.invokeLater(new Runnable() {
                        @Override
                        public void run() {
                            resultArea.setText(result);
                            progressBar.setVisible(false);

                            if (result.contains("Phishing")) {
                                resultArea.setForeground(Color.RED);
                                JOptionPane.showMessageDialog(null, "⚠ WARNING! This URL is a phishing site!", "Phishing Alert", JOptionPane.WARNING_MESSAGE);
                            } else {
                                resultArea.setForeground(Color.GREEN);
                            }
                        }
                    });

                } catch (Exception ex) {
                    SwingUtilities.invokeLater(new Runnable() {
                        @Override
                        public void run() {
                            resultArea.setText("Error executing Python script.");
                            progressBar.setVisible(false);
                        }
                    });
                    ex.printStackTrace();
                }
            }
        }).start();
    }

    // Function to read the result.txt file
    private String readResultFile() {
        StringBuilder result = new StringBuilder();
        try {
            BufferedReader br = new BufferedReader(new FileReader("result.txt"));
            String line;
            while ((line = br.readLine()) != null) {
                result.append(line).append("\n");
            }
            br.close();
        } catch (IOException e) {
            result.append("Error: Unable to read result.txt");
        }
        return result.toString();
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                new PhishingDetectorGUI();
            }
        });
    }
}

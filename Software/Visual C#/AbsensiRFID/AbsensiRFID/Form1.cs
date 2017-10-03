using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO.Ports;
using System.Diagnostics;
using MySql.Data.MySqlClient;

namespace AbsensiRFID
{
    public partial class MainForm : Form
    {
        int dataMasuk = 0;
        string dataSerialPort;
        MySqlConnection conn;
        DataTable tabel = new DataTable();
        public MainForm()
        {
            InitializeComponent();
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
  

            if (conn != null)
            {
                conn.Close();
            }

            string connStr = String.Format("server={0};user id={1}; password={2}; database=data_absensi; pooling=false; Convert Zero Datetime=True", "127.0.0.1", "root", "");

            try
            {
                conn = new MySqlConnection(connStr);
                conn.Open();
            }
            catch (Exception error)
            {
                MessageBox.Show(error.ToString(), "Database Error !");
            }
            MySqlDataAdapter data = new MySqlDataAdapter();
            MySqlCommand command = conn.CreateCommand();
            try
            {
                //command.CommandText = "SELECT * FROM rfid";
                command.CommandText = "SELECT * FROM `tabel_absensi` ORDER BY `tabel_absensi`.`No.` DESC";
                data.SelectCommand = command;
                DataSet dataset = new DataSet();
                data.Fill(dataset, "hasil");
                dataGridView1.DataSource = dataset;
                dataGridView1.DataMember = "hasil";
            }
            catch (MySqlException ex)
            {
                MessageBox.Show("Error connecting to the server: " + ex.Message);
            }

            comboBoxSerial.Items.Clear();
            foreach (string item in SerialPort.GetPortNames())
            {
                comboBoxSerial.Items.Add(item);
            }
            comboBoxSerial.SelectedIndex = 0;
        }

        private void buttonConnect_Click(object sender, EventArgs e)
        {
            serialPort.PortName = comboBoxSerial.Text;
            try
            {
                serialPort.Open();
            }
            catch (Exception error)
            {
                MessageBox.Show(error.ToString(),"Serial Port Error !");   
            }
            if (serialPort.IsOpen)
            {
                MessageBox.Show("Port Opened !", "Serial Port Status ",MessageBoxButtons.OK,MessageBoxIcon.Information);
                buttonConnect.Enabled = false;
                buttonDisconnect.Enabled = true;
            }
        }

        private void buttonDisconnect_Click(object sender, EventArgs e)
        {
            if (serialPort.IsOpen)
            {
                serialPort.Close();
                buttonConnect.Enabled = true;
                buttonDisconnect.Enabled = false;
            }
        }

        private void serialPort_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            string dataTerima = serialPort.ReadLine();
            dataSerialPort = dataTerima;
            dataMasuk = 1;
            UpdateTextBox(dataTerima);
            Debug.Write(dataTerima);                   
        }

        delegate void UpdateLogTextFromThreadDelegate(String msg);

        public void UpdateTextBox(String msg)
        {
            if (!this.IsDisposed && textBoxIncomingData.InvokeRequired)
            {
                textBoxIncomingData.Invoke(new UpdateLogTextFromThreadDelegate(UpdateTextBoxSerialData), new Object[] { msg });
            }
        }

        public void UpdateTextBoxSerialData(String msg)
        {
            textBoxIncomingData.Text = msg;
        }
        

        private void button2_Click(object sender, EventArgs e)
        {

            string tesData = "Tom Cruise|{0x00, 0x06, 0x00, 0x00, 0x07, 0x05, 0x05, 0x08, 0x00, 0x02, 0x02, 0x09}\r\n";
            string[] hasilParsing;
            char[] pembatas = { '|', '\r', '\n' };
            hasilParsing = tesData.Split(pembatas);
            hasilParsing[0] = "eko";
            hasilParsing[1] = "asasd";
            MySqlDataAdapter data = new MySqlDataAdapter();
            MySqlCommand command = conn.CreateCommand();
            try
            {
                command.CommandText = "INSERT INTO `data_absensi`.`tabel_absensi` (`No.`, `Nama User`, `RFID No.`, `Waktu Masuk`) VALUES (NULL, '" + hasilParsing[0] + "', '" + hasilParsing[1] + "', '" + DateTime.Now.ToString() + "')";
                data.InsertCommand = command;
                command.ExecuteNonQuery();
            }
            catch (MySqlException ex)
            {
                MessageBox.Show("Error connecting to the server: " + ex.Message);
            }

            try
            {
                command.CommandText = "SELECT * FROM tabel_absensi";
                data.SelectCommand = command;
                DataSet dataset = new DataSet();
                data.Fill(dataset, "hasil");
                dataGridView1.DataSource = dataset;
                dataGridView1.DataMember = "hasil";
            }
            catch (MySqlException ex)
            {
                MessageBox.Show("Error connecting to the server: " + ex.Message);
            }
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            if (dataMasuk == 1)
            {          
                string[] hasilParsing;
                char[] pembatas = { '|', '\r', '\n' };
                hasilParsing = dataSerialPort.Split(pembatas);
                MySqlDataAdapter data = new MySqlDataAdapter();
                MySqlCommand command = conn.CreateCommand();
                try
                {
                    command.CommandText = "INSERT INTO `data_absensi`.`tabel_absensi` (`No.`, `Nama User`, `RFID No.`, `Waktu Masuk`) VALUES (NULL, '" + hasilParsing[0] + "', '" + hasilParsing[1] + "', '" + DateTime.Now.ToString() + "')";
                    data.InsertCommand = command;
                    command.ExecuteNonQuery();
                }
                catch (MySqlException ex)
                {
                    MessageBox.Show("Error connecting to the server: " + ex.Message);
                }

                try
                {
                    //command.CommandText = "SELECT * FROM rfid";
                    command.CommandText = "SELECT * FROM `tabel_absensi` ORDER BY `tabel_absensi`.`No.` DESC";
                    data.SelectCommand = command;
                    DataSet dataset = new DataSet();
                    data.Fill(dataset, "hasil");
                    dataGridView1.DataSource = dataset;
                    dataGridView1.DataMember = "hasil";
                }
                catch (MySqlException ex)
                {
                    MessageBox.Show("Error connecting to the server: " + ex.Message);
                }
                dataMasuk = 0;
            }
        }
   
    }
}

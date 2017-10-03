namespace AbsensiRFID
{
    partial class MainForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            Mitov.InstrumentLab.DecimalPointSegment decimalPointSegment2 = new Mitov.InstrumentLab.DecimalPointSegment();
            Mitov.InstrumentLab.DecimalPointOffset decimalPointOffset2 = new Mitov.InstrumentLab.DecimalPointOffset();
            Mitov.SignalLab.ElementSize elementSize19 = new Mitov.SignalLab.ElementSize();
            Mitov.SignalLab.ElementSize elementSize20 = new Mitov.SignalLab.ElementSize();
            Mitov.SignalLab.ElementSize elementSize21 = new Mitov.SignalLab.ElementSize();
            Mitov.InstrumentLab.SegmentIndents segmentIndents2 = new Mitov.InstrumentLab.SegmentIndents();
            Mitov.SignalLab.ElementSize elementSize22 = new Mitov.SignalLab.ElementSize();
            Mitov.SignalLab.ElementSize elementSize23 = new Mitov.SignalLab.ElementSize();
            Mitov.SignalLab.ElementSize elementSize24 = new Mitov.SignalLab.ElementSize();
            Mitov.SignalLab.ElementSize elementSize25 = new Mitov.SignalLab.ElementSize();
            OpenWire.Proxy.SinkPin sinkPin2 = new OpenWire.Proxy.SinkPin();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainForm));
            Mitov.InstrumentLab.Rotation rotation2 = new Mitov.InstrumentLab.Rotation();
            Mitov.InstrumentLab.DigitalClockSections digitalClockSections2 = new Mitov.InstrumentLab.DigitalClockSections();
            Mitov.InstrumentLab.DigitalAmPmSection digitalAmPmSection2 = new Mitov.InstrumentLab.DigitalAmPmSection();
            Mitov.InstrumentLab.PointOffset pointOffset3 = new Mitov.InstrumentLab.PointOffset();
            Mitov.SignalLab.ElementSize elementSize26 = new Mitov.SignalLab.ElementSize();
            Mitov.SignalLab.ElementSize elementSize27 = new Mitov.SignalLab.ElementSize();
            Mitov.InstrumentLab.SegmentFont segmentFont2 = new Mitov.InstrumentLab.SegmentFont();
            Mitov.SignalLab.ElementSize elementSize28 = new Mitov.SignalLab.ElementSize();
            Mitov.InstrumentLab.PointOffset pointOffset4 = new Mitov.InstrumentLab.PointOffset();
            Mitov.SignalLab.ElementSize elementSize29 = new Mitov.SignalLab.ElementSize();
            Mitov.SignalLab.ElementSize elementSize30 = new Mitov.SignalLab.ElementSize();
            Mitov.SignalLab.ElementSize elementSize31 = new Mitov.SignalLab.ElementSize();
            Mitov.InstrumentLab.DigitalHourSection digitalHourSection2 = new Mitov.InstrumentLab.DigitalHourSection();
            Mitov.InstrumentLab.MillisecondsClockSection millisecondsClockSection2 = new Mitov.InstrumentLab.MillisecondsClockSection();
            Mitov.InstrumentLab.SegmentClockSeparator segmentClockSeparator4 = new Mitov.InstrumentLab.SegmentClockSeparator();
            Mitov.SignalLab.ElementSize elementSize32 = new Mitov.SignalLab.ElementSize();
            Mitov.InstrumentLab.DigitalClockSection digitalClockSection3 = new Mitov.InstrumentLab.DigitalClockSection();
            Mitov.InstrumentLab.SegmentClockSeparator segmentClockSeparator5 = new Mitov.InstrumentLab.SegmentClockSeparator();
            Mitov.SignalLab.ElementSize elementSize33 = new Mitov.SignalLab.ElementSize();
            Mitov.InstrumentLab.DigitalClockSection digitalClockSection4 = new Mitov.InstrumentLab.DigitalClockSection();
            Mitov.InstrumentLab.SegmentClockSeparator segmentClockSeparator6 = new Mitov.InstrumentLab.SegmentClockSeparator();
            Mitov.SignalLab.ElementSize elementSize34 = new Mitov.SignalLab.ElementSize();
            Mitov.InstrumentLab.Segment segment2 = new Mitov.InstrumentLab.Segment();
            Mitov.SignalLab.ElementSize elementSize35 = new Mitov.SignalLab.ElementSize();
            Mitov.InstrumentLab.InactiveColor inactiveColor2 = new Mitov.InstrumentLab.InactiveColor();
            Mitov.SignalLab.ElementSize elementSize36 = new Mitov.SignalLab.ElementSize();
            this.buttonConnect = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.comboBoxSerial = new System.Windows.Forms.ComboBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.buttonDisconnect = new System.Windows.Forms.Button();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.textBoxIncomingData = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.serialPort = new System.IO.Ports.SerialPort(this.components);
            this.segmentClock1 = new Mitov.InstrumentLab.SegmentClock(this.components);
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.groupBox3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.segmentClock1)).BeginInit();
            this.SuspendLayout();
            // 
            // buttonConnect
            // 
            this.buttonConnect.Location = new System.Drawing.Point(156, 22);
            this.buttonConnect.Name = "buttonConnect";
            this.buttonConnect.Size = new System.Drawing.Size(75, 23);
            this.buttonConnect.TabIndex = 0;
            this.buttonConnect.Text = "Connect";
            this.buttonConnect.UseVisualStyleBackColor = true;
            this.buttonConnect.Click += new System.EventHandler(this.buttonConnect_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(6, 27);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(57, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "Port Name";
            // 
            // comboBoxSerial
            // 
            this.comboBoxSerial.FormattingEnabled = true;
            this.comboBoxSerial.Location = new System.Drawing.Point(69, 24);
            this.comboBoxSerial.Name = "comboBoxSerial";
            this.comboBoxSerial.Size = new System.Drawing.Size(81, 21);
            this.comboBoxSerial.TabIndex = 2;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.buttonDisconnect);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Controls.Add(this.buttonConnect);
            this.groupBox1.Controls.Add(this.comboBoxSerial);
            this.groupBox1.Location = new System.Drawing.Point(12, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(324, 60);
            this.groupBox1.TabIndex = 3;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Serial Port";
            // 
            // buttonDisconnect
            // 
            this.buttonDisconnect.Enabled = false;
            this.buttonDisconnect.Location = new System.Drawing.Point(237, 22);
            this.buttonDisconnect.Name = "buttonDisconnect";
            this.buttonDisconnect.Size = new System.Drawing.Size(75, 23);
            this.buttonDisconnect.TabIndex = 3;
            this.buttonDisconnect.Text = "Disconnect";
            this.buttonDisconnect.UseVisualStyleBackColor = true;
            this.buttonDisconnect.Click += new System.EventHandler(this.buttonDisconnect_Click);
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.textBoxIncomingData);
            this.groupBox2.Controls.Add(this.label2);
            this.groupBox2.Location = new System.Drawing.Point(12, 78);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(729, 60);
            this.groupBox2.TabIndex = 4;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Serial Data";
            // 
            // textBoxIncomingData
            // 
            this.textBoxIncomingData.Location = new System.Drawing.Point(88, 24);
            this.textBoxIncomingData.Name = "textBoxIncomingData";
            this.textBoxIncomingData.Size = new System.Drawing.Size(635, 20);
            this.textBoxIncomingData.TabIndex = 1;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(6, 27);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(76, 13);
            this.label2.TabIndex = 0;
            this.label2.Text = "Incoming Data";
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.dataGridView1);
            this.groupBox3.Location = new System.Drawing.Point(12, 144);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(729, 286);
            this.groupBox3.TabIndex = 5;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Database View";
            // 
            // dataGridView1
            // 
            this.dataGridView1.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(9, 19);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.Size = new System.Drawing.Size(714, 261);
            this.dataGridView1.TabIndex = 0;
            // 
            // serialPort
            // 
            this.serialPort.DataReceived += new System.IO.Ports.SerialDataReceivedEventHandler(this.serialPort_DataReceived);
            // 
            // segmentClock1
            // 
            this.segmentClock1.Color = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(0)))));
            elementSize19.Value = 0.1F;
            decimalPointOffset2.Bottom = elementSize19;
            elementSize20.Value = 0.04F;
            decimalPointOffset2.Right = elementSize20;
            decimalPointSegment2.Offset = decimalPointOffset2;
            elementSize21.Value = 0.13F;
            decimalPointSegment2.Size = elementSize21;
            decimalPointSegment2.Visible = false;
            this.segmentClock1.DecimalPoint = decimalPointSegment2;
            elementSize22.Value = 0.1F;
            segmentIndents2.Bottom = elementSize22;
            elementSize23.Value = 0.1F;
            segmentIndents2.Left = elementSize23;
            elementSize24.Value = 0.1F;
            segmentIndents2.Right = elementSize24;
            elementSize25.Value = 0.1F;
            segmentIndents2.Top = elementSize25;
            this.segmentClock1.Indents = segmentIndents2;
            sinkPin2.ConnectionData = ((OpenWire.PinConnections)(resources.GetObject("sinkPin2.ConnectionData")));
            this.segmentClock1.InputPin = sinkPin2;
            this.segmentClock1.InternalData = ((Vcl.VclBinaryData)(resources.GetObject("segmentClock1.InternalData")));
            this.segmentClock1.Location = new System.Drawing.Point(497, 12);
            this.segmentClock1.Name = "segmentClock1";
            this.segmentClock1.Rotation = rotation2;
            elementSize26.Value = 0.1F;
            pointOffset3.Left = elementSize26;
            elementSize27.Value = 0.7F;
            pointOffset3.Top = elementSize27;
            digitalAmPmSection2.AmPosition = pointOffset3;
            segmentFont2.InternalData = ((Vcl.VclBinaryData)(resources.GetObject("segmentFont2.InternalData")));
            segmentFont2.Name = "Microsoft Sans Serif";
            elementSize28.Value = 0.3F;
            segmentFont2.Size = elementSize28;
            digitalAmPmSection2.Font = segmentFont2;
            elementSize29.Value = 0.1F;
            pointOffset4.Left = elementSize29;
            elementSize30.Value = 0.2F;
            pointOffset4.Top = elementSize30;
            digitalAmPmSection2.PmPosition = pointOffset4;
            digitalAmPmSection2.Visible = false;
            elementSize31.Value = 0.6F;
            digitalAmPmSection2.Width = elementSize31;
            digitalClockSections2.AmPm = digitalAmPmSection2;
            digitalHourSection2.Visible = true;
            digitalClockSections2.Hours = digitalHourSection2;
            millisecondsClockSection2.NumberDigits = ((uint)(3u));
            segmentClockSeparator4.Visible = true;
            elementSize32.Value = 0.3F;
            segmentClockSeparator4.Width = elementSize32;
            millisecondsClockSection2.Separator = segmentClockSeparator4;
            digitalClockSections2.Milliseconds = millisecondsClockSection2;
            segmentClockSeparator5.Visible = true;
            elementSize33.Value = 0.3F;
            segmentClockSeparator5.Width = elementSize33;
            digitalClockSection3.Separator = segmentClockSeparator5;
            digitalClockSection3.Visible = true;
            digitalClockSections2.Minutes = digitalClockSection3;
            segmentClockSeparator6.Visible = true;
            elementSize34.Value = 0.3F;
            segmentClockSeparator6.Width = elementSize34;
            digitalClockSection4.Separator = segmentClockSeparator6;
            digitalClockSection4.Visible = true;
            digitalClockSections2.Seconds = digitalClockSection4;
            this.segmentClock1.Sections = digitalClockSections2;
            segment2.CenterColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(0)))));
            segment2.Color = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(255)))), ((int)(((byte)(0)))));
            elementSize35.Value = 0.01F;
            segment2.Gap = elementSize35;
            segment2.InactiveColor = inactiveColor2;
            elementSize36.Value = 0.13F;
            segment2.Width = elementSize36;
            this.segmentClock1.Segments = segment2;
            this.segmentClock1.Size = new System.Drawing.Size(238, 60);
            this.segmentClock1.TabIndex = 6;
            this.segmentClock1.Text = "segmentClock1";
            this.segmentClock1.Value = new System.DateTime(1899, 12, 30, 0, 0, 0, 0);
            // 
            // timer1
            // 
            this.timer1.Enabled = true;
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(753, 439);
            this.Controls.Add(this.segmentClock1);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "MainForm";
            this.Text = "Sistem Absensi Menggunakan RFID";
            this.Load += new System.EventHandler(this.MainForm_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.groupBox3.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.segmentClock1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button buttonConnect;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox comboBoxSerial;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button buttonDisconnect;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.TextBox textBoxIncomingData;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.IO.Ports.SerialPort serialPort;
        private System.Windows.Forms.DataGridView dataGridView1;
        private Mitov.InstrumentLab.SegmentClock segmentClock1;
        private System.Windows.Forms.Timer timer1;
    }
}


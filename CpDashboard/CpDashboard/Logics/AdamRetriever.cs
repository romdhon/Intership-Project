using Advantech.Adam;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Web;

namespace CpDashboard.Logics
{
    public class AdamRetriever
    {
        private bool m_bStart;
        private AdamSocket adamModbus, adamUDP;
        private Adam6000Type m_Adam6000Type;
        private string m_szIP;
        private string m_szFwVersion;
        const int m_Adam6000NewerFwVer = 5;
        private int m_DeviceFwVer = 4;
        private int m_iPort;
        private int m_iCount;
        private int m_iAiTotal, m_iDoTotal;
        private bool[] m_bChEnabled;
        private ushort[] m_usRange; //for newer version
        public int sensorNumber;
        private Dictionary<string, string> sensorValues = new Dictionary<string, string>();
        private string sensorStatus = "";

        public AdamRetriever(int sensorNum)
        {
            sensorStatus = "false";
            sensorNumber = sensorNum;
            m_bStart = false;			// the action stops at the beginning
            m_szIP = "192.168.10.10";	// modbus slave IP address
            m_iPort = 502;				// modbus TCP port is 502
            adamModbus = new AdamSocket();
            adamModbus.SetTimeout(1000, 1000, 1000); // set timeout for TCP
            adamUDP = new AdamSocket();
            adamUDP.SetTimeout(1000, 1000, 1000); // set timeout for UDP

            m_Adam6000Type = Adam6000Type.Adam6015; // the sample is for ADAM-6015

            adamUDP.Connect(AdamType.Adam6000, m_szIP, ProtocolType.Udp);
            if (adamUDP.Configuration().GetFirmwareVer(out m_szFwVersion))
                m_DeviceFwVer = int.Parse(m_szFwVersion.Trim().Substring(0, 1));
            adamUDP.Disconnect();

            m_iAiTotal = AnalogInput.GetChannelTotal(m_Adam6000Type);
            m_iDoTotal = DigitalOutput.GetChannelTotal(m_Adam6000Type);

            //txtModule.Text = m_Adam6000Type.ToString();
            m_bChEnabled = new bool[m_iAiTotal];

            //firmware version
            //fwversion.Text = m_DeviceFwVer.ToString();

            if (m_DeviceFwVer > m_Adam6000NewerFwVer)
            {
                m_usRange = new ushort[m_iAiTotal];
            }

            // start the retrieving datas and save to db;
            startRetrieving();
        }

        private void startRetrieving()
        {
            if (adamModbus.Connect(m_szIP, ProtocolType.Tcp, m_iPort))
            {
                m_iCount = 0; // reset the reading counter
                m_bStart = true; // starting flag

                if (m_DeviceFwVer > m_Adam6000NewerFwVer)
                {
                    //for newer version
                    if (m_Adam6000Type == Adam6000Type.Adam6017 ||
                        m_Adam6000Type == Adam6000Type.Adam6018)
                        RefreshChannelRangeUshortFormat(7);
                    RefreshChannelRangeUshortFormat(6);
                    RefreshChannelRangeUshortFormat(5);
                    RefreshChannelRangeUshortFormat(4);
                    RefreshChannelRangeUshortFormat(3);
                    RefreshChannelRangeUshortFormat(2);
                    RefreshChannelRangeUshortFormat(1);
                    RefreshChannelRangeUshortFormat(0);
                }
                RefreshChannelEnabled();
                //SetTimer();
                //aTimer.Start();
                RefreshChannelValueUshortFormat();

            }

        }
        private void RefreshChannelRangeUshortFormat(int i_iChannel)
        {
            //for newer version
            ushort usRange;
            if (adamModbus.AnalogInput().GetInputRange(i_iChannel, out usRange))
                m_usRange[i_iChannel] = usRange;

        }

        private void RefreshChannelEnabled()
        {
            bool[] bEnabled;

            if (adamModbus.AnalogInput().GetChannelEnabled(m_iAiTotal, out bEnabled))
            {
                Array.Copy(bEnabled, 0, m_bChEnabled, 0, m_iAiTotal);
            }
        }

        private void RefreshChannelValueUshortFormat()
        {
            int iStart = 1, iAiStatusStart = 101;
            int iIdx;
            int[] iData, iAiStatus;
            float[] fValue = new float[m_iAiTotal];

            if (adamModbus.Modbus().ReadInputRegs(iStart, m_iAiTotal, out iData))
            {
                sensorValues.Clear();
                for (iIdx = 0; iIdx < m_iAiTotal; iIdx++)
                {
                    fValue[iIdx] = AnalogInput.GetScaledValue(m_Adam6000Type, m_usRange[iIdx], (ushort)iData[iIdx]);
                }

                if (adamModbus.Modbus().ReadInputRegs(iAiStatusStart, (m_iAiTotal * 2), out iAiStatus))
                {
                    // store data to db
                    //AddToDb(DateTime.Now, fValue[0], 0);
                    //AddToDb(DateTime.Now, fValue[1], 1);
                    //AddToDb(DateTime.Now, fValue[2], 2);
                    //AddToDb(DateTime.Now, fValue[3], 3);
                    for(int num=0; num < sensorNumber; num++)
                    {
                        sensorValues.Add("sensor"+(num+1), fValue[num].ToString());
                    }
                    sensorValues.Add("timeOperate", DateTime.Now.ToString("HH:mm:ss"));
                    sensorStatus = "true";
                }
                adamModbus.Disconnect();
            }
        }

        public Dictionary<string, string> getAllValues()
        {
            return sensorValues;
        }

        public string getSensorStatus()
        {
            return sensorStatus;
        }
    }
}
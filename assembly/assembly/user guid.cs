using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;

namespace assembly
{
    public partial class user_guid : Form
    {
        public user_guid()
        {
            InitializeComponent();
        }

        private void user_guid_Load(object sender, EventArgs e)
        {
            string curDir = Directory.GetCurrentDirectory();
            this.webBrowser1.Url = new Uri(String.Format("file:///{0}/user_guid.htm", curDir));
        }
    }
}

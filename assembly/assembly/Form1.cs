using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.IO;
using System.Windows.Forms;

namespace assembly
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string[] instr_line = assembly.Text.Split('\n');

            string[] splitpoint = assembly.Text.Split(':');

            int lablenumber = splitpoint.Length - 1; // lable number have number of lables in the code

            string[,] labletable = new string[lablenumber, 2];

            int lablepointer = 0;

            string[,] instsplit = new string[instr_line.Length, 4];
            // the first loop to count the number of empty rows in the first array
            int u = 0;
            for (int w = 0; w < instr_line.Length; w++)
            {
                if (instr_line[w] != "")
                {
                u++;

                }
            }
            // The number of rows without the empty ones 
                string[] instructions=new string[u];

                  u = 0;
                 for (int w = 0; w < instr_line.Length; w++)
                 {
                     if (instr_line[w] != "")
                     {

                         instructions[u] = instr_line[w];
                         u++;
                     }
                 }
           
            // number of true insturusins 
            // this for loop will make a 2 d matrix have the instruction parameter in its first colume 

            for (int i = 0; i < instructions.Length; i++)
            {
                //spliting the lables

                string[] ltemp = instructions[i].Split(':');
                
                if (ltemp.Length == 2)
                {
                    
                    instructions[i] = ltemp[1];
                    labletable[lablepointer, 0] = ltemp[0];
                    labletable[lablepointer, 1] = (i*4).ToString();

                    lablepointer++;

                }
                
               
                if (instructions[i] != "")
                {
                    string[] temp = instructions[i].Split(' ');

                    int j = 0;


                    while (temp[j] == "")
                    {
                        j++;
                    }

                    instsplit[i, 0] = temp[j];

                    string parameters = "";

                    for (int x = j + 1; x < temp.Length; x++)
                    {
                        parameters += temp[x];
                    }

                    string[] paramt = parameters.Split(',');

                    for (int y = 0; y < paramt.Length; y++)
                    {
                        instsplit[i, y + 1] = paramt[y];
                    }


                }
            }
            string[,] binary = new string[instructions.Length, 6];

            for (int i = 0; i < instructions.Length; i++)
            {
                switch(instsplit[i, 0])
                {
                    case "add":
                         binary[i, 0] = "000000";//op code
                         binary[i, 1] = get_reg(instsplit[i, 2]); //rs
                         binary[i, 2] = get_reg(instsplit[i, 3]);//rt
                         binary[i, 3] = get_reg(instsplit[i, 1]);//
                         binary[i, 4] = "00000";//shift amount
                         binary[i, 5] = "100000";// function
                        break;

                    case "sub":
                        binary[i, 0] = "000000";
                        binary[i, 5] = "100010";
                        binary[i, 4] = "00000";
                        binary[i, 1] = get_reg(instsplit[i, 2]);
                        binary[i, 2] = get_reg(instsplit[i, 3]);
                        binary[i, 3] = get_reg(instsplit[i, 1]);
                        break;


                    case "lw" :
                        string temp1 = instsplit[i, 2];

                        string[] temp2 = temp1.Split('(');// temp2[0] = immediate
                        string[] temp3 = temp2[1].Split(')');// temp3[0] = rs
                        binary[i, 0] = "100011";
                        binary[i, 1] = get_reg(temp3[0]);
                        binary[i, 2] = get_reg(instsplit[i, 1]);
                        binary[i, 3] = Extend2(Convert.ToInt16(temp2[0]),16);
                        break;

                    case "sw":
                        string temp11 = instsplit[i, 2];

                        string[] temp22 = temp11.Split('(');// temp2[0] = immediate
                        string[] temp33 = temp22[1].Split(')');// temp3[0] = rs
                        binary[i, 0] = "101011";
                        binary[i, 1] = get_reg(temp33[0]);
                        binary[i, 2] = get_reg(instsplit[i, 1]);
                        binary[i, 3] = Extend2(Convert.ToInt16(temp22[0]), 16);
                        break;

                    case "beq" :
                        binary[i, 0] = "000100";
                        binary[i, 1] = get_reg(instsplit[i, 1]);
                        binary[i, 2] = get_reg(instsplit[i, 2]);
                        string addr= "";
                        for (int l = 0; l < lablenumber; l++)
                        {
                            if (labletable[l, 0] == instsplit[i, 3])
                            {
                                addr = labletable[l, 1];
                            }
                        }
                        binary[i, 3] = Extend2((Convert.ToInt32(addr) - (4 * i)),16);
                        break;

                    case "j" :
                        binary[i, 0] = "000010";
                        string addr1= "";
                        for (int l1 = 0; l1 < lablenumber; l1++)
                        {
                            if (labletable[l1, 0] == instsplit[i, 1])
                            {
                                addr1 = labletable[l1, 1];
                            }
                        }
                        binary[i, 1] = Extend2(Convert.ToInt16(addr1), 26);

                        break;

                    case "addi" :
                        binary[i, 0] = "001000";
                        binary[i, 1] = get_reg(instsplit[i, 2]); //rs
                         binary[i, 2] = get_reg(instsplit[i, 1]);//rt
                         binary[i, 3] = Extend2(Convert.ToInt32( instsplit[i, 3]), 16);
                         break;

                    case "and" :

                         binary[i, 0] = "000000";//op code
                         binary[i, 1] = get_reg(instsplit[i, 2]); //rs
                         binary[i, 2] = get_reg(instsplit[i, 3]);//rt
                         binary[i, 3] = get_reg(instsplit[i, 1]);//
                         binary[i, 4] = "00000";//shift amount
                         binary[i, 5] = "100100";// function
                         break;

                    case "or" :
                        
                         binary[i, 0] = "000000";//op code
                         binary[i, 1] = get_reg(instsplit[i, 2]); //rs
                         binary[i, 2] = get_reg(instsplit[i, 3]);//rt
                         binary[i, 3] = get_reg(instsplit[i, 1]);//
                         binary[i, 4] = "00000";//shift amount
                         binary[i, 5] = "100101";// function
                         break;
                         
                    case "nor" :
                         
                         binary[i, 0] = "000000";//op code
                         binary[i, 1] = get_reg(instsplit[i, 2]); //rs
                         binary[i, 2] = get_reg(instsplit[i, 3]);//rt
                         binary[i, 3] = get_reg(instsplit[i, 1]);//
                         binary[i, 4] = "00000";//shift amount
                         binary[i, 5] = "100111";// function
                         break;

                    case "ori" :
                         binary[i, 0] = "001101";
                         binary[i, 1] = get_reg(instsplit[i, 2]); //rs
                         binary[i, 2] = get_reg(instsplit[i, 1]);//rt
                         binary[i, 3] = Extend2(Convert.ToInt32( instsplit[i, 3]), 16);
                         break;

                    case"andi" :
                         binary[i, 0] = "001100";
                         binary[i, 1] = get_reg(instsplit[i, 2]); //rs
                         binary[i, 2] = get_reg(instsplit[i, 1]);//rt
                         binary[i, 3] = Extend2(Convert.ToInt32( instsplit[i, 3]), 16);
                         break;

                    case "sll" : 
                         binary[i, 0] = "000000";//op code
                         binary[i, 1] = "00000"; //rs
                         binary[i, 2] = get_reg(instsplit[i, 2]);//rt
                         binary[i, 3] = get_reg(instsplit[i, 1]); //rd
                         binary[i, 4] = Extend2(Convert.ToInt32(instsplit[i,3]),5); //shift amount
                         binary[i, 5] = "000000";// function

                         break;

                    case"jal" :
                         binary[i, 0] = "000011";
                         string addr3= "";
                        for (int l4 = 0; l4 < lablenumber; l4++)
                        {
                            if (labletable[l4, 0] == instsplit[i, 1])
                            {
                                addr3 = labletable[l4, 1];
                            }
                        }
                        binary[i, 1] = Extend2(Convert.ToInt16(addr3),26);
                        break;
                        
                    case "jr" :
                        binary[i, 0] = "000000";
                        binary[i, 1] = get_reg(instsplit[i, 1]);
                        binary[i, 2] = "00000";
                        binary[i ,3] = "00000";
                        binary[i, 4] = "00000";
                        binary[i, 5] = "001000";
                        break;

                    case"slt" :
                        binary[i, 0] = "000000";
                        binary[i, 1] = get_reg(instsplit[i, 2]); //rs
                         binary[i, 2] = get_reg(instsplit[i, 3]);//rt
                         binary[i, 3] = get_reg(instsplit[i, 1]);//
                         binary[i, 4] = "00000";//shift amount
                         binary[i, 5] = "101010";// function
                        break;
                        
                        
                        
                        
                        
                }

                asmbly_out.Text += binary[i, 0];

              
                asmbly_out.Text += binary[i, 1];

               

                asmbly_out.Text += binary[i, 2];

             

                asmbly_out.Text += binary[i, 3];

                asmbly_out.Text += binary[i, 4];

               

                asmbly_out.Text += binary[i, 5];



                asmbly_out.Text += "\n";
              
            }

            // end


           
          
        }
        public string get_reg(string reg)
         {
             string[] codes = new string[32];

             codes[0] = "$zero";
             codes[1] = "$at";
             codes[2] = "$v0";
             codes[3] = "$v1";
             codes[4] = "$a0";
             codes[5] = "$a1";
             codes[6] = "$a2";
             codes[7] = "$a3";
             codes[8] = "$t0";
             codes[9] = "$t1";
             codes[10] = "$t2";
             codes[11] = "$t3";
             codes[12] = "$t4";
             codes[13] = "$t5";
             codes[14] = "$t6";
             codes[15] = "$t7";
             codes[16] = "$s0";
             codes[17] = "$s1";
             codes[18] = "$s2";
             codes[19] = "$s3";
             codes[20] = "$s4";
             codes[21] = "$s5";
             codes[22] = "$s6";
             codes[23] = "$s7";
             codes[24] = "$t8";
             codes[25] = "$t9";
             codes[26] = "$k0";
             codes[27] = "$k1";
             codes[28] = "$gp";
             codes[29] = "$sp";
             codes[30] = "$fp";
             codes[31] = "$ra";
             int v = 0;
             for (int y = 0; y < codes.Length; y++)
                 if (reg == codes[y])
                 {
                     v =y;

                 }
            
             string x = Convert.ToString(v, 2);

             if (x.Length == 4)
             {
                 x = "0" + x;
             }
             if (x.Length == 3)
             {
                 x = "00" + x;
             }
             if (x.Length == 2)
             {
                 x = "000" + x;
             }
             if (x.Length == 1)
             {
                 x = "0000" + x;
             }
            
         
             return x; ;  

             

         }

        private void button2_Click(object sender, EventArgs e)
        {
            asmbly_out.Text = "";

        }
        public string Extend2(int x, int y) {

            string xBinary = Convert.ToString(x, 2);

            int diff = y - xBinary.Length;
            string output = "";
            for (int i = 0; i < diff; i++) {

                if (x >= 0)
                {
                output += "0";
                }
             

            }
            if (x < 0)
            {
                output = xBinary.Substring(xBinary.Length - y, y);
            }
            else
            {
                output = output + xBinary;
            }

            return output;
        
        }

        private void button3_Click(object sender, EventArgs e)
        {
            SaveFileDialog saveFileDialog1 = new SaveFileDialog();
            saveFileDialog1.Filter = "maradona Files|*.maradon";
            saveFileDialog1.Title = "Save a maradona File";
            saveFileDialog1.ShowDialog();

            if (saveFileDialog1.FileName != "")
            {

                using (StreamWriter outfile = new StreamWriter(saveFileDialog1.FileName))
                {
                    string[] tt = asmbly_out.Text.Split('\n');
                    for (int i = 0; i < tt.Length; i++)
                    {
                        outfile.WriteLine(tt[i]);
                    }
                    outfile.Close();
                }
            }
            
        }

       

        
    }
}

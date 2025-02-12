using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DoAnMon
{
    public partial class Trangchu : Form
    {
        public Trangchu()
        {
            InitializeComponent();
            LoadData(); // Gọi hàm tải dữ liệu
        }

        private void checkBox2_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            // Tạo cột cho DataTable
            dtProducts.Columns.Add("ID");
            dtProducts.Columns.Add("Tên Sản Phẩm");
            dtProducts.Columns.Add("Giá");

            // Thêm dữ liệu mẫu
            dtProducts.Rows.Add("SP001", "Laptop Dell", "15,000,000");
            dtProducts.Rows.Add("SP002", "iPhone 13", "20,000,000");
            dtProducts.Rows.Add("SP003", "Chuột Logitech", "500,000");
            dtProducts.Rows.Add("SP004", "Bàn phím cơ", "1,500,000");

            // Gán dữ liệu cho DataGridView
            dataGridView1.DataSource = dtProducts;
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim().ToLower();
            (dataGridView1.DataSource as DataTable).DefaultView.RowFilter =
                $"[Tên Sản Phẩm] LIKE '%{keyword}%' OR [ID] LIKE '%{keyword}%'";
        }
    }
}

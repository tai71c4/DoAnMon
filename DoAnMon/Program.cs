using System;
using System.Windows.Forms;
using DoAnMon; // Đảm bảo namespace này được thêm vào

namespace DoAnMon
{
    internal static class Program
    {
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Trangchu()); // Đảm bảo class này tồn tại
        }
    }
}

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WFA_Consume_WebApi_Rest
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            int qtdTotalRegistros = 0;
            FiltroEstabelecimentos filtroEstab = new FiltroEstabelecimentos();
            filtroEstab.tipo = 3;
            filtroEstab.valor = "123456787";// "22628842000125"; //strDocumentoMatriz;// MerchantNumberUsuarioLogado.ToString();

            ServicoAntecipacao servicoAntecipacao = new ServicoAntecipacao();
            List<Estabelecimento> retorno = new List<Estabelecimento>();

            retorno = servicoAntecipacao.ListarCentrais(filtroEstab, ref qtdTotalRegistros).ToList();

            textBox1.Text = retorno.ToString();
        }
    }
}

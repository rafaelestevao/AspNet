using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RestService_Example.Models
{
    public class MensagemModel
    {
        private int Codigo;
        private string Mensagem;

        public MensagemModel()
        {
        }

        public MensagemModel(int Codigo, string Mensagem)
        {
            this.codigo = Codigo;
            this.mensagem = Mensagem;
        }

        public int codigo
        {
            get
            {
                return Codigo;
            }

            set
            {
                Codigo = value;
            }
        }

        public string mensagem
        {
            get
            {
                return Mensagem;
            }

            set
            {
                Mensagem = value;
            }
        }
    }
}
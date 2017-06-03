using System.Threading.Tasks;

namespace MonkeyHubApp.ViewModels
{
    public class MainViewModel : BaseViewModel
    {
        private string _descricao;
        public string Descricao
        {
            get { return _descricao; }
            set { SetProperty(ref _descricao, value); }
        }

        private string _nome;
        public string Nome
        {
            get { return _nome; }
            set { SetProperty(ref _nome, value); }
        }

        private int _idade;

        public int Idade
        {
            get { return _idade; }
            set { SetProperty(ref _idade, value); }
        }


        public MainViewModel()
        {
            Descricao = "Olá mundo, eu estou aqui";
            Nome = "Raissa andrade";

            Task.Delay(3000).ContinueWith(async t =>
            {
                Descricao = "Raissa está aqui jogando massinha!";
                Nome = "Raissa Andrade Estevão";

                for (int i = 0; i <=10; i++)
                {
                    await Task.Delay(1000);
                    Descricao = $"Texto mudou novamente {i}";
                }
            }
            );
        }
    }
}
